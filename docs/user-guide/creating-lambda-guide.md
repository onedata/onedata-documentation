# Creating a Lambda: File Checksum Example

This guide shows how to add a Python lambda to an Onedata Automation lambdas workspace.
The lambda will calculate a checksum for a file available through a mounted Oneclient and
optionally store the checksum as file metadata.

The example uses the current lambda v3 style:

* the lambda is a Python package managed by `uv`;
* its dependencies and entry point are declared in `pyproject.toml`;
* the handler uses the `onedata-lambda-sdk` SDK;
* the image is built with the workspace's shared Dockerfile.

The workspace must use Python 3.12 or newer, `uv`, and Docker 23 or newer.

## 1. Create the lambda package

Start by creating a package directory for the lambda. It will contain the project
definition and Python source code:

```text
lambdas/calculate-checksum-mounted/
├── pyproject.toml
└── src/
    └── calculate_checksum_mounted/
        ├── __init__.py
        └── handler.py
```

A v3 lambda is a regular Python package. Its project metadata is stored in
`pyproject.toml`, while the importable code lives under `src`.

The directory name may contain hyphens, but the Python package name must use underscores.
Create an empty `src/calculate_checksum_mounted/__init__.py` file so that the source
directory is recognized as a Python package.

The workspace root provides the shared `uv.lock`, `Dockerfile`, and `Makefile`; do not add
separate copies to the lambda directory.

For the complete workspace structure, see
[The layout][sdk-workspace-layout] in the SDK workspace guide.

## 2. Declare the package and entry point

The workspace needs a project definition to install the package and locate its handler.
Create `lambdas/calculate-checksum-mounted/pyproject.toml` with the following content:

```toml
[project]
name = "calculate-checksum-mounted"
version = "1"
description = "Calculate a file checksum using a mounted Oneclient"
requires-python = ">=3.12"
dependencies = [
    "onedata-lambda-sdk>=1.0",
    "xattr>=1.1",
]

[project.entry-points."onedata.lambda"]
handler = "calculate_checksum_mounted.handler:handle"

[build-system]
requires = ["hatchling"]
build-backend = "hatchling.build"

[tool.hatch.build.targets.wheel]
packages = ["src/calculate_checksum_mounted"]
```

The `[project]` section defines the package name, version, supported Python version, and
direct dependencies. `onedata-lambda-sdk` supplies the v3 runtime contract, while `xattr`
is needed to write file metadata. The base image installs only declared dependencies, so
every package imported by the handler must be listed here.

Each lambda must declare exactly one `onedata.lambda` entry point. Its value identifies the
Python function loaded by the runtime: `<package>.<module>:<function>`.

The remaining sections select Hatchling as the build backend and point it to the Python
package under `src`.

For the complete package and entry-point requirements, see
[Declare the contract in `pyproject.toml`][sdk-package-contract] in the SDK guide.

## 3. Implement the handler

Organizing the handler into imports, configuration, interface definitions,
the main function, and helpers makes the code easier to follow. The following steps
walk through each part of `src/calculate_checksum_mounted/handler.py`.

### Add the required imports

The handler will calculate checksums, access the mounted filesystem, write file metadata,
and use the Onedata Lambda SDK. Start `handler.py` with the required imports:

```python
import hashlib
import os
import zlib
from collections.abc import Iterable
from typing import Final, Literal, TypedDict, get_args

import xattr
from onedata_lambda_sdk import (
    DEFAULT_MAX_WORKERS,
    AtmFile,
    Job,
    JobContext,
    JobException,
    mounted_file_path,
    per_job,
)
```

`hashlib` and `zlib` provide the checksum algorithms, while `os` is used to verify the file
type. The imports from `collections.abc` and `typing` describe the handler's data types.
The `xattr` package writes the checksum as file metadata.

The remaining types and helpers come from `onedata-lambda-sdk`. They define the handler
contract and provide runtime integration. Each one is explained below when it is first
used.

### Define the lambda configuration

Next, define how much data the lambda reads at once and which checksum algorithms it
supports:

```python
READ_CHUNK_SIZE: Final[int] = 10 * 1024**2

ChecksumAlgorithm = Literal["adler32", "md5", "sha256"]

AVAILABLE_CHECKSUM_ALGORITHMS: Final[frozenset[ChecksumAlgorithm]] = frozenset(
    get_args(ChecksumAlgorithm)
)
```

`READ_CHUNK_SIZE` lets the lambda process large files without loading them entirely into
memory. `ChecksumAlgorithm` lists the values accepted by the typed configuration.
`AVAILABLE_CHECKSUM_ALGORITHMS` provides the same values as a runtime collection used for
validation.

### Define the lambda interface

Describe the configuration, input, and output expected by the handler. Add the following
interface definitions below the configuration constants:

```python
class TaskConfig(TypedDict):
    algorithm: ChecksumAlgorithm
    metadataKey: str


class JobArgs(TypedDict):
    file: AtmFile


class FileChecksumReport(TypedDict):
    fileId: str
    algorithm: str
    checksum: str | None


class JobResult(TypedDict):
    result: FileChecksumReport
```

The `TypedDict` classes let editors and static-analysis tools check the field names and
value types used by the implementation:

* `TaskConfig` describes the task configuration;
* `JobArgs` describes the arguments of one job;
* `AtmFile` is the SDK type representing a file passed to a lambda;
* `FileChecksumReport` describes the calculated checksum;
* `JobResult` describes the value returned for one job.

These definitions should match the lambda schema, but they do not configure or validate the
schema themselves.

### Implement the main function

The entry point will process one file: locate it through Oneclient, calculate its checksum,
optionally store the checksum as metadata, and return the result. Build it one logical step
at a time.

#### Define the handler

Start with the decorated function and its typed signature:

```python
@per_job(
    max_workers=DEFAULT_MAX_WORKERS,
    precondition=lambda ctx: assert_supported(ctx.config["algorithm"]),
)
def handle(job: Job[JobArgs], ctx: JobContext[TaskConfig]) -> JobResult:
    ...
```

Oneprovider invokes a lambda with a batch of jobs. The `@per_job` decorator adapts the
single-job function to that runtime contract: the SDK performs the batch loop, preserves
result order, reports progress, and isolates failures of individual jobs.

For more about this handler style, see
[Choose a shape: per-job or batch][sdk-handler-shapes] in the SDK guide.

The function receives two SDK objects:

* `Job[JobArgs]` carries the arguments of the current job in `job.args`;
* `JobContext[TaskConfig]` carries configuration and other state shared by the batch.

`DEFAULT_MAX_WORKERS` enables concurrent processing of independent jobs. The `precondition`
runs once before processing begins and rejects an unsupported algorithm for the entire
batch.

#### Read the input

Begin the function body by extracting the selected algorithm and file ID. Then resolve the
file's mounted path. The snippets in the following steps form the indented body of `handle`:

```python
    algorithm = ctx.config["algorithm"]
    file_id = job.args["file"]["fileId"]
    file_path = mounted_file_path(file_id)
```

The task configuration is available through `ctx.config`, while the current job's input is
available through `job.args`. Keeping these values in local variables makes the remaining
steps easier to read.

`mounted_file_path(file_id)` returns the path used to access the file through the mounted
Oneclient filesystem. For more about file access, see
[Read through a mounted Oneclient][sdk-mounted-file-access] in the SDK guide.

#### Handle non-regular files

The lambda should calculate checksums only for regular files. Add an early return when the
mounted path does not resolve to one, for example for a directory or missing file:

```python
    if not os.path.isfile(file_path):
        return {
            "result": {
                "fileId": file_id,
                "algorithm": algorithm,
                "checksum": None,
            }
        }
```

This behavior is intentional. Returning `checksum` set to `None` treats such an object as a
valid input for which no checksum was calculated, rather than reporting a failed job.

#### Calculate the checksum

For a regular file, read its contents in chunks and pass them to the checksum helper:

```python
    with open(file_path, "rb") as file:
        chunks = iter(lambda: file.read(READ_CHUNK_SIZE), b"")
        checksum = calculate_checksum(algorithm, chunks)
```

Opening the file in binary mode gives the checksum function raw bytes. The iterator reads
at most `READ_CHUNK_SIZE` bytes at a time and stops when `read` returns an empty byte string.
As a result, memory use does not grow with the file size.

#### Store the checksum as metadata

An empty `metadataKey` value means that the checksum should only be returned. Add the
metadata write when a key is present:

```python
    if metadata_key := ctx.config["metadataKey"]:
        store_checksum_as_xattr(file_path, metadata_key, checksum)
```

The assignment expression stores the configured key in `metadata_key`. The helper is called
only when that value is not empty.

#### Return the result

Finally, return the file ID, selected algorithm, and calculated checksum:

```python
    return {
        "result": {
            "fileId": file_id,
            "algorithm": algorithm,
            "checksum": checksum,
        }
    }
```

The returned dictionary matches `JobResult` and becomes the result for the current job.

### Add the helper functions

Keep validation, checksum calculation, and metadata storage outside the main function.

#### Validate the algorithm

Add the function used by the handler's `precondition`:

```python
def assert_supported(algorithm: str) -> None:
    if algorithm not in AVAILABLE_CHECKSUM_ALGORITHMS:
        raise JobException(
            f"{algorithm} algorithm is unsupported. "
            f"Available ones are: {sorted(AVAILABLE_CHECKSUM_ALGORITHMS)}"
        )
```

An unsupported algorithm is an expected configuration error, so the function raises
`JobException`. Because the function runs as a precondition, this stops the entire batch
with a readable message before any job is processed.

#### Calculate a checksum

Add the function that consumes the file chunks prepared by `handle`:

```python
def calculate_checksum(
    algorithm: ChecksumAlgorithm,
    chunks: Iterable[bytes],
) -> str:
    if algorithm == "adler32":
        value = 1
        for chunk in chunks:
            value = zlib.adler32(chunk, value)
        return format(value, "x")

    digest = getattr(hashlib, algorithm)()
    for chunk in chunks:
        digest.update(chunk)
    return str(digest.hexdigest())
```

Adler-32 uses `zlib`, while the remaining algorithms use the matching constructors from
`hashlib`. Each chunk is incorporated into the checksum before the hexadecimal value is
returned.

#### Store the checksum as an extended attribute

Add the metadata helper used when `metadataKey` is not empty:

```python
def store_checksum_as_xattr(file_path: str, xattr_name: str, checksum: str) -> None:
    try:
        xattr.xattr(file_path).set(xattr_name, checksum.encode())
    except OSError as ex:
        raise JobException(f"Failed to set xattr {xattr_name!r} on the file: {ex}") from ex
```

Extended attributes store byte values, so the hexadecimal checksum string is encoded before
it is written. An expected metadata write failure is translated into `JobException`, which
`@per_job` reports only for the affected job.

### Complete handler.py

The complete `src/calculate_checksum_mounted/handler.py` should look as follows:

```python
import hashlib
import os
import zlib
from collections.abc import Iterable
from typing import Final, Literal, TypedDict, get_args

import xattr
from onedata_lambda_sdk import (
    DEFAULT_MAX_WORKERS,
    AtmFile,
    Job,
    JobContext,
    JobException,
    mounted_file_path,
    per_job,
)


READ_CHUNK_SIZE: Final[int] = 10 * 1024**2

ChecksumAlgorithm = Literal["adler32", "md5", "sha256"]

AVAILABLE_CHECKSUM_ALGORITHMS: Final[frozenset[ChecksumAlgorithm]] = frozenset(
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
    checksum: str | None


class JobResult(TypedDict):
    result: FileChecksumReport


@per_job(
    max_workers=DEFAULT_MAX_WORKERS,
    precondition=lambda ctx: assert_supported(ctx.config["algorithm"]),
)
def handle(job: Job[JobArgs], ctx: JobContext[TaskConfig]) -> JobResult:
    algorithm = ctx.config["algorithm"]
    file_id = job.args["file"]["fileId"]
    file_path = mounted_file_path(file_id)

    if not os.path.isfile(file_path):
        return {
            "result": {
                "fileId": file_id,
                "algorithm": algorithm,
                "checksum": None,
            }
        }

    with open(file_path, "rb") as file:
        chunks = iter(lambda: file.read(READ_CHUNK_SIZE), b"")
        checksum = calculate_checksum(algorithm, chunks)

    if metadata_key := ctx.config["metadataKey"]:
        store_checksum_as_xattr(file_path, metadata_key, checksum)

    return {
        "result": {
            "fileId": file_id,
            "algorithm": algorithm,
            "checksum": checksum,
        }
    }


def assert_supported(algorithm: str) -> None:
    if algorithm not in AVAILABLE_CHECKSUM_ALGORITHMS:
        raise JobException(
            f"{algorithm} algorithm is unsupported. "
            f"Available ones are: {sorted(AVAILABLE_CHECKSUM_ALGORITHMS)}"
        )


def calculate_checksum(
    algorithm: ChecksumAlgorithm,
    chunks: Iterable[bytes],
) -> str:
    if algorithm == "adler32":
        value = 1
        for chunk in chunks:
            value = zlib.adler32(chunk, value)
        return format(value, "x")

    digest = getattr(hashlib, algorithm)()
    for chunk in chunks:
        digest.update(chunk)
    return str(digest.hexdigest())


def store_checksum_as_xattr(file_path: str, xattr_name: str, checksum: str) -> None:
    try:
        xattr.xattr(file_path).set(xattr_name, checksum.encode())
    except OSError as ex:
        raise JobException(f"Failed to set xattr {xattr_name!r} on the file: {ex}") from ex
```

## 4. Sync the workspace

Before building the lambda, synchronize the workspace and update its shared dependency lock
file.

Follow [Work across members during development][sdk-workspace-development] in the SDK
workspace guide to synchronize the dependencies.

## 5. Build and publish the image

Build and publish the Docker image for your lambda.

Follow [Build one member][sdk-workspace-build] in the SDK workspace guide for the image
build. For the repository's build and publish commands, see
[Building and publishing images][examples-build-publish] in the `automation-examples` README.

## Next steps

After publishing the image, follow the [GUI guide][creating-lambda-gui] to register the
lambda or update the image reference of an existing lambda.

To report processing statistics, continue with
[Adding Time Series to the Lambda][adding-ts].

<!-- references -->

[sdk-workspace-layout]: https://github.com/onedata/onedata-lambda-sdk/blob/develop/docs/guides/shared-code-uv-workspace.md#the-layout

[sdk-package-contract]: https://github.com/onedata/onedata-lambda-sdk/blob/develop/docs/guides/single-lambda-repo.md#step-2--declare-the-contract-in-pyprojecttoml

[sdk-handler-shapes]: https://github.com/onedata/onedata-lambda-sdk/blob/develop/docs/guides/writing-a-handler.md#choose-a-shape-per-job-or-batch

[sdk-mounted-file-access]: https://github.com/onedata/onedata-lambda-sdk/blob/develop/docs/guides/file-access.md#read-through-a-mounted-oneclient

[sdk-workspace-development]: https://github.com/onedata/onedata-lambda-sdk/blob/develop/docs/guides/shared-code-uv-workspace.md#step-5--work-across-members-during-development

[sdk-workspace-build]: https://github.com/onedata/onedata-lambda-sdk/blob/develop/docs/guides/shared-code-uv-workspace.md#step-4--build-one-member

[examples-build-publish]: https://github.com/onedata/automation-examples/blob/develop/README.md#building-and-publishing-images

[creating-lambda-gui]: ./creating-lambda-guide-gui.md

[adding-ts]: ./adding-ts-to-lambda-guide.md
