
<a name="storageupdatedetails"></a>
### StorageUpdateDetails
The storage update configuration. Storage update ensures that all changes on storage will be reflected in space.


|Name|Description|Schema|
|---|---|---|
|**deleteEnable**  <br>*optional*|Flag determining that deletions of files will be detected.|boolean|
|**maxDepth**  <br>*optional*|Maximum depth of filesystem tree that will be traversed during storage synchronization.|integer|
|**scanInterval**  <br>*optional*|Period between subsequent scans in seconds (counted from end of one scan till beginning of the following).|integer|
|**strategy**  <br>*required*|The update strategy. One of no_update, simple_scan.|string|
|**writeOnce**  <br>*optional*|Flag determining that synchronized storage will be treated as immutable (only creations and deletions of files on storage will be detected).|boolean|



