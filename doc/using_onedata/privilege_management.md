# Onedata privileges

<!-- toc -->

Onedata implements an extensive privilege management system, which enables fine grained control over all security aspects related to data access and sharing.

The privileges in Onedata can be divided into the following categories:
- Space privileges
- Group privileges
- Handle privileges
- Onezone privileges

Most of these privileges can be either managed using the Graphical User Interface in web browser (see [space management](./space_management.md), [group management](group_management.md) and [file management](file_management.md)), as well as using REST API.


## REST API privilege management
Onedata REST API provides comprehensive means for managing permissions for users, spaces, groups and Onezone service. Please note that all these operations require ID's of users, spaces and groups respectively - not names.

### Space privileges

Space privileges can be assigned either to individual users as well as groups of users.

The following space privileges are available:


| Privilege             | Description                              |
| --------------------- | ---------------------------------------- |
| space_delete          | Allow removing of this space             |
| space_invite_group    | Allow inviting other groups to this space |
| space_invite_provider | Allow adding new storage providers to this space |
| space_invite_user     | Allow inviting other users to this space |
| space_manage_shares   | Allow management of shares related to this space |
| space_remove_group    | Allow removing groups from this space    |
| space_remove_provider | Allow removing storage providers supporting this space |
| space_remove_user     | Allow removing users from space          |
| space_set_privileges  | Allow changing privileges for this space |
| space_update          | Allow modifying space content            |
| space_view            | Allow browsing space content             |
| space_write_data      | Allow write access to space              |


These privileges can be changed using the REST API, depending on whether they are assigned to an invdividual user or a group of users. Below are some examples:
* List user 'ABC123' permissions to space 'QWE789':
```bash
curl -X GET -H "X-Auth-Token: $ACCESS_TOKEN" \
https://$ONEZONE_HOST/api/v3/onezone/spaces/QWE789/users/ABC123/privileges
```
which should return something similar to:
```bash
{"privileges": ["space_view", "space_modify","space_delete"]}
```
* Limit user 'ABC123' to only browse contents of space 'QWE789':
```bash
curl -X PUT -H "X-Auth-Token: $ACCESS_TOKEN" \
-d '{"privileges": ["space_view"]}' -H 'Content-type: application/json' \
https://$ONEZONE_HOST/api/v3/onezone/spaces/QWE789/users/ABC123/privileges
```
* Allow group 'IOP567' to change privileges of space 'QWE789':
```bash
curl -X PUT -H "X-Auth-Token: $ACCESS_TOKEN" \
-d '{"privileges": ["space_set_privileges"]}' \
https://$ONEZONE_HOST/api/v3/onezone/spaces/QWE789/groups/IOP567/privileges
```

Please note that modifying space privileges requires providing complete set of privileges. For instance in the last example if the group IOP567 already has other privileges than `space_set_privileges` they will be removed and only `space_set_privileges` will be valid.

### Group privileges
In order to understand group privilege management functionality, it is necessary to first understand 2 concepts related to group functionality in Onedata.

> **Child groups**
> Child groups (or subgroups) allow creation of arbitrary hierarchies of groups of users. Each group can have mutliple parents and siblings.

> **Effective users**
> Since users to each group or space can be either assigned directly, or indirectly via groups and their subgroups, effective user set contains all users either directly or indirectly assigned to a specific space or group.

The following privileges can be assigned to groups:

Below are presented examples of using the API for group privilege management.


| Privilege            | Description                              |
| -------------------- | ---------------------------------------- |
| group_create_space   | Allow group user to create spaces        |
| group_delete         | Allow group user to remove the group     |
| group_invite_group   | Allow group user to invite other groups to join this group |
| group_invite_user    | Allow inviting other users to the group  |
| group_join_group     | Allow group user to join this group with other groups |
| group_join_space     | Allow group to join other spaces         |
| group_leave_space    | Allow group user to remove the group from a specific space |
| group_remove_group   | Allow group user to remove groups which have joined this group |
| group_remove_user    | Allow removing users from the group      |
| group_set_privileges | Allow group user to change group privileges |
| group_update         | Allow modifying group information        |
| group_view           | Allow group user to view group data      |


Example group privilege REST API calls are presented below:
* List group 'IOP567' permissions to space 'QWE789':
```bash
curl -X GET -H "X-Auth-Token: $ACCESS_TOKEN" \
https://$ONEZONE_HOST/api/v3/onezone/spaces/QWE789/groups/IOP567/privileges
```

* List subgroup 'GDP678' permissions in group 'IOP567':
```bash
curl -X GET -H "X-Auth-Token: $ACCESS_TOKEN" \
https://$ONEZONE_HOST/api/v3/onezone/groups/IOP567/children/GDP678/privileges
```

* List user 'ABC123' permissions in group 'IOP567':
```bash
curl -X GET -H "X-Auth-Token: $ACCESS_TOKEN" \
https://$ONEZONE_HOST/api/v3/onezone/groups/IOP567/users/ABC123/privileges
```

* List effective user 'ABC123' permissions in group 'IOP567':
```bash
curl -X GET -H "X-Auth-Token: $ACCESS_TOKEN" \
https://$ONEZONE_HOST/api/v3/onezone/groups/IOP567/effective_users/ABC123/privileges
```


### Handle service privileges
These privileges control access rights to Handle services registered within
a Onezone.

| Privilege                      | Description                              |
| ------------------------------ | ---------------------------------------- |
| handle_service_delete          | Remove a handle service                  |
| handle_service_list_handles    | List handles registered by a handle service |
| handle_service_register_handle | Register a new handle using a handle service |
| handle_service_update          | Modify a handle service                  |
| handle_service_view            | View handle service details              |


### Handle privileges
These privileges control access to specific handles (DOI's, PID's) assigned
to specific shares and registered using a specific Handle Service.

| Privilege     | Description                       |
| ------------- | --------------------------------- |
| handle_delete | Remove specific handle            |
| handle_update | Change specific handle attributes |
| handle_view   | View specific handle details      |


### Onezone privileges
Finally, in order to gain access to specific parts of the Onezone service itself, it is possible to assign certain permissions to users as well as groups, although these permissions typically should be limited to administrators for monitoring and accounting services.

| Privilege                 | Description                              |
| ------------------------- | ---------------------------------------- |
| oz_groups_add_members     | Add any user to any group                |
| oz_groups_list_groups     | List subgroups of any group              |
| oz_groups_list_users      | List users of any group                  |
| oz_groups_list            | List all groups in the Onezone instance and get their details |
| oz_groups_remove_members  | Remove any user from any group           |
| oz_handle_services_create | Create hande service                     |
| oz_handle_services_list   | List all handle services                 |
| oz_handles_list           | List all handles                         |
| oz_providers_delete       | Remove any Oneprovider registered in this Onezone |
| oz_providers_list_groups  | List groups of a specific provider       |
| oz_providers_list_spaces  | List spaces supported by a specific provider |
| oz_providers_list_users   | List users of a specific provider        |
| oz_providers_list         | Allow the user to list all providers registered in the zone |
| oz_set_privileges         | Allow the user to modify the privileges  |
| oz_shares_list            | List all shares                          |
| oz_spaces_add_members     | Allows to add any user or group to any space (typically for zone administrators) |
| oz_spaces_list_groups     | List all groups belonging to any space   |
| oz_spaces_list_providers  | Allow the user to see all providers supporting specific space |
| oz_spaces_list_users      | List all users of any space              |
| oz_spaces_list            | List all spaces in the Onezone instance and get their details |
| oz_spaces_remove_members  | Allows to remove any user or group from any space (typically for zone administrators) |
| oz_users_delete           | Remove any user                          |
| oz_users_list             | List all users in the Onezone instance and get their details |
| oz_view_privileges        | Allow the user to view privileges        |



Each of these privileges can be assigned to an individual user or a group of users. Example operations are presented below:

* List user 'ABC123' permissions to Onezone service:
```bash
curl -X GET -H "X-Auth-Token: $ACCESS_TOKEN" \
https://$ONEZONE_HOST/api/v3/onezone/users/ABC123/privileges
```

* List group 'IOP567' permissions to Onezone service:
```bash
curl -X GET -H "X-Auth-Token: $ACCESS_TOKEN" \
https://$ONEZONE_HOST/api/v3/onezone/groups/IOP567/privileges
```
