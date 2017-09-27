
<a name="storageimportdetails"></a>
### StorageImportDetails
The storage import configuration. Storage import allows to import data from storage to space without need for copying the data.


|Name|Description|Schema|
|---|---|---|
|**maxDepth**  <br>*optional*|Maximum depth of filesystem tree that will be traversed during storage synchronization.|integer|
|**strategy**  <br>*required*|The import strategy. One of no_import, simple_scan.|string|
|**syncAcl**  <br>*optional*|Flag that enables synchronization of NFSv4 ACLs.|boolean|



