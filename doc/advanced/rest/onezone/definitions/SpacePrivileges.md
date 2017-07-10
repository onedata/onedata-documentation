
<a name="spaceprivileges"></a>
### SpacePrivileges
The list of space privileges.


|Name|Description|Schema|
|---|---|---|
|**operation**  <br>*optional*|This field determines how the included privileges are handled ('set' - resets to the specified list, 'grant' - adds the specified privileges to existing ones and 'revoke' - removes the listed privileges).  <br>**Default** : `"set"`|enum (set, grant, revoke)|
|**privileges**  <br>*required*||< enum (space_delete, space_invite_group, space_invite_provider, space_invite_user, space_manage_shares, space_remove_group, space_remove_provider, space_remove_user, space_set_privileges, space_update, space_view, space_write_data) > array|

**Example**
```
{
  "operation" : [ "set" ],
  "privileges" : [ "space_delete", "space_invite_group", "space_invite_provider", "space_invite_user", "space_manage_shares", "space_remove_group", "space_remove_provider", "space_remove_user", "space_set_privileges", "space_update", "space_view", "space_write_data" ]
}
```



