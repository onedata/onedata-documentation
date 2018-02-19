
<a name="resolve_user_identity"></a>
#### Resolve user identity
```
POST /resolve_user
```


##### Description
Returns the user identity based on provided storage credentials. This operation is used when importing data from legacy storage, and it is needed that the user storage identity (e.g. uid on POSIX) storages is mapped to a proper federated identity.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Body**|**userStorageCredentials**  <br>*required*|User storage credentials for reverse mapping.|[UserStorageCredentials](../definitions/UserStorageCredentials.md#userstoragecredentials)|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|User identity returned successfully.|[UserIdentity](../definitions/UserIdentity.md#useridentity)|
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
"/resolve_user"
```


###### Request body
```
json :
{
  "type" : "string",
  "storageId" : "string",
  "storageName" : "string",
  "aclName" : "string"
}
```


##### Example HTTP response

###### Response 200
```
json :
{
  "idp" : "google",
  "subjectId" : "5484af38-8b5d-464f-bdd1-da9ef801090f"
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



