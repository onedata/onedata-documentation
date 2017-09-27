
<a name="filetransferstatus"></a>
### FileTransferStatus
File transfer status.


|Name|Description|Schema|
|---|---|---|
|**bytesToTransfer**  <br>*optional*|Total number of bytes in this transfer.|integer|
|**bytesTransferred**  <br>*optional*|Number of bytes already transferred.|integer|
|**callback**  <br>*optional*|Optional callback URL, which will be invoked on transfer completion.|string|
|**dyHist**  <br>*optional*|Byte transfer per day histogram for last 30 days.|< integer > array|
|**fileId**  <br>*optional*|Id of the file or directory being transferred.|string|
|**filesToTransfer**  <br>*optional*|Total number of files in this transfer.|integer|
|**filesTransferred**  <br>*optional*|Number of files already transferred.|integer|
|**hrHist**  <br>*optional*|Byte transfer per hour histogram for last 24 hours.|< integer > array|
|**invalidationStatus**  <br>*optional*|The status of transfer invalidation request.|enum (scheduled, skipped, active, completed, cancelled, failed)|
|**lastUpdate**  <br>*optional*|Last transfer update time in seconds (POSIX epoch timestamp).|integer|
|**minHist**  <br>*optional*|Byte transfer per minute histogram for last hour.|< integer > array|
|**path**  <br>*optional*|Path to the file or folder in the virtual file system.|string|
|**startTime**  <br>*optional*|Start time in seconds (POSIX epoch timestamp).|integer|
|**targetProviderId**  <br>*optional*|The ID of the target provider to which the replication was requested.|string|
|**transferStatus**  <br>*optional*|Current status of the transfer.|enum (scheduled, skipped, active, completed, cancelled, failed)|

**Example**
```
{
  "fileId" : "00000000005CF4706775696423745F772D67686431633765446F4D76546D6F2D67575F3361737A7670486B477A7936587734507265584A7723394A4F355F5F396E4C31623031594576776E667431723230677767776C6B497031394E445F6E3868677873",
  "path" : "/My Space 1/Folder2/file3.txt",
  "transferStatus" : "completed",
  "invalidationStatus" : "skipped",
  "targetProviderId" : "HICATChd8wzbFmB6qfGby9VN7MfdXgI1qC4pULGVm8Q",
  "filesToTransfer" : 1,
  "filesTransferred" : 1,
  "bytesTransferred" : 10485760000,
  "bytesToTransfer" : 10485760000,
  "startTime" : 1504688814,
  "lastUpdate" : 1504988814,
  "minHist" : [ 419430400, 1153433600, 1258291200, 1468006400, 1048576000, 1048576000, 1048576000, 1153433600, 629145600, 1258291200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
  "hrHist" : [ 10485760000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
  "dyHist" : [ 10485760000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
}
```



