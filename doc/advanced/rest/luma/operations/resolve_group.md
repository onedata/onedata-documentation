
<a name="resolve_group"></a>
#### Resolve group identity
```
POST /resolve_group
```


##### Description
Returns group identity based on storage specific group id. This operation is used when importing data from legacy storage, and it is needed that the user group (e.g. gid on POSIX) storages is mapped to a proper federated group Id. The group resolution can be performed in the context of specific storage (identified by `storageId` or `storageName`). In case the no storage group Id is passed in the `groupDetails` parameter, a default group Id for current space can be returned.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Body**|**groupStorageDetails**  <br>*required*|Group details for group mapping.|[GroupDetails](../definitions/GroupDetails.md#groupdetails)|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|Group identity returned successfully.|[GroupIdentity](../definitions/GroupIdentity.md#groupidentity)|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|[Error](../definitions/Error.md#error)|
|**404**|User credentials not found.|[Error](../definitions/Error.md#error)|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


##### Consumes

* `application/json`


##### Produces

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/resolve_group"
```


###### Request body
```
json :
{
  "storageId" : "Assdwe897Dsdjhx9",
  "storageName" : "NFS",
  "gid" : 1001,
  "aclName" : "users"
}
```


##### Example HTTP response

###### Response 200
```
json :
{
  "idp" : "github",
  "groupId" : "5484af38-8b5d-464f-bdd1-da9ef801090f"
}
```


###### Response 400
```
json :
{
  "error" : "invalid_user",
  "errorDescription" : "Invalid user ID."
}
```


###### Response 403
```
json :
{
  "error" : "invalid_user",
  "errorDescription" : "Invalid user ID."
}
```


###### Response 404
```
json :
{
  "error" : "invalid_user",
  "errorDescription" : "Invalid user ID."
}
```


###### Response 500
```
json :
{
  "error" : "invalid_user",
  "errorDescription" : "Invalid user ID."
}
```



