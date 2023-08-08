# Shares

[toc]()

Files in Onedata can be made public and available for unauthenticated users. The simplest
way to achieve that is to create a **Share** of a chosen file or directory (the whole
space can be shared as well), which is essentially a public link pointing to the dataset.

## Sharing a file or directory

To create a Share, navigate to the [file browser](web-file-browser.md), open the context
menu for a file or directory, and choose **Share**.

![Share action for a directory](../../images/user-guide/shares/sharing-file-menu.png#screenshot)

You will see a modal in which you can enter a Share name that will be visible to other
users. Click on the **Create** button to proceed with the Share creation.

![Directory Share modal](../../images/user-guide/shares/sharing-file-modal.png#screenshot)

::: tip NOTE
The Share root directory serves as the starting point for shared items and
contains all the files and folders that are nested in the directory. However, it's worth
mentioning that nested items within the Share root directory do not have individual Shares
associated with them, even though they are effectively shared.
:::

After the successful Share creation, a directory details panel with the **Shares** tab
will appear containing a list of Shares created for a selected file or directory.

![Shares panel](../../images/user-guide/shares/sharing-shares-panel.png#screenshot)

::: tip NOTE
A single file or directory can be shared multiple times, each with a different
name and unique URL, which helps to manage access to files across many users, for example,
if you want to withdraw a link shared with a specific group, create a specific description,
etc. Creating multiple Shares can be performed using the **Create another share** button in
the Shares tab of the file information panel.
:::

Clicking on a green link with a Share name opens [a Share management view](#share-management-view)
as an authenticated user, while the public Share URL can be copied and passed to others to
provide anonymous, read-only access to the files.

### Public Share access

Accessing the public Share URL opens a public Share view which by default contains a
**Files** tab with a file browser listing a single shared item (a file or a directory).

![Public Share view](../../images/user-guide/shares/sharing-public-files.png#screenshot)

Users can simply browse these files, in a read-only manner. Access to specific files can be also restricted inside the Share by modifying the following [permissions](./data.md#data-access-control) of files in the
file browser:

* changing POSIX **Other** *(anonymous)* **Read** and **Execute** flag,
* or setting ACL permissions for a special **ANONYMOUS** user class.

You can do it by navigating to the **Data > *Space name* > Files** view and choosing **Permissions** from the context menu for the file or directory to which you want to restrict access. For more information about the web file browser permissions view, refer to [this page](./web-file-browser.md#permissions).

::: tip NOTE
Although there is a POSIX **Other — Write** flag and modification permissions
available for the **ANONYMOUS** special ACL user, these don't affect the ability to write
files by anonymous users — shared files are always read-only for anonymous users.
:::

Besides file browsing, an anonymous user can:

* download files,
* see files information like **File ID**, modification time and size,
* read files [metadata extended attributes](./metadata.md#extended-attributes) that can be
  set by authenticated users.

![Public Share file information](../../images/user-guide/shares/share-public-file-info.png#screenshot)

The file details panel also provides an **API** tab that provides *curl* commands for
retrieving information about files by unauthenticated users.

![Public Share file API](../../images/user-guide/shares/share-public-file-api.png#screenshot)

## Managing Shares

You can list your Shares per file, per space, or show Shares across all spaces accessible
by you.

### Listing per file

A single file or directory can be shared multiple times — each with a different URL.
If there are some Shares available for the file, you can simply access the **Shares** tab
of file information by clicking on the **Shared** file badge in the space file
browser.

![File "Shared" badge](../../images/user-guide/shares/managing-file-badge.png#screenshot)

::: tip NOTE
On mobile devices, you can access the file Shares list by choosing **Information** from the
file actions menu, and choosing the **Shares** tab in the right-side information panel.
:::

The **Share** tab name includes a number with the shares count per file. Clicking on the green Share
name link opens [a single Share management view](#share-management-view) while clicking
on the **"Create another share"** button will bring [a Share creation modal](#sharing-a-file-or-directory).

![File Shares management](../../images/user-guide/shares/managing-file-shares.png#screenshot)

### Listing per space

To list all shares created in the space, navigate to the **Data > *Space name* > Shares, Open Data** view.
Clicking on a Share item in the main view will open [a single Share management view](#share-management-view),
while the actions menu for the Share provides the following operations: **Rename**, **Remove share**, and
**Copy public URL**.

![Space shares management](../../images/user-guide/shares/managing-space-shares.png#screenshot)

### Listing all shares in all your spaces

To list all shares from all your spaces, open a **Shares** tab from the navigation bar,
which will show the list in the Shares sidebar. Click on a Share item to open [a single
Share management view](#share-management-view).

![All Shares management](../../images/user-guide/shares/managing-all-shares.png#screenshot)

## Share management view

The single Share management view enables you to view shared data and the Share information
as well as configure it. The view consists of:

* a **Path** to the shared file or directory in the space,
* a **Public share link** to access the Share by anonymous users,
* a **Description** tab that allows creating an information page describing the Share,
* a **Files** tab that allows you to browse files as seen as an anonymous user,
* a **Publish as Open Data** tab, which allows publishing the dataset as Open Data.

![The Share root browser](../../images/user-guide/shares/share-root-view.png#screenshot)

The Share can be also renamed or removed using the actions menu in the upper-right corner
of the view.

![Share actions](../../images/user-guide/shares/share-menu.png#screenshot)

### Share Description

You can add an optional description of the Share using Markdown format. After opening the
**Description** tab, click on the **Create description** button and write the description using
Markdown markup. You can use the **"Open preview"** and **"Edit markdown"** buttons to switch
between Markdown markup and rendered description and use **Save** or
**Discard** buttons to persist or cancel changes. The description can be edited at any
time after it is saved and published — applied changes will be immediately visible to the Share users.

![Share description editor](../../images/user-guide/shares/share-description-markdown.png#screenshot)

The description will be publicly available to users that can access the Share URL.

![Share public description](../../images/user-guide/shares/share-public-description.png#screenshot)

::: tip NOTE
Writing a Share description is recommended as it helps users understand
what the dataset is about, what information it contains, and how it can be used. With a
description, other users can quickly assess whether the dataset is suitable for their
needs.
:::

### Files view

The **Files** tab provides a preview of [the public Share view file browser](#public-share-access),
showcasing what an anonymous user will see when accessing it. This browser has limited
functionality, allowing only read-only operations that anonymous users can perform. To
access the browser with all features available for authenticated users, utilize the
directory links found in the **Path** section of the Share management view.

![Share Files tab](../../images/user-guide/shares/share-files.png#screenshot)

<!-- ### Open Data -->

<!-- TODO: VFS-10906 Open Data documentation -->

### REST Share information

Besides a public Share link accessible in the web browser, you can show and copy a curl
command giving information about sharing for the CLI, selecting the **Public REST endpoint**
option from the URL dropdown.

![Share curl command](../../images/user-guide/shares/share-curl.png#screenshot)

For example, the following command:

```shell
curl https://dev-onezone.default.svc.cluster.local/api/v3/onezone/shares/b2c3bcd7ff9dc063e4226581175f21fbchc6a8/public
```

would result in the following JSON response:

```json
{
  "shareId": "b2c3bcd7ff9dc063e4226581175f21fbchc6a8",
  "rootFileId": "00000000007ED1B4736861726547756964233731666232643538646166323835616664623339303265663331653131646538636864626137236133613138616463346137376464316236313039363862326138353735633431636830643762236232633362636437666639646330363365343232363538313137356632316662636863366138",
  "publicUrl": "https://dev-onezone.default.svc.cluster.local/share/b2c3bcd7ff9dc063e4226581175f21fbchc6a8",
  "publicRestUrl": "https://dev-onezone.default.svc.cluster.local/api/v3/onezone/shares/b2c3bcd7ff9dc063e4226581175f21fbchc6a8/public",
  "name": "My public files",
  "handleId": null,
  "fileType": "dir",
  "description": "",
  "creationTime": 1685193979
}
```
