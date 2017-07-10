
<a name="set_space_user_privileges"></a>
#### Set user privileges to space
```
PATCH /spaces/{id}/users/{uid}/privileges
```


##### Description
Sets privileges for a user to a space.

This operation requires `space_set_privileges` privilege.

***Example cURL requests***

**Set user privileges to space**
```bash
curl -i -k -u admin:password -X PUT \
-d '{"privileges":["space_invite_provider","space_update"]}' \
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
|**204**|The user privileges have been updated.|No Content|
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
  "operation" : [ "set" ],
  "privileges" : [ "space_delete", "space_invite_group", "space_invite_provider", "space_invite_user", "space_manage_shares", "space_remove_group", "space_remove_provider", "space_remove_user", "space_set_privileges", "space_update", "space_view", "space_write_data" ]
}
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



