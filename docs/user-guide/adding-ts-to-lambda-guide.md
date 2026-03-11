# Adding Time Series to the Lambda: File Checksum Example

This guide extends the lambda created in the previous guide.
It assumes you are already familiar with the **Lambda creation guide** and the
basic structure of a lambda implementation.

Here we focus on adding **time series statistics** to the lambda.
These statistics allow the automation system to track how the lambda processes data over time.

In this example, the lambda will report metrics such as:

- the number of files processed
- the number of bytes processed

Such metrics can later be used to build dashboards and visualize custom automation statistics.

## Required imports

Add the following imports to the lambda implementation:

```python
import queue
from onedata_lambda_utils.stats import AtmTimeSeriesMeasurementBuilder
from onedata_lambda_utils.streaming import AtmResultStreamer
from onedata_lambda_utils.types import AtmTimeSeriesMeasurement
```

## Special measurement types

To define time series metrics, create classes that inherit from
`AtmTimeSeriesMeasurementBuilder`.

This helper class simplifies building measurements by allowing you to define
a metric name and unit once, and then easily create measurement values.
If a timestamp is not provided, the builder automatically adds it.

The resulting objects are returned in the format expected by the Onedata
automation system (`AtmTimeSeriesMeasurement`).

```python
class FilesProcessed(
    AtmTimeSeriesMeasurementBuilder, ts_name="filesProcessed", unit=None
):
    pass


class BytesProcessed(
    AtmTimeSeriesMeasurementBuilder, ts_name="bytesProcessed", unit="Bytes"
):
    pass
```

## Creating an AtmResultStreamer

Onedata provides a helper class for streaming measurements from the lambda.
The `AtmResultStreamer` writes measurements to a dedicated result stream in the
lambda execution context.

This utility ensures the data format is correct and provides thread-safe
behavior when used in concurrent environments.

```python
STATS_STREAMER: Final[AtmResultStreamer[AtmTimeSeriesMeasurement]] = AtmResultStreamer(
    result_name="stats", synchronized=False
)
```

## Streaming measurements

In the previous guide, we created a `monitor_jobs` function that runs in a
separate thread and periodically calls `heartbeat_callback`.

We can extend this mechanism to also stream collected measurements.

To do this, create a thread-safe queue that stores measurements produced during
job processing. The monitoring thread will periodically read measurements from
this queue and send them using the streamer.

```python
_measurements_queue: queue.Queue = queue.Queue()

def monitor_jobs(heartbeat_callback: AtmHeartbeatCallback) -> None:
    any_job_ongoing = True
    while any_job_ongoing:
        any_job_ongoing = not _all_jobs_processed.wait(timeout=1)

        measurements = []
        while not _measurements_queue.empty():
            measurements.append(_measurements_queue.get())

        if measurements:
            STATS_STREAMER.stream_items(measurements)

        heartbeat_callback()
```

## Recording measurements

After processing a file, add an appropriate measurement to the queue.

The `run_job` function processes a single `Job`, which corresponds to a single file.
Therefore, a good place to add a measurement for processed files is at the end of this function.

```python
def run_job(job: Job) -> Union[AtmException, JobResults]:
    ...
    try:
        algorithm = job.ctx["config"]["algorithm"]
        checksum = calculate_checksum(algorithm, file_path)
        ...
    finally:
        _measurements_queue.put(FilesProcessed.build(value=1))
```

This ensures that the metric is recorded regardless of whether the job succeeded
or failed.

Similarly, you can collect statistics about the number of processed bytes.
A natural place to do this is inside the `calculate_checksum` function, where
file data is actually read and processed.

After processing each chunk of the file stream, add a measurement to the queue.

```python
def calculate_checksum(algorithm: ChecksumAlgorithm, file_path: str) -> str:
    with open(file_path, "rb") as fd:
        data_stream = iter(lambda: fd.read(READ_CHUNK_SIZE), b"")
        ...
        for data in data_stream:
            ...
            _measurements_queue.put(BytesProcessed.build(value=len(data)))
        ...
```

This way, the lambda continuously reports how many bytes were processed and the 
processing rate during execution.
