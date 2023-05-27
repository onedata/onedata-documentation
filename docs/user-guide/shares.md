# Shares

[toc][]

Files in Onedata can be made public and available for unauthenticated users. The simplest
way to achieve that is to create a **share** of a chosen file or directory (the whole
space can be shared as well), which is essentially a public link pointing to the dataset.

## Sharing a file or directory

To create a share, simply open the context menu for a file or directory and select
the **Share** action.

![Share action for a directory](../../images/user-guide/shares/sharing-file-menu.png#screenshot)

You will see a modal in which you can enter a share name that will be visible to other
users. Click on **Create** button to proceed with share creation.

![Directory share modal](../../images/user-guide/shares/sharing-file-modal.png#screenshot)

::: tip NOTE
The share root directory serves as the starting point for shared items and
contains all the files and folders that are nested in the directory. However, it's worth
mentioning that nested items within the share root directory do not have individual shares
associated with them, even though they are effectively shared.
:::

After successful share creation, a directory details panel with the **Shares** tab will
appear containing a list of shares created for a selected file or directory.

![Shares panel](../../images/user-guide/shares/sharing-shares-panel.png#screenshot)

::: tip NOTE
A single file or directory can be shared multiple times, each with a different
name and unique URL, which helps to manage access to files across many users, for example,
if you want to withdraw a link shared with a specific group, create a specific description,
etc. Creating multiple shares can be performed using **Create another share** button in
the shares tab of the file information panel.
:::

Clicking on a green link with a share name opens [a share management view](#share-management-view)
as an authenticated user, while the public share URL can be copied and passed to others to
provide anonymous, read-only access to the files.

### Public share access

Accessing the public share URL opens a public share view which by default contains a
**Files** tab with a file browser listing a single shared item (a file or a directory).

![Public share view](../../images/user-guide/shares/sharing-public-files.png#screenshot)

Users can normally browse these files in a read-only manner and you can additionally
restrict access to some files inside the share changing permissions of files in the file
browser:

* changing POSIX **Other** _(anonymous)_ **Read** and **Execute** flag,
* or setting ACL permissions for a special **ANONYMOUS** user class.

See [this](./data.md#data-access-control) chapter for more details.

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

![Public share file information](../../images/user-guide/shares/share-public-file-info.png#screenshot)

The file details panel also provides an **API** tab that provides _curl_ commands for
retrieving information about files by unauthenticated users.

![Public share file API](../../images/user-guide/shares/share-public-file-api.png#screenshot)

## Managing shares

You can list your shares per file, per space, or show shares across all spaces accessible
by you.

### Listing per file

A single file or directory can be shared multiple times - each with a different URL.
If there are some shares available for the file, you can simply access the **Shares** tab
of file information simply by clicking on the **Shared** file badge in the space file
browser.

![File Shared badge](../../images/user-guide/shares/managing-file-badge.png#screenshot)

::: tip NOTE
On mobile devices, you can access the file shares list by opening the file
information panel and choosing the **Shares** tab.
:::

The **Share** tab name includes a number with the shares count per file. Clicking on the share
name link opens [a single share management view](#share-management-view) while clicking
on the **Create another share** button will bring [a share creation modal](#sharing-a-file-or-directory).

![Managing shares of file](../../images/user-guide/shares/managing-file-shares.png#screenshot)

### Listing per space

Open a **Space** > **Shares, Open Data** tab, which lists all shares created in the space.
Clicking on a share item on the right pane will open [a single share management view](#share-management-view),
while dots-menu for the provides share operations: **Rename**, **Remove share**, and
**Copy public URL**.

![Managing shares of space](../../images/user-guide/shares/managing-space-shares.png#screenshot)

### Listing all shares in all spaces accessible by you

Open a **SHARES** item in the main menu, which lists all shares from all spaces accessible by
you. Click on a share item to open [a single share management view](#share-management-view).

![Managing shares of space](../../images/user-guide/shares/managing-all-shares.png#screenshot)

## Share management view

This single share management view contains:

* a **Path** to the shared file or directory in the space,
* a **Public share link** to access the share by anonymous users,
* a **Description** tab that allows creating information page describing the share,
* a **Files** tab that allows you to browse files as seen as an anonymous user,
* a **Publish as Open Data** tab, which allows publishing the dataset as Open Data.

![Share management view](../../images/user-guide/shares/share-root-view.png#screenshot)

The share can be also renamed or removed using the three-dots menu in the upper-right corner
of the view.

![Share menu](../../images/user-guide/shares/share-menu.png#screenshot)

### Share description

You can add an optional description of the share using Markdown format. After opening the
**Description** tab, click on **Create description** and write the description using
Markdown markup. You can use **Open preview** / **Edit markdown** buttons to switch
between Markdown markup and rendered description at any time and use **Save** or
**Discard** buttons to persist or cancel changes. The description can be edited at any
time after saving and share publishing.

![Share description editor](../../images/user-guide/shares/share-description-markdown.png#screenshot)

The description will be publicly available to users that can access the share URL.

![Share public description](../../images/user-guide/shares/share-public-description.png#screenshot)

::: tip NOTE
Writing a share description is recommended as it helps users understand
what the dataset is about, what information it contains, and how it can be used. With a
description, other users can quickly assess whether the dataset is suitable for their
needs.
:::

### Files view

The **Files** tab provides a preview of [the public share view file
browser](#public-share-access), showcasing what an anonymous user will see when accessing
it. This browser has limited functionality, allowing only read-only operations that
anonymous users can perform. To access the browser with all features available for
authenticated users, utilize the directory links found in the **Path** section of the
share management view.

![Share Files tab](../../images/user-guide/shares/share-files.png#screenshot)

<!-- ### Open Data -->

<!-- TODO: VFS-10906 Open Data documentation -->

### REST share information

Besides of public share URL accessible in the web browser, you can show and copy a _curl_
command giving information about sharing for the CLI, selecting the **Public REST endpoint**
option from the URL dropdown.

![Share curl command](../../images/user-guide/shares/share-curl.png#screenshot)

```shell
curl https://dev-onezone.default.svc.cluster.local/api/v3/onezone/shares/b2c3bcd7ff9dc063e4226581175f21fbchc6a8/public
```

```json
{
  "shareId": "b2c3bcd7ff9dc063e4226581175f21fbchc6a8",
  "rootFileId": "00000000007ED1B4736861726547756964233731666232643538646166323835616664623339303265663331653131646538636864626137236133613138616463346137376464316236313039363862326138353735633431636830643762236232633362636437666639646330363365343232363538313137356632316662636863366138",
  "publicUrl": "https://dev-onezone.default.svc.cluster.local/share/b2c3bcd7ff9dc063e4226581175f21fbchc6a8",
  "publicRestUrl": "https://dev-onezone.default.svc.cluster.local/api/v3/onezone/shares/b2c3bcd7ff9dc063e4226581175f21fbchc6a8/public",
  "name": "My files for John",
  "handleId": null,
  "fileType": "dir",
  "description": "",
  "creationTime": 1685193979
}
```
