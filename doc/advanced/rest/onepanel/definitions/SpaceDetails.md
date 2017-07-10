
<a name="spacedetails"></a>
### SpaceDetails
The space details.


|Name|Description|Schema|
|---|---|---|
|**id**  <br>*required*|The ID of the space.|string|
|**localStorages**  <br>*required*|The list of IDs of cluster storage resources.|< string > array|
|**mountInRoot**  <br>*optional*|Defines whether space will be mounted in / or /{SpaceId}/ path.  <br>**Default** : `false`|boolean|
|**name**  <br>*required*|The name of the space.|string|
|**storageId**  <br>*required*|Id of StorageDetails that supports this space on provider that is associated with this panel.|string|
|**storageImport**  <br>*optional*||[StorageImportDetails](StorageImportDetails.md#storageimportdetails)|
|**storageUpdate**  <br>*optional*||[StorageUpdateDetails](StorageUpdateDetails.md#storageupdatedetails)|
|**supportingProviders**  <br>*required*|The collection of provider IDs with associated supported storage space in bytes.|< string, integer > map|



