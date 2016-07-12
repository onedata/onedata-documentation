# Onedata privileges

Onedata implements an extensive privilege management system, which enables fine grained control over all security aspects related to data access and sharing.

The privileges in Onedata can be divided into the following categories:
- Space privileges
- Group privileges
- File privileges
- Onezone privileges

Most of these privileges can be either managed using the Graphical User Interface in web browser (see [space management](./space_management.md), [group management](group_management.md) and [file management](file_management.md)), as well as using REST API.


## REST API privilege management
Onedata REST API provides comprehensive means for managing permissions for users, spaces, groups and Onezone service. Please note that all these operations require ID's of users, spaces and groups respectively - not names.

### Space privileges

Space privileges can be assigned either to individual users as well as groups of users. 

The following space privileges are available:

| Privilege    | Description     |
|--------------|-----------------|
| space_invite_user     | Allow inviting other users to this space |
| space_remove_user     | Allow removing users from space |
| space_invite_group    | Allow inviting other groups to this space |
| space_remove_group    | Allow removing groups from this space |
| space_set_privileges  | Allow changing privileges for this space |
| space_remove          | Allow removing of this space |
| space_add_provider    | Allow adding new storage providers to this space |
| space_remove_provider | Allow removing storage providers supporting this space |
| space_change_data     | Allow modifying space content |
| space_view_data       | Allow browsing space content |

These privileges can be changed using the REST API, depending on whether they are assigned to an invdividual user or a group of users. Below are some examples:
* List user 'ABC123' permissions to space 'QWE789':
```bash
curl -X GET -H "macaroon: $ACCESS_TOKEN" \
https://$ONEZONE_HOST:8443/api/v3/onezone/spaces/QWE789/users/ABC123/privileges
```
which should return something similar to:
```bash
["space_view_data", "space_change_data","space_remove"]
```
* Limit user 'ABC123' to only browse contents of space 'QWE789':
```bash
curl -X PUT -H "macaroon: $ACCESS_TOKEN" \
-d '["space_view_data"]' \
https://$ONEZONE_HOST:8443/api/v3/onezone/spaces/QWE789/users/ABC123/privileges
```
* Allow group 'IOP567' to change privileges of space 'QWE789':
```bash
curl -X PUT -H "macaroon: $ACCESS_TOKEN" \
-d '["space_set_privileges"]' \
https://$ONEZONE_HOST:8443/api/v3/onezone/spaces/QWE789/groups/IOP567/privileges
```

Please note that modifying space privileges requires providing complete set of privileges. For instance in the last example if the group IOP567 already has other privileges than `space_set_privileges` they will be removed and only `space_set_privileges` will be valid.

### Group privileges
In order to understand group privilege management functionality, it is necessary to first understand 2 concepts related to group functionality in Onedata.

> **Nested groups**
> Nest groups (or subgroups) allow creation of arbitrary hierarchies of groups of users. Each group can have mutliple parents and siblings.

> **Effective users**
>Since users to each group or space can be either assigned directly, or indirectly via groups and their subgroups, effective user set contains all users either directly or indirectly assigned to a specific space or group. 

The following privileges can be assigned to groups:

Below are presented examples of using the API for group privilege management. Reference of these operations is available [here]().

| Privilege    | Description     |
|--------------|-----------------|
| group_change_data | Allow modifying group information |
| group_invite_user | Allow inviting other users to the group |
| group_remove_user | Allow removing users from the group |
| group_join_space | Allow group to join other spaces |
| group_create_space | Allow group user to create spaces |
| group_set_privileges | Allow group user to change group privileges |
| group_remove | Allow group user to remove the group |
| group_leave_space | Allow group user to remove the group from a specific space |
| group_view_data | Allow group user to view group data |
| group_create_space_token | Allow group user to create space support tokens |
| group_join_group | Allow group user to join this group with other groups |
| group_invite_group | Allow group user to invite other groups to join this group |
| group_remove_group | Allow group user to remove groups which have joined this group |

Example group privilege REST API calls are presented below:
* List group 'IOP567' permissions to space 'QWE789':
```bash
curl -X GET -H "macaroon: $ACCESS_TOKEN" \
https://$ONEZONE_HOST:8443/api/v3/onezone/spaces/QWE789/groups/IOP567/privileges
```

* List subgroup 'GDP678' permissions in group 'IOP567':
```bash
curl -X GET -H "macaroon: $ACCESS_TOKEN" \
https://$ONEZONE_HOST:8443/api/v3/onezone/groups/IOP567/nested/GDP678/privileges
```

* List user 'ABC123' permissions in group 'IOP567':
```bash
curl -X GET -H "macaroon: $ACCESS_TOKEN" \
https://$ONEZONE_HOST:8443/api/v3/onezone/groups/IOP567/users/ABC123/privileges
```

* List effective user 'ABC123' permissions in group 'IOP567':
```bash
curl -X GET -H "macaroon: $ACCESS_TOKEN" \
https://$ONEZONE_HOST:8443/api/v3/onezone/groups/IOP567/effective_users/ABC123/privileges
```


### Onezone privileges

Finally, in order to gain access to specific parts of the Onezone service itself, it is possible to assign certain permissions to users as well as groups, although these permissions typically should be limited to administrators for monitoring and accounting services.

| Privilege    | Description     |
|--------------|-----------------|
| view_privileges | Allow the user to view privileges |
| set_privileges | Allow the user to modify the privileges |
| list_spaces | Allow the user to list all spaces in the zone |
| list_providers | Allow the user to list all providers registered in the zone |
| list_providers_of_space | Allow the user to see all providers supporting specific space|

Each of these privileges can be assigned to an individual user or a group of users. Example operations are presented below:

* List user 'ABC123' permissions to Onezone service:
```bash
curl -X GET -H "macaroon: $ACCESS_TOKEN" \
https://$ONEZONE_HOST:8443/api/v3/onezone/privileges/users/ABC123
```

* List group 'IOP567' permissions to Onezone service:
```bash
curl -X GET -H "macaroon: $ACCESS_TOKEN" \
https://$ONEZONE_HOST:8443/api/v3/onezone/privileges/groups/IOP567
```


