
<a name="set_space_group_privileges"></a>
#### Set group privileges to space
```
PUT /spaces/{id}/groups/{gid}/privileges
```


##### Description
Sets new privileges for a group to a specific space.

This operation requires `space_set_privileges` privilege.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**gid**  <br>*required*|Group ID.|string|--|
|**Path**|**id**  <br>*required*|Space ID.|string|--|
|**Body**|**data**  <br>*optional*|Space privileges.|[GroupPrivileges](../definitions/GroupPrivileges.md#groupprivileges)|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The group privileges have been added.|No Content|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**401**|Authentication error.|[Error](../definitions/Error.md#error)|
|**403**|Authorization error.|[Error](../definitions/Error.md#error)|
|**404**|Resource not found.|[Error](../definitions/Error.md#error)|
|**500**|Internal server Error.|[Error](../definitions/Error.md#error)|


##### Example HTTP request

###### Request path
```
json :
"/spaces/string/groups/string/privileges"
```


###### Request body
```
json :
{
  "privileges" : [ "group_change_data", "group_invite_user", "group_remove_user", "group_join_space", "group_create_space", "group_set_privileges", "group_remove", "group_leave_space", "group_view_data", "group_create_space_token", "group_join_group", "group_invite_group", "group_remove_group" ]
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



