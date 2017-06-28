
<a name="onezoneprivileges"></a>
### OnezonePrivileges
The list of Onezone privileges.


|Name|Description|Schema|
|---|---|---|
|**operation**  <br>*optional*|This field determines how the included privileges are handled ('set' - resets to the specified list, 'grant' - adds the specified privileges to existing ones and 'revoke' - removes the listed privileges).  <br>**Default** : `"set"`|enum (set, grant, revoke)|
|**privileges**  <br>*required*||< enum (oz_spaces_add_members, list_groups, oz_providers_list_groups, oz_providers_list, oz_spaces_list_providers, oz_spaces_list, oz_providers_list_spaces, oz_users_list, oz_providers_list_users, oz_groups_add_members, oz_groups_list_groups, oz_groups_list_users, oz_groups_remove_members, oz_handle_services_create, oz_handle_services_list, oz_handles_list, oz_providers_delete, oz_shares_list, oz_spaces_list_groups, oz_spaces_list_users, oz_users_delete, oz_spaces_remove_members, oz_set_privileges, oz_view_privileges) > array|

**Example**
```
{
  "operation" : [ "set" ],
  "privileges" : [ "oz_spaces_add_members", "list_groups", "oz_providers_list_groups", "oz_providers_list", "oz_spaces_list_providers", "oz_spaces_list", "oz_providers_list_spaces", "oz_users_list", "oz_providers_list_users", "oz_groups_add_members", "oz_groups_list_groups", "oz_groups_list_users", "oz_groups_remove_members", "oz_handles_list", "oz_handle_services_create", "oz_handle_services_list", "oz_providers_delete", "oz_shares_list", "oz_spaces_list_groups", "oz_spaces_list_users", "oz_users_delete", "oz_spaces_remove_members", "oz_set_privileges", "oz_view_privileges" ]
}
```



