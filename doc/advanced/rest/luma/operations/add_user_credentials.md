
<a name="add_user_credentials"></a>
#### Add user credentials
```
PUT /admin/users/{lid}/credentials
```


##### Description
Adds user credentials to specific storage (optional).


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**lid**  <br>*required*|LUMA user Id.|integer|--|
|**Body**|**credentials**  <br>*required*|Add user credentials for specific storage.|< [UserStorageCredentials](../definitions/UserStorageCredentials.md#userstoragecredentials) > array|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|User credentials added successfully.|No Content|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|[Error](../definitions/Error.md#error)|
|**404**|User credentials not found.|[Error](../definitions/Error.md#error)|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


##### Consumes

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/admin/users/0/credentials"
```


###### Request body
```
json :
[ {
  "type" : "string",
  "storageId" : "string",
  "storageName" : "string"
} ]
```


##### Example HTTP response

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



