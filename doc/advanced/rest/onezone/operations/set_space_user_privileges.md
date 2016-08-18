
<a name="set_space_user_privileges"></a>
#### Set user privileges to space
```
PUT /spaces/{id}/users/{uid}/privileges
```


##### Description
Adds specific privileges for a user in a space.

This operation requires `space_set_privileges` privilege.

***Example cURL requests***

**Set user privileges to space**
```bash
curl -i -k -u admin:password -X PUT \
-d '{"privileges":["space_add_provider","space_change_data"]}' \
https://$HOST:8443/api/v3/onezone/spaces/9ueUeoZA6KXxNgzlvqmmrbzqE_BQiaHEEDC21sY1Kuc/users/lb0NvUXIVguzjQ3dBOXAyd1c61fWKB5dKJDQ6YvB7a0/privileges
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*|Space ID.|string|--|
|**Path**|**uid**  <br>*required*|User ID.|string|--|
|**Body**|**data**  <br>*required*|User privileges.|[SpacePrivileges](../definitions/SpacePrivileges.md#spaceprivileges)|--|


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
"/spaces/string/users/string/privileges"
```


###### Request body
```
json :
{
  "privileges" : [ "space_invite_user", "space_remove_user", "space_invite_group", "space_remove_group", "space_set_privileges", "space_remove", "space_add_provider", "space_remove_provider", "space_change_data", "space_view_data" ]
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



