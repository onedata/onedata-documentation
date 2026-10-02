# Administrative privileges

Onedata has no separate administrator accounts. Everyone uses the same
[User Web interface][], and administrative capabilities come from privileges
assigned to individual users. A user can hold some of them, all of them, or none,
and the GUI shows what their privileges allow. There are two kinds:

* [Onezone admin privileges][], which give a user extended control over the
  resources of the whole Onedata ecosystem (described below).
* **Cluster privileges**, which a user has through membership in a [Onezone][Oz cluster]
  or [Oneprovider][Op cluster] cluster and which let them manage that service.

One user can have **both kinds at the same time**.

## Onezone admin privileges

Onezone admin privileges let users perform additional operations in both the GUI and the
REST API. These operations are for managing the resources of Onezone, such as users,
groups, spaces, etc. (see the full list below). Admin privileges can be modified only via
the REST API, see the [Update User Admin Privileges][] operation. The full list of
privileges is available through the [List privileges][] operation.

Users with admin privileges can access extra features and management options that
are not available to regular users. Admin privileges override regular
privileges. For example, suppose a user belongs to a group but has no privilege
there to modify privileges. If that user has the `oz_groups_set_privileges` admin
privilege, they can still modify privileges in that group and in others.

Admin privileges give access to management operations for all types of resources, which
include:

* privileges,
* users,
* groups,
* spaces,
* shares,
* providers,
* handles,
* handle services,
* harvesters,
* clusters,
* automation inventories.

## The default `admin` user

Every Onezone deployment comes with one special user account. Its username is `admin` and
its password is initially identical to the [emergency passphrase][] (and can be changed
independently). This user is a member of the Onezone cluster with all cluster privileges,
so it can fully manage the service, and it also holds all Onezone admin privileges. It can
therefore be considered the superadmin of the Onedata ecosystem.

In principle, though, it is a user account like any other, with privileges
assigned to it. You can grant the same privileges to a user from your Identity
Provider and then delete the `admin` user, and the system will behave in the same
way.

<!-- references -->

[Onezone admin privileges]: #onezone-admin-privileges

[User Web interface]: ../user-guide/user-web-interface.md

[Oz Cluster]: onezone/administration-panel.md#managing-access-to-the-administration-panel

[Op Cluster]: oneprovider/administration-panel.md#managing-access-to-the-administration-panel

[Update User Admin Privileges]: https://onedata.org/api/stable/onezone?anchor=operation/update_user_admin_privileges

[List privileges]: https://onedata.org/api/stable/onezone/operation/list_privileges/

[emergency passphrase]: oneprovider/administration-panel.md#emergency-passphrase
