# Adding Time Series to the Lambda: File Checksum Example

This guide extends the lambda v3 handler from the [Lambda creation guide][creating-lambda]
with time series statistics. You will report two measurements while calculating checksums:

* `filesProcessed` — the number of regular files whose processing was attempted;
* `bytesProcessed` — the number of bytes included in checksum calculations.

These measurements can be used to visualize progress and processing rates in workflow
statistics. Make the following changes in `src/calculate_checksum_mounted/handler.py`.

## 1. Add the required imports

Extend the existing `collections.abc` import with `Callable`, and add
`TimeSeriesMeasurementBuilder` to the imports from `onedata_lambda_sdk`:

```python
from collections.abc import Callable, Iterable
from onedata_lambda_sdk import TimeSeriesMeasurementBuilder
```

`Callable` describes the function used to report processed bytes.
`TimeSeriesMeasurementBuilder` creates measurements in the format expected by Onedata.
Both are introduced in the steps below.

## 2. Define the measurements

Below the configuration constants, name the result stream and define a builder for each
measurement:

```python
STATS_STREAM: Final[str] = "stats"


class FilesProcessed(TimeSeriesMeasurementBuilder, ts_name="filesProcessed", unit=None):
    pass


class BytesProcessed(TimeSeriesMeasurementBuilder, ts_name="bytesProcessed", unit="Bytes"):
    pass
```

`STATS_STREAM` names the result that carries both measurements. Each `ts_name` identifies
one time series within that result. The units describe a count and a byte quantity;
they also need to be configured in the lambda schema, as described in the
[guide to adding time series in the GUI][adding-ts-gui].

Calling `FilesProcessed.build(value=1)` creates a measurement containing its time series
name, the current timestamp, and the value `1`.

## 3. Open the statistics stream

At the start of `handle`, obtain the result streamer from the job context:

```python
algorithm = ctx.config["algorithm"]
stats = ctx.result_streamer(STATS_STREAM)
```

`ctx.result_streamer` provides a thread-safe streamer shared by jobs in the batch. By
default, the SDK buffers measurements, writes them periodically, and flushes the remaining
measurements when processing finishes. For more about this behavior, see
[Buffered vs unbuffered][sdk-buffering] in the SDK guide.

## 4. Report processed bytes

### Extend the checksum helper

Add an optional callback to the local `calculate_checksum` function so it can report how
many bytes it processes:

```python
def calculate_checksum(
    algorithm: ChecksumAlgorithm,
    chunks: Iterable[bytes],
    on_bytes: Callable[[int], None] | None = None,
) -> str:
    ...
```

`on_bytes` accepts a byte count and returns nothing. The default `None` lets the helper
still be called without statistics.

Call it after updating the checksum with each chunk. In the Adler-32 branch, use:

```python
for chunk in chunks:
    value = zlib.adler32(chunk, value)
    if on_bytes is not None:
        on_bytes(len(chunk))
```

For the algorithms provided by `hashlib`, make the same addition after `digest.update`:

```python
for chunk in chunks:
    digest.update(chunk)
    if on_bytes is not None:
        on_bytes(len(chunk))
```

Each call reports the size of the chunk just included in the checksum, rather than a
cumulative total.

### Connect the helper to the stream

In `handle`, pass a callback when calling `calculate_checksum`:

```python
with open(file_path, "rb") as file:
    chunks = iter(lambda: file.read(READ_CHUNK_SIZE), b"")
    checksum = calculate_checksum(
        algorithm,
        chunks,
        on_bytes=lambda n: stats.stream_item(BytesProcessed.build(value=n)),
    )
```

The callback turns the byte count `n` into a `bytesProcessed` measurement and passes it to
the streamer. This reports progress while a large file is still being processed.

## 5. Count processed files

Wrap the checksum calculation, optional metadata write, and result return in `try`.
Add a `finally` block to record one file measurement when that processing ends:

```python
try:
    # Calculate the checksum, optionally store metadata, and return the result.
    ...
finally:
    stats.stream_item(FilesProcessed.build(value=1))
```

Keep the existing early return for non-regular files before `try`, so directories and
missing files are not counted. The `finally` block runs on both success and failure:
counting an attempted regular file even when reading or writing metadata fails is
intentional. `filesProcessed` therefore does not mean that the checksum was calculated
successfully.

### Complete updated functions

The two modified functions are shown together below. Keep the other definitions from the
previous guide, along with the imports and measurement builders added above.

```python
@per_job(
    max_workers=DEFAULT_MAX_WORKERS,
    precondition=lambda ctx: assert_supported(ctx.config["algorithm"]),
)
def handle(job: Job[JobArgs], ctx: JobContext[TaskConfig]) -> JobResult:
    algorithm = ctx.config["algorithm"]
    stats = ctx.result_streamer(STATS_STREAM)
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

    try:
        with open(file_path, "rb") as file:
            chunks = iter(lambda: file.read(READ_CHUNK_SIZE), b"")
            checksum = calculate_checksum(
                algorithm,
                chunks,
                on_bytes=lambda n: stats.stream_item(BytesProcessed.build(value=n)),
            )

        if metadata_key := ctx.config["metadataKey"]:
            store_checksum_as_xattr(file_path, metadata_key, checksum)

        return {
            "result": {
                "fileId": file_id,
                "algorithm": algorithm,
                "checksum": checksum,
            }
        }
    finally:
        stats.stream_item(FilesProcessed.build(value=1))


def calculate_checksum(
    algorithm: ChecksumAlgorithm,
    chunks: Iterable[bytes],
    on_bytes: Callable[[int], None] | None = None,
) -> str:
    if algorithm == "adler32":
        value = 1
        for chunk in chunks:
            value = zlib.adler32(chunk, value)
            if on_bytes is not None:
                on_bytes(len(chunk))
        return format(value, "x")

    digest = getattr(hashlib, algorithm)()
    for chunk in chunks:
        digest.update(chunk)
        if on_bytes is not None:
            on_bytes(len(chunk))
    return str(digest.hexdigest())
```

The checksum report is still returned as `result`. Measurements are sent separately through
`stats`, so `JobResult` stays the same.

## Next steps

[Rebuild and publish the image][build-publish], then continue with
[Adding time series to a lambda in the GUI][adding-ts-gui] to configure the `stats` result
and use its measurements in workflow statistics.

<!-- references -->

[creating-lambda]: ./creating-lambda-guide.md
[sdk-buffering]: https://github.com/onedata/onedata-lambda-sdk/blob/develop/docs/guides/streaming-logs-and-stats.md#buffered-vs-unbuffered
[adding-ts-gui]: ./adding-ts-to-lambda-guide-gui.md
[build-publish]: ./creating-lambda-guide.md#5-build-and-publish-the-image
