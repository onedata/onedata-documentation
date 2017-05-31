
<a name="paths"></a>
## Paths

<a name="group_resource"></a>
### Group
Group management operations


|Path|Method|Description|
|---|---|---|
|[/groups](operations/create_group.md)|POST|Create new group|
|[/groups](operations/list_groups.md)|GET|List all groups|
|[/groups/{id}](operations/get_group.md)|GET|Get group details|
|[/groups/{id}](operations/remove_group.md)|DELETE|Remove group|
|[/groups/{id}](operations/modify_group.md)|PATCH|Modify group details|
|[/groups/{id}/children](operations/list_child_groups.md)|GET|Get subgroups|
|[/groups/{id}/children/token](operations/create_child_group_token.md)|POST|Create child group invitation token|
|[/groups/{id}/children/{cid}](operations/get_child_group.md)|GET|Get subgroup details|
|[/groups/{id}/children/{cid}](operations/add_child_group.md)|PUT|Add child group|
|[/groups/{id}/children/{cid}](operations/remove_child_group.md)|DELETE|Remove subgroup|
|[/groups/{id}/children/{cid}/privileges](operations/list_child_group_privileges.md)|GET|List child group privileges|
|[/groups/{id}/children/{cid}/privileges](operations/set_child_group_privileges.md)|PATCH|Set subgroup privileges|
|[/groups/{id}/effective_children](operations/get_effective_children_groups.md)|GET|Get effective child groups|
|[/groups/{id}/effective_children/{cid}](operations/get_effective_child_group.md)|GET|Get effective child group details|
|[/groups/{id}/effective_children/{cid}/privileges](operations/list_effective_child_group_privileges.md)|GET|List effective child group privileges|
|[/groups/{id}/effective_children/{cid}/privileges](operations/set_effective_child_group_privileges.md)|PATCH|Set effective child group privileges|
|[/groups/{id}/effective_handle_services](operations/list_effective_group_handle_services.md)|GET|List effective group handle services|
|[/groups/{id}/effective_handle_services/{hsid}](operations/get_group_effective_handle_service.md)|GET|Get effective group handle service details|
|[/groups/{id}/effective_handles](operations/list_effective_group_handles.md)|GET|List effective group handles|
|[/groups/{id}/effective_handles/{hid}](operations/get_effective_group_handle.md)|GET|Get effective group handle details|
|[/groups/{id}/effective_parents](operations/list_effective_parent_groups.md)|GET|List effective parent groups|
|[/groups/{id}/effective_parents/{pid}](operations/get_effective_parent_group.md)|GET|Get effective parent group details|
|[/groups/{id}/effective_privileges](operations/list_effective_group_privileges.md)|GET|List group's effective privileges|
|[/groups/{id}/effective_providers](operations/list_effective_group_providers.md)|GET|List effective group's providers|
|[/groups/{id}/effective_providers/{pid}](operations/get_effective_group_provider.md)|GET|Get effective group's provider details|
|[/groups/{id}/effective_spaces](operations/list_effective_group_spaces.md)|GET|List effective group's spaces|
|[/groups/{id}/effective_spaces/{sid}](operations/get_effective_group_space.md)|GET|Get effective group space details|
|[/groups/{id}/effective_users](operations/list_effective_group_users.md)|GET|List effective group users|
|[/groups/{id}/effective_users/{uid}](operations/get_effective_group_user.md)|GET|Get effective group user details|
|[/groups/{id}/effective_users/{uid}/privileges](operations/list_groups_user_privileges.md)|GET|List user group privileges|
|[/groups/{id}/handle_services](operations/add_group_handle_service.md)|POST|Add group handle service|
|[/groups/{id}/handle_services](operations/list_group_handle_services.md)|GET|List group handle services|
|[/groups/{id}/handle_services/{hsid}](operations/get_group_handle_service.md)|GET|Get group handle service details|
|[/groups/{id}/handle_services/{hsid}](operations/remove_group_handle_service.md)|DELETE|Remove group handle service|
|[/groups/{id}/handles](operations/create_group_handle.md)|POST|Create new group handle|
|[/groups/{id}/handles](operations/list_group_handles.md)|GET|List group handles|
|[/groups/{id}/handles/{hid}](operations/get_group_handle.md)|GET|Get group handle details|
|[/groups/{id}/handles/{hid}](operations/remove_group_handle.md)|DELETE|Remove group handle|
|[/groups/{id}/parents](operations/list_parent_groups.md)|GET|List parent groups|
|[/groups/{id}/parents/join](operations/join_parent_group.md)|POST|Join parent group|
|[/groups/{id}/parents/{pid}](operations/get_parent_group.md)|GET|Get parent group details|
|[/groups/{id}/privileges](operations/list_group_onezone_privileges.md)|GET|List group's Onezone privileges|
|[/groups/{id}/privileges](operations/remove_group_onezone_privileges.md)|DELETE|Remove group's Onezone privileges|
|[/groups/{id}/privileges](operations/set_group_onezone_privileges.md)|PATCH|Set group's Onezone privileges|
|[/groups/{id}/spaces](operations/create_space_for_group.md)|POST|Create new space for group|
|[/groups/{id}/spaces](operations/list_group_spaces.md)|GET|List group's spaces|
|[/groups/{id}/spaces/join](operations/group_join_space.md)|POST|Join space by group|
|[/groups/{id}/users](operations/list_group_users.md)|GET|List group users|
|[/groups/{id}/users/token](operations/create_user_group_invite_token.md)|POST|Create user invite token for group|
|[/groups/{id}/users/{uid}](operations/get_group_user.md)|GET|Get group user details|
|[/groups/{id}/users/{uid}](operations/add_group_user.md)|PUT|Add user to group|
|[/groups/{id}/users/{uid}](operations/remove_group_user.md)|DELETE|Remove user from group|
|[/groups/{id}/users/{uid}/privileges](operations/list_user_group_privileges.md)|GET|List user's group privileges|
|[/groups/{id}/users/{uid}/privileges](operations/set_user_group_privileges.md)|PATCH|Set user's group privileges|


<a name="handle_resource"></a>
### Handle
Operations for managing Handle system service and identifier generation.


|Path|Method|Description|
|---|---|---|
|[/handle_services](operations/add_handle_service.md)|POST|Add handle service|
|[/handle_services](operations/list_handle_services.md)|GET|List handle services|
|[/handle_services/{id}](operations/get_handle_service.md)|GET|Get handle service|
|[/handle_services/{id}](operations/remove_handle_service.md)|DELETE|Unregister handle service|
|[/handle_services/{id}](operations/modify_handle_service.md)|PATCH|Modify handle service|
|[/handle_services/{id}/effective_groups](operations/list_effective_handle_service_groups.md)|GET|List effective handle service groups|
|[/handle_services/{id}/effective_groups/{gid}](operations/get_effective_handle_service_group.md)|GET|Get effective handle service group|
|[/handle_services/{id}/effective_groups/{gid}/privileges](operations/get_effective_handle_service_group_privileges.md)|GET|Get effective handle service group privileges|
|[/handle_services/{id}/effective_users](operations/list_effective_handle_service_users.md)|GET|Get effective handle service users|
|[/handle_services/{id}/effective_users/{uid}](operations/get_effective_handle_service_user.md)|GET|Get effective handle service user|
|[/handle_services/{id}/effective_users/{uid}/privileges](operations/list_effective_handle_service_user_privileges.md)|GET|List effective handle service user privileges|
|[/handle_services/{id}/groups](operations/list_handle_service_groups.md)|GET|List handle service groups|
|[/handle_services/{id}/groups/{gid}](operations/get_handle_service_group.md)|GET|Get handle service group details|
|[/handle_services/{id}/groups/{gid}](operations/add_handle_service_group.md)|PUT|Add handle service group|
|[/handle_services/{id}/groups/{gid}](operations/remove_handle_service_group.md)|DELETE|Remove handle service group|
|[/handle_services/{id}/groups/{gid}/privileges](operations/list_handle_service_group_privileges.md)|GET|List handle service group privileges|
|[/handle_services/{id}/groups/{gid}/privileges](operations/set_handle_service_group_privileges.md)|PATCH|Set handle service groups privileges|
|[/handle_services/{id}/handles](operations/list_handleservice_handles.md)|GET|List handle service handles|
|[/handle_services/{id}/handles/{hid}](operations/get_handle_service_handle.md)|GET|Get handle from handle service|
|[/handle_services/{id}/users](operations/list_handle_service_users.md)|GET|Get handle service users|
|[/handle_services/{id}/users/{uid}](operations/get_handle_service_user.md)|GET|Get handle service user|
|[/handle_services/{id}/users/{uid}](operations/add_handle_service_user.md)|PUT|Add handle service user|
|[/handle_services/{id}/users/{uid}](operations/remove_handle_service_user.md)|DELETE|Remove handle service user|
|[/handle_services/{id}/users/{uid}/privileges](operations/get_handle_service_user_privileges.md)|GET|List handle service user privileges|
|[/handle_services/{id}/users/{uid}/privileges](operations/set_handle_service_user_privileges.md)|PATCH|Set handle service user privileges|
|[/handles](operations/register_handle.md)|POST|Register handle|
|[/handles](operations/list_handles.md)|GET|List handles|
|[/handles/{hndl}](operations/get_handle.md)|GET|Get handle|
|[/handles/{hndl}](operations/remove_handle.md)|DELETE|Unregister handle|
|[/handles/{hndl}](operations/modify_handle.md)|PATCH|Modify handle|
|[/handles/{hndl}/effective_groups](operations/list_effective_handle_groups.md)|GET|Get effective handle groups|
|[/handles/{hndl}/effective_groups/{gid}](operations/get_effective_handle_group.md)|GET|Get effective handle group|
|[/handles/{hndl}/effective_groups/{gid}/privileges](operations/list_effective_handle_group_privileges.md)|GET|List effective handle group privileges|
|[/handles/{hndl}/effective_users](operations/list_effective_handle_users.md)|GET|List effective handle users|
|[/handles/{hndl}/effective_users/{uid}](operations/get_effective_handle_user.md)|GET|Get effective handle user|
|[/handles/{hndl}/effective_users/{uid}/privileges](operations/list_effective_handle_user_privileges.md)|GET|List effective handle user privileges|
|[/handles/{hndl}/groups](operations/list_handle_groups.md)|GET|List handle groups|
|[/handles/{hndl}/groups/{gid}](operations/get_handle_group.md)|GET|Get handle group|
|[/handles/{hndl}/groups/{gid}](operations/add_handle_group.md)|PUT|Add handle group|
|[/handles/{hndl}/groups/{gid}](operations/remove_handle_group.md)|DELETE|Remove handle group|
|[/handles/{hndl}/groups/{gid}/privileges](operations/list_handle_group_privileges.md)|GET|List handle group privileges|
|[/handles/{hndl}/groups/{gid}/privileges](operations/set_handle_group_privileges.md)|PATCH|Set handle groups privileges|
|[/handles/{hndl}/users](operations/list_handle_users.md)|GET|List handle users|
|[/handles/{hndl}/users/{uid}](operations/get_handle_user.md)|GET|Get handle user|
|[/handles/{hndl}/users/{uid}](operations/add_handle_user.md)|PUT|Add handle user|
|[/handles/{hndl}/users/{uid}](operations/remove_handle_user.md)|DELETE|Remove handle user|
|[/handles/{hndl}/users/{uid}/privileges](operations/list_handle_user_privileges.md)|GET|List handle user privileges|
|[/handles/{hndl}/users/{uid}/privileges](operations/set_handle_user_privileges.md)|PATCH|Set handle user privileges|


<a name="provider_resource"></a>
### Provider
Provider management operations


|Path|Method|Description|
|---|---|---|
|[/provider](operations/register_provider.md)|POST|Register provider|
|[/provider](operations/get_current_provider_details.md)|GET|Get provider details|
|[/provider](operations/unregister_provider.md)|DELETE|Unregister provider|
|[/provider](operations/modify_provider.md)|PATCH|Modify provider details|
|[/provider/spaces](operations/list_supported_spaces.md)|GET|List spaces at provider|
|[/provider/spaces/support](operations/provider_space_support.md)|POST|Add space storage support|
|[/provider/spaces/{sid}](operations/get_supported_space.md)|GET|Get space details by provider|
|[/provider/spaces/{sid}](operations/remove_space_support.md)|DELETE|Remove space support|
|[/provider/spaces/{sid}](operations/modify_supported_space.md)|PATCH|Modify supported space|
|[/provider/test/check_my_ip](operations/check_my_ip.md)|GET|Show client IP address|
|[/provider/test/check_my_ports](operations/check_my_ports.md)|POST|Check ports availability|
|[/providers](operations/list_providers.md)|GET|List providers|
|[/providers/{pid}](operations/get_provider_details.md)|GET|Get provider details|
|[/providers/{pid}](operations/remove_provider.md)|DELETE|Remove provider|
|[/providers/{pid}/effective_groups](operations/list_effective_provider_groups.md)|GET|List effective groups of provider|
|[/providers/{pid}/effective_groups/{gid}](operations/get_effective_provider_group.md)|GET|Get group of provider|
|[/providers/{pid}/effective_users](operations/list_effective_provider_users.md)|GET|List effective users of provider|
|[/providers/{pid}/effective_users/{uid}](operations/get_effective_provider_user.md)|GET|Get effective user of provider|
|[/providers/{pid}/spaces](operations/list_provider_spaces.md)|GET|List spaces supported by provider|
|[/providers/{pid}/spaces/{sid}](operations/get_provider_space.md)|GET|Get space supported by provider|


<a name="space_resource"></a>
### Space
Space management operations


|Path|Method|Description|
|---|---|---|
|[/shares](operations/create_share.md)|POST|Create share|
|[/shares](operations/list_shares.md)|GET|List all shares|
|[/shares/{id}](operations/get_share.md)|GET|Get share details|
|[/shares/{id}](operations/remove_share.md)|DELETE|Remove share|
|[/shares/{id}](operations/modify_share.md)|PATCH|Modify share details|
|[/spaces](operations/create_space.md)|POST|Create new space|
|[/spaces](operations/list_spaces.md)|GET|List all spaces|
|[/spaces/{id}](operations/get_space.md)|GET|Get space details|
|[/spaces/{id}](operations/remove_space.md)|DELETE|Remove space|
|[/spaces/{id}](operations/modify_space.md)|PATCH|Modify space details|
|[/spaces/{id}/effective_groups](operations/list_effective_space_groups.md)|GET|List effective space groups|
|[/spaces/{id}/effective_groups/{gid}](operations/get_effective_space_group.md)|GET|Get effective space group details|
|[/spaces/{id}/effective_groups/{gid}/privileges](operations/list_effective_space_group_privileges.md)|GET|List effective group privileges to space|
|[/spaces/{id}/effective_users](operations/list_effective_space_users.md)|GET|List effective space users|
|[/spaces/{id}/effective_users/{uid}](operations/get_effective_space_user.md)|GET|Get effective space user details|
|[/spaces/{id}/effective_users/{uid}/privileges](operations/list_effective_space_user_privileges.md)|GET|List effective user privileges to space|
|[/spaces/{id}/groups](operations/list_space_groups.md)|GET|List space groups|
|[/spaces/{id}/groups/token](operations/create_space_group_token.md)|POST|Create space invite token for group|
|[/spaces/{id}/groups/{gid}](operations/get_space_group.md)|GET|Get group details|
|[/spaces/{id}/groups/{gid}](operations/add_group_to_space.md)|PUT|Add group to space|
|[/spaces/{id}/groups/{gid}](operations/remove_space_group.md)|DELETE|Remove group from space|
|[/spaces/{id}/groups/{gid}/privileges](operations/list_space_group_privileges.md)|GET|List group privileges to space|
|[/spaces/{id}/groups/{gid}/privileges](operations/set_space_group_privileges.md)|PATCH|Set group privileges to space|
|[/spaces/{id}/providers](operations/list_space_providers.md)|GET|List space providers|
|[/spaces/{id}/providers/token](operations/create_space_support_token.md)|POST|Create space support token|
|[/spaces/{id}/providers/{pid}](operations/get_space_provider.md)|GET|Get space provider details|
|[/spaces/{id}/providers/{pid}](operations/remove_provider_supporting_space.md)|DELETE|Remove space support|
|[/spaces/{id}/shares](operations/list_space_shares.md)|GET|List space shares|
|[/spaces/{id}/shares/{sid}](operations/get_space_share.md)|GET|Get space share|
|[/spaces/{id}/users](operations/list_space_users.md)|GET|List space users|
|[/spaces/{id}/users/token](operations/create_space_user_invite_token.md)|POST|Create space user invite token|
|[/spaces/{id}/users/{uid}](operations/get_space_user.md)|GET|Get space user details|
|[/spaces/{id}/users/{uid}](operations/add_user_to_space.md)|PUT|Add user to space|
|[/spaces/{id}/users/{uid}](operations/remove_space_user.md)|DELETE|Remove user from space|
|[/spaces/{id}/users/{uid}/privileges](operations/list_space_user_privileges.md)|GET|List user privileges to space|
|[/spaces/{id}/users/{uid}/privileges](operations/set_space_user_privileges.md)|PATCH|Set user privileges to space|


<a name="user_resource"></a>
### User
Regular user operations


|Path|Method|Description|
|---|---|---|
|[/user](operations/get_current_user.md)|GET|Get current user details|
|[/user](operations/remove_current_user.md)|DELETE|Remove current user|
|[/user](operations/modify_current_user.md)|PATCH|Modify current user|
|[/user/authorize](operations/authorize_user.md)|POST|Authenticate user|
|[/user/client_tokens](operations/create_client_token.md)|POST|Generate user access token|
|[/user/client_tokens](operations/list_client_tokens.md)|GET|List user access tokens|
|[/user/client_tokens/{tid}](operations/remove_client_token.md)|DELETE|Delete access token|
|[/user/default_provider](operations/get_default_provider.md)|GET|Get default provider|
|[/user/default_provider](operations/set_default_provider.md)|PUT|Set default provider|
|[/user/default_provider](operations/remove_default_provider.md)|DELETE|Unset default provider|
|[/user/default_space](operations/get_default_space.md)|GET|Get default space|
|[/user/default_space](operations/set_default_space.md)|PUT|Set default space|
|[/user/default_space](operations/remove_default_space.md)|DELETE|Unset default space|
|[/user/effective_groups](operations/list_effective_user_groups.md)|GET|List effective user groups|
|[/user/effective_groups/{gid}](operations/get_user_effective_group.md)|GET|Get effective group details|
|[/user/effective_handle_services](operations/list_user_effective_handle_services.md)|GET|List user effective handle services|
|[/user/effective_handle_services/{hsid}](operations/get_user_effective_handle_service.md)|GET|Get effective handle service details|
|[/user/effective_handles](operations/list_user_effective_handles.md)|GET|Get user effective handles|
|[/user/effective_handles/{hid}](operations/get_user_effective_handle.md)|GET|Get effective handle details|
|[/user/effective_privileges](operations/list_current_user_effective_privileges.md)|GET|List current user effective privileges|
|[/user/effective_providers](operations/list_effective_user_providers.md)|GET|List user effective providers|
|[/user/effective_providers/{pid}](operations/get_effective_user_provider.md)|GET|Get effective provider details|
|[/user/effective_spaces](operations/list_effective_user_spaces.md)|GET|List effective user spaces|
|[/user/effective_spaces/{sid}](operations/get_effective_user_space.md)|GET|Get effective space details|
|[/user/groups](operations/create_group_for_user.md)|POST|Create new group|
|[/user/groups](operations/list_user_groups.md)|GET|List user groups|
|[/user/groups/join](operations/join_group.md)|POST|Join group|
|[/user/groups/{gid}](operations/get_user_group.md)|GET|Get group details|
|[/user/groups/{gid}](operations/leave_group.md)|DELETE|Leave group|
|[/user/handle_services](operations/add_user_handle_service.md)|POST|Add user handle service|
|[/user/handle_services](operations/list_user_handle_services.md)|GET|List user handle services|
|[/user/handle_services/{hsid}](operations/get_user_handle_service.md)|GET|Get user handle service details|
|[/user/handle_services/{hsid}](operations/remove_user_handle_service.md)|DELETE|Remove user handle service|
|[/user/handles](operations/create_user_handle.md)|POST|Create new user handle|
|[/user/handles](operations/list_user_handles.md)|GET|List user handles|
|[/user/handles/{hid}](operations/get_user_handle.md)|GET|Get handle details|
|[/user/handles/{hid}](operations/remove_user_handle.md)|DELETE|Remove handle|
|[/user/privileges](operations/list_current_user_privileges.md)|GET|List current user privileges|
|[/user/privileges](operations/remove_current_user_privileges.md)|DELETE|Remove current user privileges|
|[/user/privileges](operations/set_current_user_privileges.md)|PATCH|Set current user privileges|
|[/user/spaces](operations/create_user_space.md)|POST|Create new user space|
|[/user/spaces](operations/list_user_spaces.md)|GET|List user spaces|
|[/user/spaces/join](operations/join_space.md)|POST|Join space|
|[/user/spaces/{sid}](operations/get_user_space.md)|GET|Get space details|
|[/user/spaces/{sid}](operations/remove_user_space.md)|DELETE|Leave space|
|[/user/spaces/{sid}/alias](operations/get_user_space_alias.md)|GET|Get user space alias|
|[/user/spaces/{sid}/alias](operations/set_user_space_alias.md)|PUT|Set user space alias|
|[/user/spaces/{sid}/alias](operations/remove_user_space_alias.md)|DELETE|Remove space alias|
|[/users/{id}](operations/remove_user.md)|DELETE|Remove user|
|[/users/{id}/privileges](operations/remove_user_onezone_privileges.md)|DELETE|Remove user's Onezone privileges|
|[/users/{id}/privileges](operations/set_user_onezone_privileges.md)|PATCH|Set user's Onezone privileges|


<a name="users_resource"></a>
### Users
User management operations


|Path|Method|Description|
|---|---|---|
|[/users](operations/list_users.md)|GET|List all users|
|[/users/{id}](operations/get_user.md)|GET|Get user details|
|[/users/{id}/effective_privileges](operations/list_user_onezone_effective_privileges.md)|GET|List user's effective Onezone privileges|
|[/users/{id}/privileges](operations/list_user_onezone_privileges.md)|GET|List user Onezone privileges|



