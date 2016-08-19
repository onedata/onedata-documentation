
<a name="set_group_nested_privileges"></a>
#### Set subgroup privileges
```
PUT /groups/{id}/nested/{nid}/privileges
```


##### Description
Sets privileges for a specific subgroup in a group.

This operation requires `group_set_privileges` privilege.

***Example cURL requests***

**Get subgroup privileges in a group**

```bash
curl -k -u username:password  -H "Content-type: application/json" -X PUT \
-d '{"privileges": ["group_view_data"]}' \
https://$HOST:8443/api/v3/onezone/groups/HwUpk8jrwxKOe45uzLFX2GVC8lKEasj4q253sptVqF8/nested/T5x_HhFYOnILOCUf9OqgExw00RwaU2MXT5122oWk_sM/privileges
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*|Group ID.|string|--|
|**Path**|**nid**  <br>*required*|Subgroup ID.|string|--|
|**Body**|**data**  <br>*required*|Nested group privileges.|[GroupPrivileges](../definitions/GroupPrivileges.md#groupprivileges)|--|


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
"/groups/string/nested/string/privileges"
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



