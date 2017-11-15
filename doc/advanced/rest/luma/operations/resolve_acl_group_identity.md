
<a name="resolve_acl_group_identity"></a>
#### Resolve group ACL identity
```
POST /resolve_acl_group
```


##### Description
Returns the group identity based on group ACL name. This operation is used when storage supports ACL's (e.g. NFSv4 or POSIX) and it is required that ACL's from storage are translated to Onedata ACL's when importing data from legacy storage.


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
|**404**|Group credentials not found.|[Error](../definitions/Error.md#error)|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


##### Consumes

* `application/json`


##### Produces

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/resolve_acl_group"
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



