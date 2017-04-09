
<a name="list_current_user_effective_privileges"></a>
#### List current user effective privileges
```
GET /user/effective_privileges
```


##### Description
Returns the list of currently authenticated user effective privileges for Onezone.

This operation can be invoked on behalf of current user only.

***Example cURL requests***

**Get users privileges to Onezone service**
```bash
curl -u username:password -X GET  \
https://$HOST:8443/api/v3/onezone/user/effective_privileges

{
  "privileges": []
}
```


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The list of user effective privileges in Onezone.|[OnezonePrivileges](../definitions/OnezonePrivileges.md#onezoneprivileges)|
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
"/user/effective_privileges"
```


##### Example HTTP response

###### Response 200
```
json :
{
  "privileges" : [ "add_member_to_space", "list_groups", "list_groups_of_provider", "list_providers", "list_providers_of_space", "list_spaces", "list_spaces_of_provider", "list_users", "list_users_of_provider", "oz_groups_add_members", "oz_groups_list_groups", "oz_groups_list_users", "oz_groups_remove_members", "oz_handles_list", "oz_handle_services_create", "oz_handle_services_list", "oz_providers_delete", "oz_shares_list", "oz_spaces_list_groups", "oz_spaces_list_users", "oz_users_delete", "remove_member_from_space", "set_privileges", "view_privileges" ]
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



