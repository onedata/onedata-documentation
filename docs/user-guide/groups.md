# Groups

[toc][1]

A group is an abstract entity with a name and at least one user assigned to it,
who has sufficient permissions to manage it. Groups help you to manage users' access and privileges
to your resources like spaces. You can create or join existing groups
to easily manage and collaborate using your data. If you are an owner of the group
(or have privileges) you can see a list of members and their privileges.

## Group members

A group is accessible only to its members. Members of the group are two kinds,
there are users and groups. In the group must exist at least one user, but it does not require any group. Creating groups from users and groups may help you to manage privileges
to other resources of the system. Each user or group can be assigned different privileges in the group.

## Group privileges

You can manage the privileges of members of a group. Privileges that directly appeal
to group management are view, modify and remove group, also view and set privileges.
Also, there are privileges, which relate to group hierarchy management, like
adding/removing a child group or adding/leaving a parent group.

## Direct and effective memberships

You can belong to a group directly by consuming a token invitation, or you can belong
to a group, that belongs to that group, which is effective membership, because you
get access by inheriting it, not directly. If you belong to space not direct,
your privileges result from the group's privileges, to which you belong.
That means no one can modify your privileges directly.

## GUI guide

Below is a section showing how to create a group and perform basic operations in that group.

### Create or join a new group

Navigate to the **GROUPS** tab and click the `(+)` action button to create your group.
You may also join an existing group using the **Consume** action in the [Tokens GUI][],
in case you received an invite token from another user.
![screen-create-group][]

### Group management

Navigate to the **GROUPS** tab and choose your group, next click on the menu button, to choose some option.
There are a few options, which you can perform on the group: rename, leave, remove.
Also, you can copy the group's id, which is helpful for performing some [REST API][] requests.
![screen-group-menu][]

### Invite a user

Navigate to the **Members** submenu. Here, you can manage the users and
groups that belong to the group. To invite a new user, you would click on the
token generation action, copy the acquired token and pass it to another user.
![screen-invite-user][]

### Invite a group

Navigate to the **Members** submenu. To invite an existing group, to which you belong,
you would click on the menu and choose **Add one of your groups** actions.
If you want to invite a group to which you do not belong, choose from the menu **Invite group using token**
and pass that token to another user.
![screen-invite-group][]

### Create a subgroup

Navigate to the **Members** submenu. To create a new group that already belongs to
one of your groups, click the menu and choose the option **Create new group**. Then in the modal
enter the name of a new group and confirm click **Create** button.
![screen-create-subgroup][]

### Modify group privileges

To view and modify members' privileges of some groups, go to the **Groups** tab,
choose some groups from the menu, and go to the **Members** submenu. Expand one of your members
and grant or revoke privileges. Remember to save your privileges modification click on the **Save** button,
that appears when changes exist.
![screen-modify-privileges][]

To modify more than one member at the same time, choose members and click on **Bulk edit**
and grant or revoke privileges in appeared modal.
![screen-bulk-edit][]

### Hierarchy view

Go to your group in the **GROUP** tab and choose **Hierarchy** from the submenu.
This is a powerful view that helps you explore the hierarchy and relation between
your group and your children and parents groups.
This view helps you view and manage the structure inside your group and also
shows to which groups your group belongs. You can manage here not only relations between
groups like removing or adding but also modifying groups.
![screen-hierarchy][]

<!-- references -->

[1]: <>

[Tokens GUI]: tokens.md#consuming-invite-tokens

[REST API]: ./rest-api.md

[screen-create-group]: ../../images/user-guide/groups/create-group.png

[screen-group-menu]: ../../images/user-guide/groups/group-menu.png

[screen-invite-user]: ../../images/user-guide/groups/invite-user.png

[screen-invite-group]: ../../images/user-guide/groups/invite-group.png

[screen-create-subgroup]: ../../images/user-guide/groups/create-subgroup.png

[screen-modify-privileges]: ../../images/user-guide/groups/modify-privileges.png

[screen-bulk-edit]: ../../images/user-guide/groups/bulk-edit.png

[screen-hierarchy]: ../../images/user-guide/groups/hierarchy.png
