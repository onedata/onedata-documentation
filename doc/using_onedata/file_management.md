
# File Management


## Data Sharing
You can share your files with other users, in a Dropbox-like manner, using links.
You can also see all the files you are sharing in that way by navigating to Shared Files view, which is accessible under the Data tab in the top menu.

### Sharing a file with a link
To share a file using a link:

1. Navigate to **Provider** page.
2. Navigate to **Data** page, by click on **data link** on the left menubar.
3. Click on the **file** you wish to share. It should lit up signaling it is selected.
4. Click on the **Share** icon, which is a 3rd icon from the left.
5. Copy the generated link and share it with email or chat.

### Stop sharing a file
You can disable the link to the file you previously shared:

1. Navigate to **Provider** page.
2. Navigate to **Data** page, by click on **data link** on the left menubar.
3. Click on **Links Files**.
4. On the list of files you share find the file you wish to stop sharing.
5. Click on the **"X" sign** next to it.

## File Permissions
You can control access to your data with a combination of:
* classical (POSIX) file permissions  
* access control lists

### POSIX Permissions
Onedata allows you to control access to your data in a POSIX fashion for users, group and others in terms of read, write and executable permissions.
In order to edit permissions:

1. Navigate to **Provider** page.
2. Navigate to **Data** page, by click on **data link** on the left menubar.
2. Select a **file** or a **directory** by clicking on it.
3. Click on the **lock icon**.
4. Edit permissions by clicking on the appropriate **checkbox**.
5. Click **OK** in order to save changes.

You can also edit POSIX permissions by entering them in octal form.
In case of directories you can select a recursive option, to apply permissions to the whole subtree.

<img  style="display:block;margin:0 auto;" src="../img/permissions.png">


### Access Control Lists
You can also setup permissions using more advanced access control lists to control permissions for individual users and groups.
In order to edit permissions:

1. Navigate to **Data** tab.
2. Select a **file** or a **directory** by clicking on it.
3. Click on the **lock icon**.
4. Click on the **ACL's radio button**
5. Edit permissions by clicking on the appropriate **checkbox**.
5. Click **OK** in order to save changes.

*Note, that access lists take precedence over POSIX permissions. If access list is set, POSIX are set to octal value of `000`.*

The order in which permissions take precedence is indicated with an arrow.

In case of directories you can select a recursive option, to apply permissions to the whole subtree.

<img  style="display:block;margin:0 auto;" src="../img/acls.png">
