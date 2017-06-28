
<a name="spacesupportrequest"></a>
### SpaceSupportRequest
The configuration details required to create or support a space by a provider.


|Name|Description|Schema|
|---|---|---|
|**mountInRoot**  <br>*optional*|Defines whether space will be mounted in / or /{SpaceId}/ path.  <br>**Default** : `false`|boolean|
|**name**  <br>*optional*|The space name. If this property is provided and space with given name will be created and automatically supported by a provider.|string|
|**size**  <br>*required*|The storage space size in bytes that provider is willing to assign to the space.|integer|
|**storageId**  <br>*required*|The ID of the storage resource where the space data should be stored.|string|
|**storageImport**  <br>*optional*||[StorageImportDetails](StorageImportDetails.md#storageimportdetails)|
|**storageUpdate**  <br>*optional*||[StorageUpdateDetails](StorageUpdateDetails.md#storageupdatedetails)|
|**token**  <br>*required*|The token for space creation or support.|string|

**Example**
```
{
  "token" : "ASDJNASD87687ASDMNBMNASD87786asd",
  "size" : 1024000,
  "storageId" : "x7It3cpgNgLZ8RwOrOoW"
}
```



