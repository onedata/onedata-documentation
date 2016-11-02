
<a name="paths"></a>
## Paths

<a name="group_resource"></a>
### Group
Group related operations


|Path|Method|Description|
|---|---|---|
|[/groups](operations/create_group.md)|POST|Create new group|
|[/groups](operations/list_groups.md)|GET|List all groups|
|[/groups/{id}](operations/get_group.md)|GET|Get group details|
|[/groups/{id}](operations/remove_group.md)|DELETE|Remove group|
|[/groups/{id}](operations/modify_group.md)|PATCH|Modify group details|
|[/groups/{id}/effective_users](operations/get_group_effective_users.md)|GET|Get effective group users|
|[/groups/{id}/effective_users/{uid}](operations/get_groups_effective_user.md)|GET|Get group effective user details|
|[/groups/{id}/effective_users/{uid}/privileges](operations/get_groups_user_privileges.md)|GET|Get user group privileges|
|[/groups/{id}/nested](operations/get_nested_groups.md)|GET|Get subgroups|
|[/groups/{id}/nested/join](operations/join_nested_group.md)|POST|Add subgroup|
|[/groups/{id}/nested/token](operations/get_nested_group_token.md)|GET|Create subgroup invitation token|
|[/groups/{id}/nested/{nid}](operations/get_nested_group.md)|GET|Get subgroup details|
|[/groups/{id}/nested/{nid}](operations/delete_nested_group.md)|DELETE|Remove subgroup|
|[/groups/{id}/nested/{nid}/privileges](operations/get_nested_group_privileges.md)|GET|Get subgroup privileges|
|[/groups/{id}/nested/{nid}/privileges](operations/set_nested_group_privileges.md)|PUT|Set subgroup privileges|
|[/groups/{id}/parent](operations/get_parent_groups.md)|GET|Get parent groups|
|[/groups/{id}/parent/{pid}](operations/get_parent_group.md)|GET|Get parent group details|
|[/groups/{id}/privileges](operations/get_group_onezone_privileges.md)|GET|Get group's Onezone privileges|
|[/groups/{id}/privileges](operations/remove_group_onezone_privileges.md)|DELETE|Remove group's Onezone privileges|
|[/groups/{id}/privileges](operations/set_group_onezone_privileges.md)|PATCH|Set group's Onezone privileges|
|[/groups/{id}/spaces](operations/create_space_for_group.md)|POST|Creates new space for group|
|[/groups/{id}/spaces](operations/get_group_spaces.md)|GET|Get group's spaces|
|[/groups/{id}/spaces/join](operations/group_join_space.md)|POST|Join space by group|
|[/groups/{id}/spaces/token](operations/create_group_spaces_token.md)|GET|Create space creation token for group|
|[/groups/{id}/spaces/{sid}](operations/get_group_space.md)|GET|Get group's space details|
|[/groups/{id}/spaces/{sid}](operations/remove_group_from_space.md)|DELETE|Remove group from space|
|[/groups/{id}/users](operations/get_group_users.md)|GET|Get group users|
|[/groups/{id}/users/token](operations/create_user_group_invite_token.md)|GET|Create user invite token for group|
|[/groups/{id}/users/{uid}](operations/get_group_user.md)|GET|Get group user details|
|[/groups/{id}/users/{uid}](operations/remove_group_user.md)|DELETE|Remove user from group|
|[/groups/{id}/users/{uid}/privileges](operations/get_user_group_privileges.md)|GET|Get user's group privileges|
|[/groups/{id}/users/{uid}/privileges](operations/set_user_group_privileges.md)|PUT|Set user's group privileges|


<a name="handle_resource"></a>
### Handle
Operations for managing Handle system service and identifier generation.


|Path|Method|Description|
|---|---|---|
|[/handle_services](operations/add_handle_service.md)|POST|Add handle service|
|[/handle_services](operations/get_handle_services.md)|GET|Get handle services|
|[/handle_services/{id}](operations/get_handle_service.md)|GET|Get handle service|
|[/handle_services/{id}](operations/remove_handle_service.md)|DELETE|Unregister handle service|
|[/handle_services/{id}](operations/modify_handle_service.md)|PATCH|Modify handle service|
|[/handle_services/{id}/groups](operations/list_handle_service_groups.md)|GET|Get handle service groups|
|[/handle_services/{id}/groups/{gid}](operations/add_handle_service_group.md)|PUT|Add handle service group|
|[/handle_services/{id}/groups/{gid}](operations/remove_handle_service_group.md)|DELETE|Remove handle service group|
|[/handle_services/{id}/groups/{gid}/privileges](operations/get_handle_service_group_privileges.md)|GET|Get handle service group privileges|
|[/handle_services/{id}/groups/{gid}/privileges](operations/set_handle_service_group_privileges.md)|PUT|Set handle service groups privileges|
|[/handle_services/{id}/users](operations/list_handle_service_users.md)|GET|Get handle service users|
|[/handle_services/{id}/users/{uid}](operations/add_handle_service_user.md)|PUT|Add handle service user|
|[/handle_services/{id}/users/{uid}](operations/remove_handle_service_user.md)|DELETE|Remove handle service user|
|[/handle_services/{id}/users/{uid}/privileges](operations/get_handle_service_user_privileges.md)|GET|Get handle service user privileges|
|[/handle_services/{id}/users/{uid}/privileges](operations/set_handle_service_user_privileges.md)|PUT|Set handle service user privileges|
|[/handles](operations/register_handle.md)|POST|Register handle|
|[/handles](operations/get_handles.md)|GET|Get handles|
|[/handles/{hndl}](operations/get_handle.md)|GET|Get handle|
|[/handles/{hndl}](operations/delete_handle.md)|DELETE|Unregister handle|
|[/handles/{hndl}](operations/modify_handle.md)|PATCH|Modify handle|
|[/handles/{hndl}/groups](operations/list_handle_groups.md)|GET|Get handle groups|
|[/handles/{hndl}/groups/{gid}](operations/add_handle_group.md)|PUT|Add handle group|
|[/handles/{hndl}/groups/{gid}](operations/remove_handle_group.md)|DELETE|Remove handle group|
|[/handles/{hndl}/groups/{gid}/privileges](operations/get_handle_group_privileges.md)|GET|Get handle group privileges|
|[/handles/{hndl}/groups/{gid}/privileges](operations/set_handle_group_privileges.md)|PUT|Set handle groups privileges|
|[/handles/{hndl}/users](operations/list_handle_users.md)|GET|Get handle users|
|[/handles/{hndl}/users/{uid}](operations/add_handle_user.md)|PUT|Add handle user|
|[/handles/{hndl}/users/{uid}](operations/remove_handle_user.md)|DELETE|Remove handle user|
|[/handles/{hndl}/users/{uid}/privileges](operations/get_handle_user_privileges.md)|GET|Get handle user privileges|
|[/handles/{hndl}/users/{uid}/privileges](operations/set_handle_user_privileges.md)|PUT|Set handle user privileges|


<a name="provider_resource"></a>
### Provider
Provider related operations


|Path|Method|Description|
|---|---|---|
|[/provider](operations/register_provider.md)|POST|Register provider|
|[/provider](operations/get_provider_details.md)|GET|Get provider details|
|[/provider](operations/unregister_provider.md)|DELETE|Unregister provider|
|[/provider](operations/modify_provider.md)|PATCH|Modify provider details|
|[/provider/spaces](operations/create_provider_space.md)|POST|Create new space by provider|
|[/provider/spaces](operations/get_supported_spaces.md)|GET|Get spaces at provider|
|[/provider/spaces/support](operations/provider_space_support.md)|POST|Add space storage support|
|[/provider/spaces/{sid}](operations/get_supported_space.md)|GET|Get space details by provider|
|[/provider/spaces/{sid}](operations/remove_space_support.md)|DELETE|Remove space support|
|[/provider/test/check_my_ip](operations/check_my_ip.md)|GET|Show client IP address|
|[/provider/test/check_my_ports](operations/check_my_ports.md)|POST|Check ports availability|
|[/providers](operations/get_providers.md)|GET|Get providers|
|[/providers/{pid}](operations/get_other_provider.md)|GET|Get other provider details|
|[/providers/{pid}/groups](operations/list_provider_groups.md)|GET|Get groups of provider|
|[/providers/{pid}/groups/{gid}](operations/get_provider_group.md)|GET|Get group of provider|
|[/providers/{pid}/spaces](operations/list_provider_spaces.md)|GET|Get spaces supported by provider|
|[/providers/{pid}/spaces/{sid}](operations/get_provider_space.md)|GET|Get space supported by provider|
|[/providers/{pid}/users](operations/list_provider_users.md)|GET|Get users of provider|
|[/providers/{pid}/users/{uid}](operations/get_provider_user.md)|GET|Get user of provider|


<a name="space_resource"></a>
### Space
Space related operations


|Path|Method|Description|
|---|---|---|
|[/shares/{id}](operations/get_share.md)|GET|Get share details|
|[/shares/{id}](operations/remove_share.md)|DELETE|Remove share|
|[/shares/{id}](operations/modify_share.md)|PATCH|Modify share details|
|[/spaces](operations/create_space.md)|POST|Create new space|
|[/spaces](operations/get_spaces.md)|GET|List all spaces|
|[/spaces/{id}](operations/get_space.md)|GET|Get space details|
|[/spaces/{id}](operations/remove_space.md)|DELETE|Remove space|
|[/spaces/{id}](operations/modify_space.md)|PATCH|Modify space details|
|[/spaces/{id}/groups](operations/add_group_to_space.md)|POST|Add group to space|
|[/spaces/{id}/groups](operations/get_space_groups.md)|GET|Get space groups|
|[/spaces/{id}/groups/token](operations/get_space_group_token.md)|GET|Create space invite token for group|
|[/spaces/{id}/groups/{gid}](operations/get_space_group.md)|GET|Get group details|
|[/spaces/{id}/groups/{gid}](operations/delete_space_group.md)|DELETE|Remove group from space|
|[/spaces/{id}/groups/{gid}/privileges](operations/get_space_group_privileges.md)|GET|Get group privileges to space|
|[/spaces/{id}/groups/{gid}/privileges](operations/set_space_group_privileges.md)|PUT|Set group privileges to space|
|[/spaces/{id}/providers](operations/get_space_providers.md)|GET|Get space providers|
|[/spaces/{id}/providers/token](operations/get_space_provider_token.md)|GET|Create space support token|
|[/spaces/{id}/providers/{pid}](operations/get_space_provider.md)|GET|Get space provider details|
|[/spaces/{id}/providers/{pid}](operations/remove_provider_supporting_space.md)|DELETE|Remove space support|
|[/spaces/{id}/shares](operations/get_space_shares.md)|GET|Get space shares|
|[/spaces/{id}/shares/{sid}](operations/create_share.md)|PUT|Create new share|
|[/spaces/{id}/users](operations/add_user_to_space.md)|POST|Add user to space|
|[/spaces/{id}/users](operations/get_space_users.md)|GET|Get space users|
|[/spaces/{id}/users/token](operations/get_space_user_token.md)|GET|Create space invite token|
|[/spaces/{id}/users/{uid}](operations/get_space_user.md)|GET|Get space user details|
|[/spaces/{id}/users/{uid}](operations/remove_space_user.md)|DELETE|Remove user from space|
|[/spaces/{id}/users/{uid}/privileges](operations/get_space_user_privileges.md)|GET|Get user privileges to space|
|[/spaces/{id}/users/{uid}/privileges](operations/set_space_user_privileges.md)|PUT|Set user privileges to space|


<a name="user_resource"></a>
### User
User related operations


|Path|Method|Description|
|---|---|---|
|[/user](operations/get_current_user.md)|GET|Get current user details|
|[/user](operations/remove_user.md)|DELETE|Remove user|
|[/user](operations/modify_user.md)|PATCH|Modify user|
|[/user/authorize](operations/authenticate_user.md)|POST|Authenticate user|
|[/user/client_token](operations/get_client_token.md)|GET|Create user authorization token|
|[/user/groups](operations/create_group_for_user.md)|POST|Create new group|
|[/user/groups](operations/get_user_groups.md)|GET|Get user groups|
|[/user/groups/join](operations/join_group.md)|POST|Join group|
|[/user/groups/{gid}](operations/get_user_group.md)|GET|Get group details|
|[/user/groups/{gid}](operations/leave_group.md)|DELETE|Leave group|
|[/user/spaces](operations/create_user_space.md)|POST|Create new user space|
|[/user/spaces](operations/get_user_spaces.md)|GET|Get user spaces|
|[/user/spaces/default](operations/get_user_default_space.md)|GET|Get default space|
|[/user/spaces/default](operations/set_user_default_space.md)|PUT|Set default space|
|[/user/spaces/join](operations/join_space.md)|POST|Join space|
|[/user/spaces/token](operations/get_user_space_token.md)|GET|Create space invitation token|
|[/user/spaces/{sid}](operations/get_user_space.md)|GET|Get space details|
|[/user/spaces/{sid}](operations/delete_user_space.md)|DELETE|Leave space|
|[/users](operations/list_users.md)|GET|List all users|
|[/users/{id}](operations/get_user.md)|GET|Get user details|
|[/users/{id}/privileges](operations/get_user_onezone_privileges.md)|GET|Get user's Onezone privileges|
|[/users/{id}/privileges](operations/remove_user_onezone_privileges.md)|DELETE|Remove user's Onezone privileges|
|[/users/{id}/privileges](operations/set_user_onezone_privileges.md)|PATCH|Set user's Onezone privileges|



