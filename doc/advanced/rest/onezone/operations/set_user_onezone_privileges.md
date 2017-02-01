
<a name="set_user_onezone_privileges"></a>
#### Set user's Onezone privileges
```
PATCH /users/{id}/privileges
```


##### Description
Modifies privileges for a user {id} for Onezone.

This operation requires `set_privileges` privilege.

***Example cURL requests***

**Modifies users privileges to Onezone service**
```bash
curl -k -u username:password  -H "Content-type: application/json"  -X PUT \
-d '{"privileges":["list_spaces"]}' \
https://$HOST:8443/api/v3/onezone/users/ivMnRLb2WYNApEmPj3SF0NsqBgdHG7iel89FHY802w/privileges
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*|User ID.|string|--|
|**Body**|**data**  <br>*optional*|User Onezone privileges.|[OnezonePrivileges](../definitions/OnezonePrivileges.md#onezoneprivileges)|--|


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
"/users/string/privileges"
```


###### Request body
```
json :
{
  "privileges" : [ "view_privileges", "set_privileges", "list_spaces", "list_providers", "list_providers_of_space" ]
}
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



