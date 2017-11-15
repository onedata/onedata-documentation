
<a name="map_group"></a>
#### Map group
```
POST /map_group
```


##### Description
Returns storage group GID based on Onedata group ID. This operation allows to map group owners of files from federated group Id to storage specific group Id. By default, each file in a space belongs to a default space group, however this can be changed.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Body**|**groupIdentityRequest**  <br>*required*|Group identity mapping request.|[GroupIdentity](../definitions/GroupIdentity.md#groupidentity)|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|Group details returned successfully.|[GroupDetails](../definitions/GroupDetails.md#groupdetails)|
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
"/map_group"
```


###### Request body
```
json :
{
  "idp" : "github",
  "groupId" : "5484af38-8b5d-464f-bdd1-da9ef801090f"
}
```


##### Example HTTP response

###### Response 200
```
json :
{
  "storageId" : "Assdwe897Dsdjhx9",
  "storageName" : "NFS",
  "gid" : 1001,
  "aclName" : "users"
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



