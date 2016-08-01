
<a name="filetransferstatus"></a>
### FileTransferStatus
File transfer status.


|Name|Description|Schema|
|---|---|---|
|**fileId**  <br>*optional*|Id of the file or directory being transferred.|string|
|**path**  <br>*optional*|Path to the file or folder in the virtual file system.|string|
|**progress**  <br>*optional*|The progress of the transfer in %.|integer|
|**status**  <br>*optional*|Current status of the transfer.|enum (scheduled, active, completed, cancelled, failed)|
|**targetProviderId**  <br>*optional*|The ID of the target provider to which the replication was requested.|string|

**Example**
```
{
  "path" : "/My Space 1/Folder2/file3.txt",
  "status" : "scheduled",
  "targetProviderId" : "4efc4a0c-0a61-4766-8fe9-c3d7fb414da8"
}
```



