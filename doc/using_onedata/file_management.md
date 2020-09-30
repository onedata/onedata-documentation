
# File Management

<!-- toc -->

<!--
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
-->

## Managing files

### Web interface
All files in Onedata are organized in spaces. The Web User interface allows for uploading new files as well as opening existing files.

In order to upload a file simply open the directory in which the file should be placed and drag the file into the browser window:

<img  style="display:block;margin:0 auto;" src="../img/draganddrop.png">

Opening or downloading a file simply requires double clicking on the file in the file window. 

*Make sure that the popups for this browser window are not blocked, and unblock them if necessary.*

### Direct access via POSIX
Files can also be accessed directly via POSIX protocol, using **Oneclient** tool. Details on how to use are described [here](./oneclient.md).

### CDMI (Cloud Data Management Interface)
For more advanced use cases, files can be managed using [CDMI](http://www.snia.org/cdmi) protocol, as described in details [here](../advanced/cdmi.md).

## File Permissions
You can control access to your data with a combination of:
* classical (POSIX) file permissions  
* access control lists

### POSIX Permissions
<!-- This header is referenced at least one time as "#posix-permissions" -->

Onedata allows you to control access to your data in a POSIX-like fashion for users, group and others in terms of read,
write and executable permissions. 

An important nuance regarding file permissions is that all space members are treated as a virtual group which is the
group owner of all files in the space.  
That means that whenever a file is accessed by a space member who is not the owner of the file, the group permissions are
taken into consideration.
Permissions for "others" are considered when accessing [shares](../using_onedata/shares.md).

Consider the following example of file's POSIX permissions:

    rwx r-- ---
     |   |   |
     |   |   guests
     |   |
     |   space members
     |
     owner user
     
In the above case, the creator of the file (its owner user) has a full access to the file.
All space members have read access to the file. Users (guests) who try to access the file through a share
will fail to do so as all permissions are declined for "others". 

In order to edit permissions:

1. Navigate to **Oneprovider** page
2. Navigate to data management page, by click on **Data** on the left menubar
2. Select a **file** or a **directory** by clicking on it
3. Click on the **lock icon**
4. Select **POSIX** type of permissions radio button at the top
5. Enter privileges in octal form (e.g. 770)
5. Click **OK** in order to save changes

<img  style="display:block;margin:0 auto;" src="../img/permissions.png">


### Access Control Lists
<!-- This header is referenced at least one time as "#access-control-lists" -->

You can also setup permissions using more advanced Access Control Lists option to control permissions for individual users and groups.

In order to edit ACL's:

1. Navigate to **Data** tab
2. Select a **file** or a **directory** by clicking on it
3. Click on the **lock icon**
4. Click on the **ACL** radio button
5. Edit permissions by clicking on the appropriate **checkbox**
5. Click **OK** in order to save changes

*Note, that access lists take precedence over POSIX permissions. If access list is set, POSIX are set to octal value of `000`.*

The order in which permissions take precedence is indicated with an arrow.

<img  style="display:block;margin:0 auto;" src="../img/acls.png">
