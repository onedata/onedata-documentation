
<a name="list_effective_child_group_privileges"></a>
#### List effective child group privileges
```
GET /groups/{id}/effective_children/{cid}/privileges
```


##### Description
Returns the list of effective child group privileges in a specific group.

This operation requires `group_view` privilege.

***Example cURL requests***

**Get child group privileges in a group**
```bash
curl -u username:password -X GET \
https://$HOST:8443/api/v3/onezone/groups/HwUpk8jrwxKOe45uzLFX2GVC8lKEasj4q253sptVqF8/effective_children/T5x_HhFYOnILOCUf9OqgExw00RwaU2MXT5122oWk_sM/privileges

{
  "privileges": [
    "group_view"
  ]
}
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**cid**  <br>*required*|Effective child group ID.|string|--|
|**Path**|**id**  <br>*required*|Group ID.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The list of effective child group privileges in a group.|[GroupPrivileges](../definitions/GroupPrivileges.md#groupprivileges)|
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
"/groups/string/effective_children/string/privileges"
```


##### Example HTTP response

###### Response 200
```
json :
{
  "privileges" : [ "group_update", "group_create_space", "group_invite_group", "group_invite_user", "group_join_group", "group_join_space", "group_leave_space", "group_delete", "group_remove_group", "group_remove_user", "group_set_privileges", "group_view" ]
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



