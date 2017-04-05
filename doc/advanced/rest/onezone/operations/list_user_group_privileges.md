
<a name="list_user_group_privileges"></a>
#### List user's group privileges
```
GET /groups/{id}/users/{uid}/privileges
```


##### Description
Returns the list of user privileges in a specific group.

This operation requires `group_view_data` privilege.

***Example cURL requests***

**Get group users**
```bash
curl -u username:password -X GET
https://$HOST:8443/api/v3/onezone/groups/HwUpk8jrwxKOe45uzLFX2GVC8lKEasj4q253sptVqF8/users/lb0NvUXIVguzjQ3dBOXAyd1c61fWKB5dKJDQ6YvB7a0/privileges

{
  "privileges": [
    "group_change_data",
    "group_create_space",
    "group_create_space_token",
    "group_invite_group"]
}
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*|Group ID.|string|--|
|**Path**|**uid**  <br>*required*|User ID.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The list of user privileges in a group.|[GroupPrivileges](../definitions/GroupPrivileges.md#groupprivileges)|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**401**|Authentication error.|[Error](../definitions/Error.md#error)|
|**403**|Authorization error.|[Error](../definitions/Error.md#error)|
|**404**|Resource not found.|[Error](../definitions/Error.md#error)|
|**500**|Internal server Error.|[Error](../definitions/Error.md#error)|


##### Produces

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/groups/string/users/string/privileges"
```


##### Example HTTP response

###### Response 200
```
json :
{
  "privileges" : [ "group_change_data", "group_create_space", "group_invite_group", "group_invite_user", "group_join_group", "group_join_space", "group_leave_space", "group_remove", "group_remove_group", "group_remove_user", "group_set_privileges", "group_view_data" ]
}
```


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



