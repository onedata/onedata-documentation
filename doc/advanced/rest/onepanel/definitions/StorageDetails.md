
<a name="storagedetails"></a>
### StorageDetails
The cluster storage configuration.


|Name|Description|Schema|
|---|---|---|
|**id**  <br>*optional*|The ID of storage.|string|
|**insecure**  <br>*optional*|Defines whether storage administrator credentials (username and key) may be used by users without storage accounts to access storage in direct IO mode.  <br>**Default** : `false`|boolean|
|**name**  <br>*optional*|The name of storage.|string|
|**readonly**  <br>*optional*|Defines whether storage is readonly.  <br>**Default** : `false`|boolean|
|**type**  <br>*required*|The type of storage.|enum (posix, s3, ceph, swift, glusterfs)|



