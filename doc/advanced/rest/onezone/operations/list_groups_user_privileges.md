
<a name="list_groups_user_privileges"></a>
#### List user group privileges
```
GET /groups/{id}/effective_users/{uid}/privileges
```


##### Description
Returns the effective user privileges in a group.

This operation requires `group_view` privilege.

***Example cURL requests***

**Get group user details**
```bash
curl -i -u username:password -X GET \
https://$HOST/api/v3/onezone/groups/HwUpk8jrwxKOe45uzLFX2GVC8lKEasj4q253sptVqF8/effective_users/lb0NvUXIVguzjQ3dBOXAyd1c61fWKB5dKJDQ6YvB7a0/privileges

{
  "privileges": [
    "group_update",
    "group_create_space",
    "group_create_space_token",
    "group_invite_group",
    "group_invite_user",
    "group_join_group",
    "group_join_space",
    "group_leave_space",
    "group_delete",
    "group_remove_group",
    "group_remove_user",
    "group_set_privileges",
    "group_view"
  ]
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
|**200**|Returns the information about a group user privileges.|[GroupPrivileges](../definitions/GroupPrivileges.md#groupprivileges)|
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
"/groups/string/effective_users/string/privileges"
```


##### Example HTTP response

###### Response 200
```
json :
{
  "privileges" : [ "group_create_space", "group_delete", "group_invite_group", "group_invite_user", "group_join_group", "group_join_space", "group_leave_space", "group_remove_group", "group_remove_user", "group_set_privileges", "group_update", "group_view" ]
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



