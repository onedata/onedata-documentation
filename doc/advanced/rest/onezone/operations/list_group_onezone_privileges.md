
<a name="list_group_onezone_privileges"></a>
#### List group's Onezone privileges
```
GET /groups/{id}/privileges
```


##### Description
Returns the list of group privileges for Onezone.

This operation requires `oz_view_privileges` administrator privilege.

***Example cURL requests***

**Get groups privileges to Onezone service**
```bash
curl -u admin:password -X GET \
https://$HOST/api/v3/onezone/groups/T5x_HhFYOnILOCUf9OqgExw00RwaU2MXT5122oWk_sM/privileges

{
  "privileges": []
}
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*|Group ID.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The list of group privileges in Onezone.|[OnezonePrivileges](../definitions/OnezonePrivileges.md#onezoneprivileges)|
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
"/groups/string/privileges"
```


##### Example HTTP response

###### Response 200
```
json :
{
  "privileges" : [ "oz_groups_add_members", "oz_groups_list", "oz_groups_list_groups", "oz_groups_list_users", "oz_groups_remove_members", "oz_handle_services_create", "oz_handle_services_list", "oz_handles_list", "oz_providers_delete", "oz_providers_list", "oz_providers_list_groups", "oz_providers_list_spaces", "oz_providers_list_users", "oz_set_privileges", "oz_shares_list", "oz_spaces_add_members", "oz_spaces_list", "oz_spaces_list_groups", "oz_spaces_list_providers", "oz_spaces_list_users", "oz_spaces_remove_members", "oz_users_delete", "oz_users_list", "oz_view_privileges" ]
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



