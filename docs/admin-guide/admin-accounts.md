# Admin accounts

Admin accounts interact with the same unified user interface as regular users.
For details about the interface, see [User Interface][].

## Admin privileges

Admin privileges grant users the ability to perform additional operations in both the GUI and REST API.
These privileges can be modified only via the REST API. For instructions, refer to
the [Update User Admin Privileges][] operation.

Users with admin privileges can access extra features and management options not available
to regular users. Admin privileges override regular user privileges.
Example: user belongs to group, but in that group he does not have privilege to modify privileges,
but has the corresponding admin privilege: `oz_groups_set_privileges` and
because of that he can modify privileges in that group and others.

Admin privileges provide access to management operations for the following types of resources:

* privileges,
* users,
* groups,
* spaces,
* shares,
* providers,
* handle services,
* harvesters,
* Onezone cluster.

A cluster administrator manages the Oneprovider cluster and its resources,
while a user with admin privileges has elevated permissions within the system.
It is possible for a single account to have both roles simultaneously.

<!-- references -->

[User Interface]: ../user-guide/user-interface.md

[Update User Admin Privileges]: https://onedata.org/#/home/api/stable/onezone?anchor=operation/update_user_admin_privileges
