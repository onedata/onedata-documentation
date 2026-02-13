# Admin accounts

Admin accounts interact with the same unified user interface as regular users.
For details about the interface, see [User Interface][].

## Admin Privileges

Admin privileges grant users the ability to perform additional operations in both the GUI and REST API.
These privileges can be modified only via the REST API. For instructions, refer to
the [Update User Admin Privileges][] operation.

Users with admin privileges can access extra features and management options not available
to regular users. Admin privileges overwrite regular user privileges.
Example: user belongs to group, but in that group he does not have privilege to modify privileges,
but have admin privilege: `oz_groups_set_privileges` and
because of that he can modify privileges in that group and others.

Admin privileges cover manage all kinds of resourses:
- privileges — `oz_view_privileges`, `oz_set_privileges`,
- users — `oz_users_list`, `oz_users_view`, `oz_users_create`, `oz_users_manage_passwords`,
`oz_users_update`, `oz_users_delete`, `oz_users_list_relationships`,
`oz_users_add_relationships`, `oz_users_remove_relationships`,
- groups — `oz_groups_list`, `oz_groups_view`, `oz_groups_create`, `oz_groups_update`,
`oz_groups_delete`, `oz_groups_view_privileges`, `oz_groups_set_privileges`,
`oz_groups_list_relationships`, `oz_groups_add_relationships`, `oz_groups_remove_relationships`,
- spaces — `oz_spaces_list`, `oz_spaces_view`, `oz_spaces_create`, `oz_spaces_update`,
`oz_spaces_delete`, `oz_spaces_view_privileges`, `oz_spaces_set_privileges`,
`oz_spaces_list_relationships`, `oz_spaces_add_relationships`, `oz_spaces_remove_relationships`,
- shares — `oz_shares_list`, `oz_shares_view`, `oz_shares_create`, `oz_shares_update`, `oz_shares_delete`,
- providers — `oz_providers_list`, `oz_providers_view`, `oz_providers_update`,
`oz_providers_delete`, `oz_providers_list_relationships`, `oz_providers_invite`,
- handle services — `oz_handle_services_list`, `oz_handle_services_view`,
`oz_handle_services_create`, `oz_handle_services_update`, `oz_handle_services_delete`,
`oz_handle_services_view_privileges`, `oz_handle_services_set_privileges`,
`oz_handle_services_list_relationships`, `oz_handle_services_add_relationships`,
`oz_handle_services_remove_relationships`, `oz_handles_list`, `oz_handles_view`,
`oz_handles_create`, `oz_handles_update`, `oz_handles_delete`, `oz_handles_view_privileges`,
`oz_handles_set_privileges`, `oz_handles_list_relationships`, `oz_handles_add_relationships`,
`oz_handles_remove_relationships`,
- harvesters — `oz_harvesters_list`, `oz_harvesters_view`, `oz_harvesters_create`,
`oz_harvesters_update`, `oz_harvesters_delete`, `oz_harvesters_view_privileges`,
`oz_harvesters_set_privileges`, `oz_harvesters_list_relationships`,
`oz_harvesters_add_relationships`, `oz_harvesters_remove_relationships`,
- Onezone cluster — `oz_clusters_list`, `oz_clusters_view`, `oz_clusters_update`,
`oz_clusters_view_privileges`, `oz_clusters_set_privileges`, `oz_clusters_list_relationships`,
`oz_clusters_add_relationships`, `oz_clusters_remove_relationships`.

A cluster administrator manages the Oneprovider cluster and its resources,
while a user with admin privileges has elevated permissions within the system.
It is possible for a single account to have both roles simultaneously.


<!-- references -->

[User Interface]: ../user-guide/user-interface.md

[Update User Admin Privileges]: https://onedata.org/#/home/api/stable/onezone?anchor=operation/update_user_admin_privileges