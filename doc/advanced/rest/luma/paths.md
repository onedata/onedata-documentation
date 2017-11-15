
<a name="paths"></a>
## Paths

<a name="admin_resource"></a>
### Admin
LUMA management endpoint


|Path|Method|Description|
|---|---|---|
|[/admin/users](operations/add_user_details.md)|POST|Add user details|
|[/admin/users/{lid}](operations/get_user_details.md)|GET|Get user details|
|[/admin/users/{lid}](operations/update_user_details.md)|PUT|Update user details|
|[/admin/users/{lid}](operations/delete_user.md)|DELETE|Delete user details|
|[/admin/users/{lid}/credentials](operations/add_user_credentials.md)|PUT|Add user credentials|
|[/admin/{idp}/groups/{groupId}](operations/get_group_mapping.md)|GET|Get group mapping|
|[/admin/{idp}/groups/{groupId}](operations/add_group_mapping.md)|PUT|Set group mapping|
|[/admin/{idp}/groups/{groupId}](operations/delete_group_mapping.md)|DELETE|Delete group mapping|


<a name="mapping_resource"></a>
### Mapping
User and group mapping


|Path|Method|Description|
|---|---|---|
|[/map_group](operations/map_group.md)|POST|Map group|
|[/map_user_credentials](operations/map_user_credentials.md)|POST|Map user credentials|
|[/resolve_acl_group](operations/resolve_acl_group_identity.md)|POST|Resolve group ACL identity|
|[/resolve_acl_user](operations/resolve_acl_user_identity.md)|POST|Resolve user ACL identity|
|[/resolve_group](operations/resolve_group.md)|POST|Resolve group identity|
|[/resolve_user](operations/resolve_user_identity.md)|POST|Resolve user identity|



