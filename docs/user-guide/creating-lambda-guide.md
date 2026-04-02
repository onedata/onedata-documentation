# Creating a Lambda: File Checksum Example

This guide shows how to implement a custom lambda for the Onedata automation system.

In general, creating a lambda requires following a specific structure and interface
expected by the automation runtime. A lambda must define the required data types,
provide the `handle` entry point, and process jobs in the format used by the system.

To make the concepts easier to understand, this guide walks through a practical example.
We will implement a lambda that calculates a checksum for a file and stores the result
as file metadata.

## Create a Python file with the required structure

Start by creating a directory for your lambda files. Then create a Python file that will contain the lambda logic.
This file must be named `handler.py`.

### Structure of handler.py

The `handler.py` file should be organized into a few clear sections. Keeping this structure makes the lambda easier to understand and maintain.

1. **Required imports**  
   Import all Python modules and utilities needed by the lambda.  
   This typically includes standard libraries and `onedata_lambda_utils` package.

2. **Lambda configuration**  
   Define constants that control how the lambda behaves.

3. **Lambda interface**  
   Define the entry point expected by the Onedata lambda runtime.  
   This is the function that receives the event payload and starts the lambda execution.

4. **Lambda implementation**  
   Implement the actual logic of the lambda.  
   In this example, this includes reading the file, calculating its checksum, and storing the result in file metadata.

### Required imports

Place all required imports at the top of the `handler.py` file.  
These imports include standard Python libraries, utilities used for checksum
calculation, threading tools, and types required by the Onedata lambda interface.

```python
import concurrent.futures
import hashlib
import os
import sys
import traceback
import zlib
from threading import Event, Thread
from typing import Final, FrozenSet, Literal, NamedTuple, Optional, Union, get_args

import xattr
from onedata_lambda_utils.types import (
    AtmException,
    AtmFile,
    AtmHeartbeatCallback,
    AtmJobBatchRequest,
    AtmJobBatchRequestCtx,
    AtmJobBatchResponse,
)

if sys.version_info < (3, 11):
    from typing_extensions import TypeAlias, TypedDict
else:
    from typing import TypeAlias, TypedDict
```

### Lambda configuration

Define the following constants:

1. **Mount point** – the path where Oneclient mounts spaces.  
2. **Read chunk size** – the size of file chunks used during checksum calculation.  
3. **Available checksum algorithms** – the list of supported checksum algorithms that users can choose from.  

```python
MOUNT_POINT: Final[str] = "/mnt/onedata"
READ_CHUNK_SIZE: Final[int] = 10 * 1024**2

ChecksumAlgorithm: TypeAlias = Literal[
    "adler32",
    "md5",
    "sha256",
]

AVAILABLE_CHECKSUM_ALGORITHMS: Final[FrozenSet[ChecksumAlgorithm]] = frozenset(
    get_args(ChecksumAlgorithm)
)
```

### Lambda interface

Next, define the object types used by the lambda interface.
These types describe the input data, configuration, processing result, and possible errors.

In this example, most of them are defined as `TypedDict` to clearly describe the 
expected data structure. The `Job` object is defined as a `NamedTuple`, because it 
additionally should remain unchanged during the entire processing.

The following types are used:

1. **TaskConfig** – stores the task configuration passed to the lambda.  
   In this example, it contains the selected checksum algorithm and 
   the metadata key where the result will be saved.

2. **JobArgs** – stores the input arguments for a single job.  
   Here, it contains the file that should be processed.

3. **FileChecksumReport** – stores the result for a single processed file.  
   It includes the file ID, the algorithm used, and the calculated checksum value.

4. **JobResults** – wraps the result returned for a single processed item.  
   In this example, it contains a single `result` field with the checksum report.

5. **JobException** – defines a custom exception that can be raised during job processing.  
   This makes it easier to clearly signal processing errors in your implementation.

6. **Job** – represents a single item processed by the lambda.  
   It combines the batch context (`ctx`) with the input arguments (`args`).

```python
class TaskConfig(TypedDict):
    algorithm: ChecksumAlgorithm
    metadataKey: str


class JobArgs(TypedDict):
    file: AtmFile


class FileChecksumReport(TypedDict):
    fileId: str
    algorithm: str
    checksum: Optional[str]


class JobResults(TypedDict):
    result: FileChecksumReport


class JobException(Exception):
    pass


class Job(NamedTuple):
    ctx: AtmJobBatchRequestCtx[TaskConfig]
    args: JobArgs
```

### Lambda implementation

Each lambda must implement a function called `handle`.  
This function is the main entry point and is invoked by the Onedata automation executor.

The function signature must be exactly as follows:

```python
def handle(
    job_batch_request: AtmJobBatchRequest,
    heartbeat_callback: AtmHeartbeatCallback,
) -> AtmJobBatchResponse
```

The arguments are:

**`job_batch_request`**  
The main input passed to the lambda. It is a JSON object containing:

- **`ctx`** – the context of the job batch request (for example task configuration and execution metadata).
- **`argsBatch`** – a list of JSON objects, where each object contains the input arguments for a single job.

**`heartbeat_callback`**  
A callback used to inform the Onedata automation system that the lambda is still running.  
It should be called periodically during longer processing to prevent the execution from being considered stalled.

The `handle` function must return an object of type `AtmJobBatchResponse`.

This is a JSON object containing:

- **`resultsBatch`** – a list of JSON objects, where each object contains the result 
of a single processed job (the lambda output).

During lambda execution you may encounter situations that would normally raise an exception.
Instead of letting the exception propagate, you can return an `AtmException`. This allows the
automation system to properly record and report the failure.

Below is an example structure of the `handle` implementation.

#### 1. Validate the input

First, verify that the provided configuration is supported by the lambda implementation.
In this example, it means checking whether the checksum algorithm specified in the request
is supported by the lambda.

If the algorithm is not supported, the lambda can immediately stop processing and return
an appropriate error. This prevents unnecessary work on incompatible input.

```python
algorithm = job_batch_request["ctx"]["config"]["algorithm"]
if algorithm not in AVAILABLE_CHECKSUM_ALGORITHMS:
    return AtmException(
        exception=(
            f"{algorithm} algorithm is unsupported. "
            f"Available ones are: {AVAILABLE_CHECKSUM_ALGORITHMS}"
        )
    )
```

#### 2. Periodically report that the lambda is still running

For longer-running executions, the lambda should periodically call `heartbeat_callback`
to inform the automation system that the job is still in progress.
One way to implement this is by starting a separate monitoring thread.

```python
_all_jobs_processed: Event = Event()


def handle():
    ...
    jobs_monitor = Thread(target=monitor_jobs, daemon=True, args=[heartbeat_callback])
    jobs_monitor.start()
    ...
```

```python
def monitor_jobs(heartbeat_callback: AtmHeartbeatCallback) -> None:
    any_job_ongoing = True
    while any_job_ongoing:
        any_job_ongoing = not _all_jobs_processed.wait(timeout=1)
        heartbeat_callback()
```

#### 3. Process all items in the batch

Each item in the batch represents an independent job. Because of that, they can be processed
concurrently to improve performance.

```python
jobs = [
    Job(args=job_args, ctx=job_batch_request["ctx"])
    for job_args in job_batch_request["argsBatch"]
]

with concurrent.futures.ThreadPoolExecutor() as executor:
    job_results = list(executor.map(run_job, jobs))
```

#### 4. Implement the job processing logic

The `run_job` function contains the actual processing logic for a single item.

```python
def run_job(job: Job) -> Union[AtmException, JobResults]:
    file_path = build_file_path(job)

    if not os.path.isfile(file_path):
        return build_job_results(job, None)

    try:
        algorithm = job.ctx["config"]["algorithm"]
        checksum = calculate_checksum(algorithm, file_path)

        if xattr_name := job.ctx["config"]["metadataKey"]:
            set_file_checksum_xattr(file_path, xattr_name, checksum)
    except JobException as ex:
        return AtmException(exception=str(ex))
    except Exception:
        return AtmException(exception=traceback.format_exc())
    else:
        return build_job_results(job, checksum)
```

Because the lambda uses Oneclient space mounting, files can be accessed as if they were
stored on the local filesystem. The function calculates the checksum of the file and
optionally stores it as an extended attribute (`xattr`).

If an error occurs, the function returns `AtmException` with a descriptive message or traceback.
If the processing succeeds, it returns a `JobResults` object.

**Build the file path**

```python
def build_file_path(job: Job) -> str:
    return f'{MOUNT_POINT}/.__onedata__file_id__{job.args["file"]["fileId"]}'
```

The file path can be constructed either from the file path itself or from the file ID.
This example uses the file ID because it is more efficient due to internal Onedata mechanisms.

**Build job results**

```python
def build_job_results(job: Job, checksum: Optional[str]) -> JobResults:
    return {
        "result": {
            "fileId": job.args["file"]["fileId"],
            "algorithm": job.ctx["config"]["algorithm"],
            "checksum": checksum,
        }
    }
```

This helper function creates the output structure according to the `JobResults` definition.

**Calculate checksum**

```python
def calculate_checksum(algorithm: ChecksumAlgorithm, file_path: str) -> str:
    with open(file_path, "rb") as fd:
        data_stream = iter(lambda: fd.read(READ_CHUNK_SIZE), b"")

        if algorithm == "adler32":
            value = 1
            for data in data_stream:
                value = zlib.adler32(data, value)
            return format(value, "x")

        data_hash = getattr(hashlib, algorithm)()
        for data in data_stream:
            data_hash.update(data)
        return data_hash.hexdigest()
```

This function calculates the checksum by reading the file in chunks and using Python's
built-in hashing algorithms.

**Set file checksum as xattr**

```python
def set_file_checksum_xattr(file_path: str, xattr_name: str, checksum: str) -> None:
    file_xattrs = xattr.xattr(file_path)

    try:
        file_xattrs.set(xattr_name, str.encode(checksum))
    except Exception as ex:
        raise JobException(
            f"Failed to set xattr {xattr_name}:{checksum} due to: {str(ex)}"
        )
```

This function stores the calculated checksum as a custom extended attribute (`xattr`)
on the file.

### Full implementation example

```python
"""
A lambda which calculates (and saves as metadata) file checksum using mounted Oneclient.

NOTE: This lambda works on any type of file by simply returning `None`
as checksum for anything but regular files.
"""


import concurrent.futures
import hashlib
import os
import sys
import traceback
import zlib
from threading import Event, Thread
from typing import Final, FrozenSet, Literal, NamedTuple, Optional, Union, get_args

import xattr
from onedata_lambda_utils.types import (
    AtmException,
    AtmFile,
    AtmHeartbeatCallback,
    AtmJobBatchRequest,
    AtmJobBatchRequestCtx,
    AtmJobBatchResponse,
)

if sys.version_info < (3, 11):
    from typing_extensions import TypeAlias, TypedDict
else:
    from typing import TypeAlias, TypedDict

    
MOUNT_POINT: Final[str] = "/mnt/onedata"
READ_CHUNK_SIZE: Final[int] = 10 * 1024**2

ChecksumAlgorithm: TypeAlias = Literal[
    "adler32",
    "md5",
    "sha256",
]

AVAILABLE_CHECKSUM_ALGORITHMS: Final[FrozenSet[ChecksumAlgorithm]] = frozenset(
    get_args(ChecksumAlgorithm)
)    


class TaskConfig(TypedDict):
    algorithm: ChecksumAlgorithm
    metadataKey: str


class JobArgs(TypedDict):
    file: AtmFile


class FileChecksumReport(TypedDict):
    fileId: str
    algorithm: str
    checksum: Optional[str]


class JobResults(TypedDict):
    result: FileChecksumReport


class JobException(Exception):
    pass


class Job(NamedTuple):
    ctx: AtmJobBatchRequestCtx[TaskConfig]
    args: JobArgs

    
_all_jobs_processed: Event = Event()    
    

def handle(
    job_batch_request: AtmJobBatchRequest[JobArgs, TaskConfig],
    heartbeat_callback: AtmHeartbeatCallback,
) -> Union[AtmException, AtmJobBatchResponse[JobResults]]:
    algorithm = job_batch_request["ctx"]["config"]["algorithm"]
    if algorithm not in AVAILABLE_CHECKSUM_ALGORITHMS:
        return AtmException(
            exception=(
                f"{algorithm} algorithm is unsupported. "
                f"Available ones are: {AVAILABLE_CHECKSUM_ALGORITHMS}"
            )
        )

    jobs_monitor = Thread(target=monitor_jobs, daemon=True, args=[heartbeat_callback])
    jobs_monitor.start()

    jobs = [
        Job(args=job_args, ctx=job_batch_request["ctx"])
        for job_args in job_batch_request["argsBatch"]
    ]
    with concurrent.futures.ThreadPoolExecutor() as executor:
        job_results = list(executor.map(run_job, jobs))

    _all_jobs_processed.set()
    jobs_monitor.join()

    return {"resultsBatch": job_results}

def run_job(job: Job) -> Union[AtmException, JobResults]:
    file_path = build_file_path(job)

    if not os.path.isfile(file_path):
        return build_job_results(job, None)

    try:
        algorithm = job.ctx["config"]["algorithm"]
        checksum = calculate_checksum(algorithm, file_path)

        if xattr_name := job.ctx["config"]["metadataKey"]:
            set_file_checksum_xattr(file_path, xattr_name, checksum)
    except JobException as ex:
        return AtmException(exception=str(ex))
    except Exception:
        return AtmException(exception=traceback.format_exc())
    else:
        return build_job_results(job, checksum)


def build_file_path(job: Job) -> str:
    return f'{MOUNT_POINT}/.__onedata__file_id__{job.args["file"]["fileId"]}'


def build_job_results(job: Job, checksum: Optional[str]) -> JobResults:
    return {
        "result": {
            "fileId": job.args["file"]["fileId"],
            "algorithm": job.ctx["config"]["algorithm"],
            "checksum": checksum,
        }
    }


def calculate_checksum(algorithm: ChecksumAlgorithm, file_path: str) -> str:
    with open(file_path, "rb") as fd:
        data_stream = iter(lambda: fd.read(READ_CHUNK_SIZE), b"")

        if algorithm == "adler32":
            value = 1
            for data in data_stream:
                value = zlib.adler32(data, value)
            return format(value, "x")

        data_hash = getattr(hashlib, algorithm)()
        for data in data_stream:
            data_hash.update(data)
        return data_hash.hexdigest()


def set_file_checksum_xattr(file_path: str, xattr_name: str, checksum: str) -> None:
    file_xattrs = xattr.xattr(file_path)

    try:
        file_xattrs.set(xattr_name, str.encode(checksum))
    except Exception as ex:
        raise JobException(
            f"Failed to set xattr {xattr_name}:{checksum} due to: {str(ex)}"
        )


def monitor_jobs(heartbeat_callback: AtmHeartbeatCallback) -> None:
    any_job_ongoing = True
    while any_job_ongoing:
        any_job_ongoing = not _all_jobs_processed.wait(timeout=1)
```

## Building the Docker image

Each lambda is built on top of the `lambda-base` image provided by Onedata.
This base image contains the runtime and integration required by the automation system,
so it should **not be modified**, as this may lead to unexpected behavior.

The base image uses Docker `ONBUILD` instructions to copy the lambda code into the
container and prepare it for execution.

```dockerfile
...
RUN mkdir -p function && touch ./function/__init__.py
ONBUILD COPY --chown=app:app handler.py *requirements.txt function/
...
```

The base image also provides a parent module called `index.py`. This module is executed
when the container starts and is responsible for calling the lambda handler.

```python
...
from function import handler

result = handler.handle(request, heartbeat_callback)
...
```

In the lambda directory, create the following files:

- `Dockerfile`
- `Makefile`
- `requirements.txt` (optional, if additional Python packages are required)

It is important that these files are placed directly in the lambda directory and use
exactly these names. The base image relies on this structure during the build process.

**Dockerfile**

The `Dockerfile` itself is very simple. It only needs to reference the latest
`lambda-base` image.

```dockerfile
FROM onedata/lambda-base-slim:v2
```

**Makefile**

The `Makefile` contains helper targets used to build and publish the Docker image.

```makefile
REPO_NAME = lambda-calculate-checksum-mounted
TAG = v1
REGISTRY ?=

IMAGE := ${REGISTRY}/${REPO_NAME}:${TAG}

.PHONY: build publish

build:
	docker build . -t ${IMAGE}

publish:
	docker push ${IMAGE}
```
