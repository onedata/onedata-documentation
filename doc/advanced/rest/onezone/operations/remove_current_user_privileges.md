
<a name="remove_current_user_privileges"></a>
#### Remove current user privileges
```
DELETE /user/privileges
```


##### Description
Removes all privileges for a user to Onezone.

This operation can be invoked on behalf of current user only.

***Example cURL requests***

**Delete all user privileges to Onezone service**
```bash
curl -u username:password  -X DELETE  \
https://$HOST:8443/api/v3/onezone/users/privileges
```


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
"/user/privileges"
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



