# Shares

[toc][1]

Files in Onedata can be made public and available for unauthenticated users. The simplest
way to achieve that is to create a **Share** of a chosen file or directory (the whole
space can be shared as well), which is essentially a public link pointing to the dataset.

## Sharing a file or directory

To create a Share, navigate to the [file browser][], open the context
menu for a file or directory, and choose **Share**.

![screen-sharing-file-menu][]

You will see a modal in which you can enter a Share name that will be visible to other
users. Click on the **Create** button to proceed with the Share creation.

![screen-sharing-file-modal][]

::: tip NOTE
The Share root directory serves as the starting point for shared items and
contains all the files and folders that are nested in the directory. However, it's worth
mentioning that nested items within the Share root directory do not have individual Shares
associated with them, even though they are effectively shared.
:::

After the successful Share creation, a right-side details panel with the **Shares** tab
will appear containing a list of Shares created for a selected file or directory.

![screen-sharing-shares-panel][]

::: tip NOTE
A single file or directory can be shared multiple times, each with a different
name and unique URL, which helps to manage access to files across many users, for example,
if you want to withdraw a link shared with a specific group, create a specific description,
etc. Creating multiple Shares can be performed using the **Create another share** button in
the Shares tab of the file information panel.
:::

An authenticated user can access a [Share management view][] by
clicking on a green link with a Share name, whereas the public Share URL can be copied and
shared with others to grant anonymous, read-only access to the files.

### Public Share access

Accessing the public Share URL opens a public Share view which by default contains a
**Files** tab with a file browser listing a single shared item (a file or a directory).

![screen-sharing-public-files][]

By default, anonymous users can simply browse these files in a read-only manner, and also:

* download files,
* see files information like **File ID**, modification time and size,
* read files [metadata extended attributes][] that can be
  set by authenticated users.

![screen-share-public-file-info][]

Access to specific files can be restricted inside the Share by modifying the following
[permissions][] of files in the file browser:

* changing POSIX **Other** *(anonymous)* **Read** and **Execute** flag,
* or setting ACL permissions for a special **ANONYMOUS** user class.

You can do it by navigating to the **Data > *Space name* > Files** view and choosing
**Permissions** from the context menu for the file or directory to which you want to
restrict access. For more information about the web file browser permissions view, refer
to [this page][web-file-browser-permissions].

::: tip NOTE
Although there is a POSIX **Other — Write** flag and modification permissions
available for the **ANONYMOUS** special ACL user, these don't affect the ability to write
files by anonymous users — shared files are always read-only for anonymous users.
:::

The file details panel also provides an **API** tab that provides *curl* commands for
retrieving information about files by unauthenticated users.

![screen-share-public-file-api][]

## Managing Shares

You can list your Shares per file, per space, or show Shares across all spaces accessible
by you.

### Listing per file

A single file or directory can be shared multiple times — each with a different URL. If
there are some Shares available for the file, you can simply access the **Shares** tab by
clicking on the **Shared** badge in the file browser.

![screen-managing-file-badge][]

::: tip MOBILE DEVICES NOTE
As the file badges are not clickable on mobile devices, you can access the Shares list by
choosing **Information** from the file actions menu and opening the **Shares** tab in the
right-side panel.
:::

The **Share** tab name includes a number with the shares count per file. Clicking on the green Share
name link opens a [Share management view][] while clicking
on the **"Create another share"** button will bring a [Share creation modal][].

![screen-managing-file-shares][]

### Listing per space

To list all shares created in the space, navigate to the **Data > *Space name* > Shares, Open Data** view.
Clicking on a Share row in the main view will open a [Share management view][],
while the actions menu for the Share provides the following operations: **Rename**, **Remove share**, and
**Copy public URL**.

![screen-managing-space-shares][]

### Listing all shares in all your spaces

To list all shares from all your spaces, open a **Shares** tab from the navigation bar,
which will show the list in the Shares sidebar. Click on a Share item to open [a single
Share management view][Share management view].

![screen-managing-all-shares][]

## Share management view

The single Share management view enables you to view shared data and the Share information
as well as configure it. The view consists of:

* a **Path** to the shared file or directory in the space,
* a **Public share link** to access the Share by anonymous users,
* a **Description** tab that allows creating an information page describing the Share,
* a **Files** tab that allows you to browse files as seen as an anonymous user,
* a **Publish as Open Data** tab, which allows [publishing the dataset as Open Data](./open-data.md).

![screen-share-root-view][]

The Share can be also renamed or removed using the actions menu in the upper-right corner
of the view.

![screen-share-menu][]

### Share Description

You can add an optional description of the Share using Markdown format. After opening the
**Description** tab, click on the **Create description** button and write the description using
Markdown markup. You can use the **"Open preview"** and **"Edit markdown"** buttons to switch
between Markdown markup and rendered description and use **Save** or
**Discard** buttons to persist or cancel changes. The description can be edited at any
time after it is saved and published — applied changes will be immediately visible to the Share users.

![screen-description-markdown][]

The description will be publicly available to users that can access the Share URL.

![screen-share-public-description][]

::: tip NOTE
Writing a Share description is recommended as it helps users understand
what the dataset is about, what information it contains, and how it can be used. With a
description, other users can quickly assess whether the dataset is suitable for their
needs.
:::

### Files view

The **Files** tab provides a preview of the [public Share view file browser][],
showcasing what an anonymous user will see when accessing it. This browser has limited
functionality, allowing read-only operations that anonymous users can perform. To access
the browser with all features available for authenticated users, open the parent directory
link found in the **Path** section of the Share management view.

![screen-share-files][]

<!-- ### Open Data -->

### REST Share information

Besides a public Share link accessible in the web browser, you can show and copy a curl
command giving information about sharing for the CLI, selecting the **Public REST endpoint**
option from the URL dropdown.

![screen-share-curl][]

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

::: tip
For full Shares API reference, see the [Share][share-API] chapter of the Onedata REST API
documentation.
:::

<!-- references -->

[1]: <>

[file browser]: web-file-browser.md

[Share management view]: #share-management-view

[metadata extended attributes]: ./metadata.md#extended-attributes

[permissions]: ./data.md#data-access-control

[web-file-browser-permissions]: ./web-file-browser.md#permissions

[Share creation modal]: #sharing-a-file-or-directory

[public Share view file browser]: #public-share-access

[share-API]: https://onedata.org/#/home/api/stable/onezone?anchor=tag/Share

[screen-sharing-file-menu]: ../../images/user-guide/shares/sharing-file-menu.png

[screen-sharing-file-modal]: ../../images/user-guide/shares/sharing-file-modal.png

[screen-sharing-shares-panel]: ../../images/user-guide/shares/sharing-shares-panel.png

[screen-sharing-public-files]: ../../images/user-guide/shares/sharing-public-files.png

[screen-share-public-file-info]: ../../images/user-guide/shares/share-public-file-info.png

[screen-share-public-file-api]: ../../images/user-guide/shares/share-public-file-api.png

[screen-managing-file-badge]: ../../images/user-guide/shares/managing-file-badge.png

[screen-managing-file-shares]: ../../images/user-guide/shares/managing-file-shares.png

[screen-managing-space-shares]: ../../images/user-guide/shares/managing-space-shares.png

[screen-managing-all-shares]: ../../images/user-guide/shares/managing-all-shares.png

[screen-share-root-view]: ../../images/user-guide/shares/share-root-view.png

[screen-share-menu]: ../../images/user-guide/shares/share-menu.png

[screen-description-markdown]: ../../images/user-guide/shares/share-description-markdown.png

[screen-share-public-description]: ../../images/user-guide/shares/share-public-description.png

[screen-share-files]: ../../images/user-guide/shares/share-files.png

[screen-share-curl]: ../../images/user-guide/shares/share-curl.png
