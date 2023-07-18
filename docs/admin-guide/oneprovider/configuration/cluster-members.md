# Cluster members

Access to the view and settings of the Oneprovider cluster (administration
panel) is controlled through the members mechanism. It consists of a list of
users and groups to which specific cluster management privileges are assigned.
Users who are not direct members or do not belong to member groups do not have
access to the cluster.

::: tip
An exception is access to the administration panel through the emergency
interface. In this case, access to cluster resources is granted by providing a
special emergency password. Read more
[here](../administration-panel.md#access-via-emergency-interface).
:::

You can find the members settings by entering the *Members* submenu of a
specific cluster.

![image](../../../../images/admin-guide/oneprovider/configuration/cluster-members/cluster-members.png#screenshot)

## Adding new members

To grant access to the cluster to new users, you have two options — inviting
users directly or adding an entire user group.

### Inviting users

To add a new user to the cluster, use the *Invite user using token* option from
the user list menu.

![image](../../../../images/admin-guide/oneprovider/configuration/cluster-members/adding-cluster-user-options.png#screenshot)

Then, copy the generated token and send it to the user you want to grant access
to the cluster.

![image](../../../../images/admin-guide/oneprovider/configuration/cluster-members/cluster-user-invite-token.png#screenshot)

Once the user receives the token, they should consume it using the dedicated
[view](../../../user-guide/tokens.md#consuming-invite-tokens).


### Adding user groups

To add an entire user group to the cluster, use one of the options in the group
list menu.

![image](../../../../images/admin-guide/oneprovider/configuration/cluster-members/adding-cluster-group-options.png#screenshot)

These options allow you to:

1. Create a new empty user group. To grant access to users, you will need to
   invite them to the newly created group.
2. Add an existing group from those you have access to.
3. Invite a group using a token. This mechanism is similar to [inviting
   users](#inviting-users), with the difference that you need to pass the token
   to the administrator of the invited group.

::: warning
Adding a user group means that users in subgroups of that group will
also gain access to the cluster. Therefore, try to invite only groups that
consist solely of users who are genuinely authorized to manage the cluster or
create a new group and invite selected users to it. This will provide better
control over access and privileges.
:::


## Reviewing existing members

Cluster members can be viewed in two modes — direct and effective. The *direct*
view shows only those members who have been directly added to the cluster —
either through token invitation or group membership. The *effective* view, on
the other hand, shows all members who actually have access to the cluster. It
differs from the set of direct members by including additional groups and users
who are members of direct groups.

![image](../../../../images/admin-guide/oneprovider/configuration/cluster-members/effective-cluster-members.png#screenshot)

By expanding each entry in the members list, you can view their privileges. In
the direct view, only privileges granted during the member addition process are
displayed (and editable), while in the effective view, calculated privileges
resulting from the privileges of intermediate groups are shown (read-only).

![image](../../../../images/admin-guide/oneprovider/configuration/cluster-members/cluster-member-perms.png#screenshot)

Furthermore, by changing the view aspect to *Memberships*, you can also see how
a particular member is in a membership relation with the cluster. This helps in
finding information about through which group a user became a member of the
cluster.

![image](../../../../images/admin-guide/oneprovider/configuration/cluster-members/cluster-member-membership.png#screenshot)

## Removing members

To remove a cluster member, use the option *Remove this member* in the menu
corresponding to that member.

::: tip
It is not possible to remove a member who is only an effective member of
the cluster. To revoke their access, you need to remove the group to which they
belong. You can find help in identifying that group through the
[membership information](#reviewing-existing-members).
:::

## Changing member privileges

::: tip
To change privileges, you need to use the
[*direct* members view](#reviewing-existing-members).
:::

To change privileges, expand the entry corresponding to the specific user or
group, toggle the desired privileges, and save the changes by clicking the
*Save* button.

![image](../../../../images/admin-guide/oneprovider/configuration/cluster-members/modifies-cluster-member-perms.png#screenshot)

Remember that changing privileges for a group means changing them for all users
within that group.

Full list of privileges:

| Privilege name  | REST API representation   | Description                                             |
| --------------- | ------------------------- | ------------------------------------------------------- |
| View cluster    | `cluster_view`            | User can see cluster and enter its administration panel |
| Modify cluster  | `cluster_update`          | User can adjust cluster settings                        |
| Remove cluster  | `cluster_delete`          | User can remove cluster from Onezone                    |
| View privileges | `cluster_view_privileges` | User can view members' privileges                       |
| Set privileges  | `cluster_set_privileges`  | User can modify members' privileges                     |
| Add user        | `cluster_add_user`        | User can invite new users to the cluster                |
| Remove user     | `cluster_remove_user`     | User can remove users from the cluster                  |
| Add group       | `cluster_add_group`       | User can add new groups to the cluster                  |
| Remove group    | `cluster_remove_group`    | User can remove groups from the cluster                 |

## Managing members from the emergency administration interface

If, for some reason, you don't have access to the administration interface
through Onezone but have the emergency passphrase for the cluster, you can
partially configure members from the emergency administration interface. To do
this, go to the emergency interface (read more
[here](../administration-panel.md#access-via-emergency-interface)) and navigate
to the *Members* submenu.

![image](../../../../images/admin-guide/oneprovider/configuration/cluster-members/cluster-members-in-emergency.png#screenshot)

Here, you can see the current number of members and generate an inviting token
to the cluster (by clicking *Invite user using a token*). When consumed by a
user, this token grants full privileges set to the cluster. It serves as a way
to regain administrative access to the cluster in case of accidental loss.

::: warning
Be cautious in sharing the token generated from the emergency
administration interface. It grants full management privileges to the cluster,
and if it falls into the wrong hands, it can lead to malicious configuration
changes and data loss.
:::

## REST API

All operations related to the cluster members can be performed using the Onezone
REST API. Refer to the linked API documentation for detailed information and
examples.

| Request                                   | Link to API                                                                                                   |
| ----------------------------------------- | ------------------------------------------------------------------------------------------------------------- |
| List cluster's users                      | [API](https://onedata.org/#/home/api/latest/onezone?anchor=operation/list_cluster_users)                      |
| Add user to cluster                       | [API](https://onedata.org/#/home/api/latest/onezone?anchor=operation/add_cluster_user)                        |
| Remove user from cluster                  | [API](https://onedata.org/#/home/api/latest/onezone?anchor=operation/remove_cluster_user)                     |
| List user's cluster privileges            | [API](https://onedata.org/#/home/api/latest/onezone?anchor=operation/list_user_cluster_privileges)            |
| Update user's cluster privileges          | [API](https://onedata.org/#/home/api/latest/onezone?anchor=operation/update_user_cluster_privileges)          |
| List cluster's effective users            | [API](https://onedata.org/#/home/api/latest/onezone?anchor=operation/list_cluster_effective_users)            |
| List effective user's cluster privileges  | [API](https://onedata.org/#/home/api/latest/onezone?anchor=operation/list_effective_user_cluster_privileges)  |
| List cluster's groups                     | [API](https://onedata.org/#/home/api/latest/onezone?anchor=operation/list_cluster_groups)                     |
| Add group to cluster                      | [API](https://onedata.org/#/home/api/latest/onezone?anchor=operation/add_group_to_cluster)                    |
| Remove group from cluster                 | [API](https://onedata.org/#/home/api/latest/onezone?anchor=operation/remove_cluster_group)                    |
| List group's cluster privileges           | [API](https://onedata.org/#/home/api/latest/onezone?anchor=operation/list_group_cluster_privileges)           |
| Update group's cluster privileges         | [API](https://onedata.org/#/home/api/latest/onezone?anchor=operation/update_group_cluster_privileges)         |
| List cluster's effective groups           | [API](https://onedata.org/#/home/api/latest/onezone?anchor=operation/list_cluster_effective_groups)           |
| List effective group's cluster privileges | [API](https://onedata.org/#/home/api/latest/onezone?anchor=operation/list_effective_group_cluster_privileges) |
