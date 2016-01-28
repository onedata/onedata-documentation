# Group Management

You can create or join existing groups to easier manage and collaborate on your spaces. A group is an abstract entity with a name and at least one user assigned to it, who has sufficient permission to manage it. You can manage your groups from a Manage groups page, accessible with Group button on the top menu.

## Create your group
In order to create your group:

1. In the Onedata Web Interface click **Groups** button located on the top menu.
2. On the **Manage groups** page, click **Create new group** button.
3. On the bottom of the screen set the name of the new group and click **OK** button.

New group will appear on the list of groups designated with a unique ID.

> acl na poziomei spaca i na poziomje plków
>jesli wymaga to wpodzailania wiecej niz 1 usera to trzaskamy rysunek

## Invite another user to your group
To invite another user to join your group:

1. Navigate to **Manage groups** page.
2. On your group, click the **Actions** button.
3. Pick **Invite User** from the drop down menu.
4. Copy the token and send it to the user you wish to invite to your group.

After another user joins your group you will be able to see him in the detailed group view.

## Join existing group
To join a group, you must request from them the token. After receiving the token:

1. Navigate to **Manage groups** page.
2. Click the **Join existing group** button.

You should be able to see a group on the Manage groups page immediately.

## Group properties
On the **Manage grops** page, you can see a detailed information about a group by clicking on it.
<img  style="display:block;margin:0 auto;" src="img/group_management_group1_details.png">

All information regarding you group is presented here, including:
- a list of members of this group and their permissions
- a list of spaces that this group has joined

### Group permissions

You can control actions and the level of access to your space by setting dedicated permissions or a group. In order to edit permissions:

1. Navigate to **Grpup managment** page.
2. Click on our **grpup**, to show space detailed view.
3. To set a permission click on the **empty box**.
4. To unset a permission click on the **box with a tick**.
5. To save or discard changes use **Save** or **Discard** buttons.

<img style="display:block;margin:0 auto;" src="img/group_permissions.png">



| Permission Name | Description                                                                    |
|:----------------|:-------------------------------------------------------------------------------|
| View Space      | Group can see  files and folders in your space.                                |
| Modify Space    | Group can modify files and folders in your space.                              |
| Remove Space    | Group can delete your space.                                                   |
| Invite user     | Group can invite new users to your space.                                      |
| Remove user     | Group can remove  users from your space.                                       |
| Invite group    | Group can invite new groups to your space.                                     |
| Remove group    | Group can remove  groups from your space.                                      |
| Invite provider | Group can request a support from the provider.                                 |
| Remove provider | Group can remove provider form the list of providers that supports your space. |
| Set privileges  | Group can modify this privileges.                                              |




### Perform actions on your group
One the **Manage groups** page, each listed group has a **Action**, which allows you to:

| Action Name            | Description                                           |
|:-----------------------|:------------------------------------------------------|
| Move up                | Move this group up on the list of your groups.        |
| Move down              | Move this group down on the list of your groups.      |
| Leave group            | Remove this group from the list of your groups.       |
| Rename                 | Rename this group.                                    |
| Remove                 | Remove this group and leave all spaces it has joined. |
| Invite user            | Add a user to this group.                             |
| Create space           | Create a space and allow this group to control it.    |
| Join space             | Join existing space                                   |
| Request space creation | Create a space for this group                         |


### Remove your group
In order to remove your group:
1. Navigate to **Manage groups** page.
2. On your group, click the *Actions* button.
3. Pick **Remove** from the drop down menu.
4. Click **Yes**, acknowledging that you want to remove this group.
