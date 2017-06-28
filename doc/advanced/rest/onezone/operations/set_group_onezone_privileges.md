
<a name="set_group_onezone_privileges"></a>
#### Set group's Onezone privileges
```
PATCH /groups/{id}/privileges
```


##### Description
Modifies privileges for a group {id} for Onezone.

This operation requires `oz_set_privileges` privilege.

***Example cURL requests***

**Set groups privileges to Onezone service**
```bash
curl -H "Content-type: application/json"  -X PUT \
-d '{"privileges": ["oz_spaces_list"]}' \
https://$HOST:8443/api/v3/onezone/groups/T5x_HhFYOnILOCUf9OqgExw00RwaU2MXT5122oWk_sM/privileges
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*|Group ID.|string|--|
|**Body**|**data**  <br>*optional*|User Onezone privileges.|[OnezonePrivileges](../definitions/OnezonePrivileges.md#onezoneprivileges)|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|The group privileges have been added.|No Content|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**401**|Authentication error.|[Error](../definitions/Error.md#error)|
|**403**|Authorization error.|[Error](../definitions/Error.md#error)|
|**404**|Resource not found.|[Error](../definitions/Error.md#error)|
|**500**|Internal server Error.|[Error](../definitions/Error.md#error)|


##### Example HTTP request

###### Request path
```
json :
"/groups/string/privileges"
```


###### Request body
```
json :
{
  "operation" : [ "set" ],
  "privileges" : [ "oz_spaces_add_members", "list_groups", "oz_providers_list_groups", "oz_providers_list", "oz_spaces_list_providers", "oz_spaces_list", "oz_providers_list_spaces", "oz_users_list", "oz_providers_list_users", "oz_groups_add_members", "oz_groups_list_groups", "oz_groups_list_users", "oz_groups_remove_members", "oz_handles_list", "oz_handle_services_create", "oz_handle_services_list", "oz_providers_delete", "oz_shares_list", "oz_spaces_list_groups", "oz_spaces_list_users", "oz_users_delete", "oz_spaces_remove_members", "oz_set_privileges", "oz_view_privileges" ]
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



