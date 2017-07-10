
<a name="groupprivileges"></a>
### GroupPrivileges
The list of group privileges.


|Name|Description|Schema|
|---|---|---|
|**operation**  <br>*optional*|This field determines how the included privileges are handled ('set' - resets to the specified list, 'grant' - adds the specified privileges to existing ones and 'revoke' - removes the listed privileges)  <br>**Default** : `"set"`|enum (set, grant, revoke)|
|**privileges**  <br>*required*||< enum (group_create_space, group_delete, group_invite_group, group_invite_user, group_join_group, group_join_space, group_leave_space, group_remove_group, group_remove_user, group_set_privileges, group_update, group_view) > array|

**Example**
```
{
  "privileges" : [ "group_create_space", "group_delete", "group_invite_group", "group_invite_user", "group_join_group", "group_join_space", "group_leave_space", "group_remove_group", "group_remove_user", "group_set_privileges", "group_update", "group_view" ]
}
```



