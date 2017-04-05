
<a name="remove_user_onezone_privileges"></a>
#### Remove user's Onezone privileges
```
DELETE /users/{id}/privileges
```


##### Description
Removes all privileges for a user {id} to Onezone.

This operation requires `set_privileges` privilege.

***Example cURL requests***

**Delete all user privileges to Onezone service**
```bash
curl -u username:password  -X DELETE  \
https://$HOST:8443/api/v3/onezone/users/ivMnRLb2WYNApEmP-j3SF0NsqBgdHG7iel89FHY802w/privileges
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*|User ID.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The user privileges have been removed.|No Content|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**401**|Authentication error.|[Error](../definitions/Error.md#error)|
|**403**|Authorization error.|[Error](../definitions/Error.md#error)|
|**404**|Resource not found.|[Error](../definitions/Error.md#error)|
|**500**|Internal server Error.|[Error](../definitions/Error.md#error)|


##### Example HTTP request

###### Request path
```
json :
"/users/string/privileges"
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



