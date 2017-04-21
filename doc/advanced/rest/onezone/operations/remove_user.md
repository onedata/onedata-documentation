
<a name="remove_user"></a>
#### Remove user
```
DELETE /users/{id}
```


##### Description
Removes a specific user.

This operation requires `oz_users_delete` privilege.

***Example cURL requests***

**Remove user**
```bash
curl -u admin:password -X DELETE  \
https://$HOST:8443/api/v3/onezone/users/LT88rteQ4KMSYXMWO0Oibiqn7X5nUD51NTsCqgDN8e4
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*|User ID.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**202**|The user will be removed.|No Content|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**401**|Authentication error.|[Error](../definitions/Error.md#error)|
|**403**|Authorization error.|[Error](../definitions/Error.md#error)|
|**404**|Resource not found.|[Error](../definitions/Error.md#error)|
|**500**|Internal server Error.|[Error](../definitions/Error.md#error)|


##### Example HTTP request

###### Request path
```
json :
"/users/string"
```


##### Example HTTP response

###### Response 400
```
json :
{
  "error" : "Provided data could not be understood by the server"
}
```


###### Response 401
```
json :
{
  "error" : "Provided data could not be understood by the server"
}
```


###### Response 403
```
json :
{
  "error" : "Provided data could not be understood by the server"
}
```


###### Response 404
```
json :
{
  "error" : "Provided data could not be understood by the server"
}
```


###### Response 500
```
json :
{
  "error" : "Provided data could not be understood by the server"
}
```



