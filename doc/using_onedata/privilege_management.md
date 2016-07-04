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
curl -X GET -H "macaroon: $(ACCESS_TOKEN)" \
https://$(ONEPROVIDER_HOST):8443/api/v3/onezone/spaces/QWE789/users/ABC123
```
which should return something similar to:
```bash
["space_view_data", "space_change_data","space_remove"]
```
* Limit user 'ABC123' to only browse contents of space 'QWE789':
```bash
curl -X PUT -H "macaroon: $(ACCESS_TOKEN)" \
-d '["space_view_data"]' \
https://$(ONEPROVIDER_HOST):8443/api/v3/onezone/spaces/QWE789/users/ABC123
```
* Allow group 'IOP567' to change privileges of space 'QWE789':
```bash
curl -X PUT -H "macaroon: $(ACCESS_TOKEN)" \
-d '["space_set_privileges"]' \
https://$(ONEPROVIDER_HOST):8443/api/v3/onezone/spaces/QWE789/groups/IOP567
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
| group_change_data | |
| group_invite_user | |
| group_remove_user | |
| group_join_space | |
| group_create_space | |
| group_set_privileges | |
| group_remove | |
| group_leave_space | |
| group_view_data | |
| group_create_space_token | |
| group_join_group | |
| group_invite_group | |
| group_remove_group | |


### Onezone privileges

Finally, in order to gain access to specific parts of the Onezone service itself, it is possible to assign certain permissions to users as well as groups, although these permissions typically should be limited to administrators.


