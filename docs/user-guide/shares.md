# Shares

[toc][1]

Files in Onedata can be shared i.e. made available for unauthenticated users in
**read-only mode**. It's achieved using **shares** — **semi-public links** that
can be passed to desired recipients. Anyone on the Internet with a share link
can read the data, but the link is impossible to guess (hence the semi-public
nature of shares). Shares may have an optional description in Markdown format
to improve their comprehension and usability for the target audience.

Both directories and files can be shared, and multiple shares may be created
for the same file/directory. It is possible to share a whole [Space][].

## Sharing a file or directory

To create a share, navigate to the [file browser][], open the context
menu for a file or directory, and choose **Share / Publish**.

![screen-sharing-file-menu][]

You will see a modal in which you can enter a share name that will be visible to other
users. Click on the **Create** button to proceed with the share creation.

![screen-sharing-file-modal][]

::: tip NOTE
The share root directory serves as the starting point for shared items and
contains all the files and folders that are nested in the directory. However, it's worth
mentioning that nested items within the share root directory do not have individual shares
associated with them, even though they are effectively shared.
:::

After the successful share creation, a right-side details panel with the **Shares** tab
will appear containing a list of shares created for a selected file or directory.

![screen-sharing-shares-panel][]

::: tip NOTE
A single file or directory can be shared multiple times, each with a different name and
unique URL, which helps to manage access to files across many users, for example, if you
want to withdraw a link shared with a specific group, create a specific description, etc.
Creating multiple shares can be performed using the **Create another share** button in the
shares tab of the file information panel.
:::

<!-- TODO: VFS-12541 show details link and screenshots, everywhere -->

An authenticated user can access a [share management view][] by clicking on the
**Show details** link beside a share name, whereas the share URL can be copied and
shared with others to grant anonymous, read-only access to the files.

### Anonymous share access

Accessing the share URL opens an anonymous share view which by default contains a
**Files** tab with a file browser listing a single shared item (a file or a directory).

![screen-sharing-anonymous-files][]

By default, anonymous users can simply browse these files in a read-only manner, and also:

* download files,
* see files information like **File ID**, modification time and size,
* read files [metadata extended attributes][] that can be
  set by authenticated users.

<!-- @TODO VFS-11766 missing information about different types of metadata -->

![screen-share-anonymous-file-info][]

Access to specific files can be restricted inside the share by modifying the following
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

![screen-share-anonymous-file-api][]

## Managing shares

You can list your shares per file, per space, or show shares across all spaces accessible
by you.

### Listing per file

A single file or directory can be shared multiple times — each with a different URL. If
there are some shares available for the file, you can simply access the **Shares** tab by
clicking on the **Shared** badge in the file browser.

![screen-managing-file-badge][]

::: tip MOBILE DEVICES NOTE
As the file badges are not clickable on mobile devices, you can access the shares list by
choosing **Information** from the file actions menu and opening the **Shares** tab in the
right-side panel.
:::

The **Share** tab name includes a number with the shares count per file. Clicking on the **Show details**
link beside a share name opens a [share management view][], while clicking
on the **"Create another share"** button will bring a [share creation modal][].

![screen-managing-file-shares][]

### Listing per space

To list all shares created in the space, navigate to the **Data > *Space name* > Shares, Public Data** view.
Clicking on a share row in the main view will open a [share management view][],
while the actions menu for the share provides the following operations: **Rename**, **Remove share**, and
**Copy share URL**.

![screen-managing-space-shares][]

### Listing all shares in all your spaces

To list all shares from all your spaces, open a **Shares** tab from the navigation bar,
which will show the list in the shares sidebar. Click on a share item to open a [share management view][].

![screen-managing-all-shares][]

## Share management view

The single share management view enables you to view shared data and the share information
as well as configure it. The view consists of:

* a **Path** to the shared file or directory in the space,
* a **Share link** to access the share by anonymous users,
* a **Description** tab that allows creating an information page describing the share,
* a **Files** tab that allows you to browse files as seen as an anonymous user,
* an **Expose as Public Data** tab, which allows [exposing the data collection as Public Data][].

![screen-share-root-view][]

The share can be also renamed or removed using the actions menu in the upper-right corner
of the view.

![screen-share-menu][]

### Share Description

You can add an optional description of the share using Markdown format. After opening the
**Description** tab, click on the **Create description** button and write the description using
Markdown markup. You can use the **"Open preview"** and **"Edit markdown"** buttons to switch
between Markdown markup and rendered description and use **Save** or
**Discard** buttons to persist or cancel changes. The description can be edited at any
time after it is saved and published — applied changes will be immediately visible to the share users.

![screen-description-markdown][]

The description will be visible to unauthenticated users that know the share URL.

![screen-share-anonymous-description][]

::: tip NOTE
Writing a share description is recommended as it helps users understand
what the data collection is about, what information it contains, and how it can be used. With a
description, other users can quickly assess whether the collection is suitable for their
needs.
:::

### Files view

The **Files** tab provides a preview of the [anonymous share view][],
showcasing what an anonymous user will see when accessing it. This browser has limited
functionality, allowing read-only operations that anonymous users can perform. To access
the browser with all features available for authenticated users, open the parent directory
link found in the **Path** section of the share management view.

![screen-share-files][]

### REST share information

Besides a share link accessible in the web browser, you can show and copy a curl
command giving information about sharing for the CLI, selecting the **Share REST endpoint**
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
  "name": "My shared files",
  "description": "# Description\nIn markdown format",
  "rootFileId": "00000000007ED1B4736861726547756964233731666232643538646166323835616664623339303265663331653131646538636864626137236133613138616463346137376464316236313039363862326138353735633431636830643762236232633362636437666639646330363365343232363538313137356632316662636863366138",
  "publicUrl": "https://dev-onezone.default.svc.cluster.local/share/b2c3bcd7ff9dc063e4226581175f21fbchc6a8",
  "publicRestUrl": "https://dev-onezone.default.svc.cluster.local/api/v3/onezone/shares/b2c3bcd7ff9dc063e4226581175f21fbchc6a8/public",
  "handleId": null,
  "fileType": "dir",
  "creationTime": 1685193979
}
```

::: tip
For full share API reference, see the [share][share-API] chapter of the Onedata REST API
documentation.
:::

<!-- references -->

[1]: <>

[Space]: spaces.md

[file browser]: ./interfaces/web-file-browser.md

[share management view]: #share-management-view

[metadata extended attributes]: ./metadata.md#extended-attributes

[permissions]: ./data.md#data-access-control

[web-file-browser-permissions]: ./interfaces/web-file-browser.md#permissions

[share creation modal]: #sharing-a-file-or-directory

[exposing the data collection as Public Data]: ./public-data.md

[anonymous share view]: #anonymous-share-access

[share-API]: https://onedata.org/#/home/api/stable/onezone?anchor=tag/Share

[screen-sharing-file-menu]: ../../images/user-guide/shares/sharing-file-menu.png

[screen-sharing-file-modal]: ../../images/user-guide/shares/sharing-file-modal.png

[screen-sharing-shares-panel]: ../../images/user-guide/shares/sharing-shares-panel.png

[screen-sharing-anonymous-files]: ../../images/user-guide/shares/sharing-anonymous-files.png

[screen-share-anonymous-file-info]: ../../images/user-guide/shares/share-anonymous-file-info.png

[screen-share-anonymous-file-api]: ../../images/user-guide/shares/share-anonymous-file-api.png

[screen-managing-file-badge]: ../../images/user-guide/shares/managing-file-badge.png

[screen-managing-file-shares]: ../../images/user-guide/shares/managing-file-shares.png

[screen-managing-space-shares]: ../../images/user-guide/shares/managing-space-shares.png

[screen-managing-all-shares]: ../../images/user-guide/shares/managing-all-shares.png

[screen-share-root-view]: ../../images/user-guide/shares/share-root-view.png

[screen-share-menu]: ../../images/user-guide/shares/share-menu.png

[screen-description-markdown]: ../../images/user-guide/shares/share-description-markdown.png

[screen-share-anonymous-description]: ../../images/user-guide/shares/share-anonymous-description.png

[screen-share-files]: ../../images/user-guide/shares/share-files.png

[screen-share-curl]: ../../images/user-guide/shares/share-curl.png
