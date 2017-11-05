
<a name="userstoragecredentials"></a>
### UserStorageCredentials
Generic storage credentials response type.


|Name|Description|Schema|
|---|---|---|
|**storageId**  <br>*optional*|Storage Id. Either storageId or storageName are required.|string|
|**storageName**  <br>*optional*|Storage name. Either storageId or storageName are required.|string|
|**type**  <br>*required*|Type of storage.|enum (posix, ceph, s3, swift, glusterfs)|



