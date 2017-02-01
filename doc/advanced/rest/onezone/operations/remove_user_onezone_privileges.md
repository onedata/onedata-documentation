
<a name="remove_user_onezone_privileges"></a>
#### Remove user's Onezone privileges
```
DELETE /privileges/users/{id}
```


##### Description
Removes all privileges for a user {id} to Onezone.

This operation requires `set_privileges` privilege.

***Example cURL requests***

**Delete all user privileges to Onezone service**
```bash
curl -k -u username:password  -X DELETE  \
https://$HOST:8443/api/v3/onezone/privileges/users/ivMnRLb2WYNApEmP-j3SF0NsqBgdHG7iel89FHY802w
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*|User ID.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The user privileges have been added.|No Content|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**401**|Authentication error.|[Error](../definitions/Error.md#error)|
|**403**|Authorization error.|[Error](../definitions/Error.md#error)|
|**404**|Resource not found.|[Error](../definitions/Error.md#error)|
|**500**|Internal server Error.|[Error](../definitions/Error.md#error)|


##### Example HTTP request

###### Request path
```
json :
"/privileges/users/string"
```


##### Example HTTP response

###### Response 400
```
json :
{
  "error" : "invalid_token",
  "error_description" : "Provided token could not be validated."
}
```


###### Response 401
```
json :
{
  "error" : "invalid_token",
  "error_description" : "Provided token could not be validated."
}
```


###### Response 403
```
json :
{
  "error" : "invalid_token",
  "error_description" : "Provided token could not be validated."
}
```


###### Response 404
```
json :
{
  "error" : "invalid_token",
  "error_description" : "Provided token could not be validated."
}
```


###### Response 500
```
json :
{
  "error" : "invalid_token",
  "error_description" : "Provided token could not be validated."
}
```



