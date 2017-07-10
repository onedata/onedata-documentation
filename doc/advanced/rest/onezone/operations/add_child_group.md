
<a name="add_child_group"></a>
#### Add child group
```
PUT /groups/{id}/children/{cid}
```


##### Description
Adds group {cid} as child group of {id}.

For administrator who do not need to be members of this group
`oz_groups_add_members` privilege is required.

***Example cURL requests***

**Add child group**
```bash
curl -u username:password -X PUT \
https://$HOST:8443/api/v3/onezone/groups/HwUpk8jrwxKOe45uzLFX2GVC8lKEasj4q253sptVqF8/children/T5x_HhFYOnILOCUf9OqgExw00RwaU2MXT5122oWk_sM
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**cid**  <br>*required*|Child group ID.|string|--|
|**Path**|**id**  <br>*required*|Group ID.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|Information about a specific child group.|[GroupPrivileges](../definitions/GroupPrivileges.md#groupprivileges)|
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
"/groups/string/children/string"
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



