# Web file browser

[toc][]

The Web file browser is a graphical interface offering a broad spectrum of file
management features, including basic file operations (e.g. filesystem
navigation, file upload or download) and advanced capabilities, specific for
Onedata (e.g. Quality of Service, data distribution management,
datasets & archives management).

The file browser is always presented in the context of a single
[space](spaces.md). It becomes available when the space is
[supported](spaces.md#request-support-for-space) by at least one
[provider](providers.md) and can be invoked by navigating to the **DATA > _Space
name_ > Files** tab, or clicking the **FILES** tile in the space **Overview**.

![Location of file browser in the data tab](../../images/user-guide/web-file-browser/intro-data-overview.png#screenshot)

<!-- TODO: VFS-9382 update screenshot and mark FILES tile with rectangle -->

## Uploading data

A new, empty space welcomes you with the following screen:

![View of empty data space](../../images/user-guide/web-file-browser/uploading-empty.png#screenshot)


To upload new files, use the **upload** button or drag and drop them into the 
file browser area. While the data is being uploaded, a progress panel will appear
in the bottom-right corner of your screen. You can upload multiple files 
simultaneously or add more files while an upload is in progress.

![Uploading files to an empty directory](../../images/user-guide/web-file-browser/uploading-upload.png#screenshot)

After any upload is started, the **UPLOADS** tab will appear in the main menu
sidebar, providing detailed view of all uploads that have been done in the
current browser tab. View the information in a summarized form or per the target provider.

![Upload tab](../../images/user-guide/web-file-browser/uploading-tab.png#screenshot)


## File browser layout

The top section of the file browser accommodates a breadcrumb navigator and a
toolbox.

The breadcrumb navigator presents the path to the current working directory and
allows navigation to its parent directories. The current working directory is
the last element in the breadcrumbs and has a context menu with all available
actions for the directory (identical to the context menus on the file list,
described below).

The toolbox, located in the top right corner, contains shortcuts for common
directory actions (*upload files*, *create a new directory* and *refresh file list*).

![Directory breadcrumbs](../../images/user-guide/web-file-browser/layout-breadcrumbs.png#screenshot)

The remainder part of the file browser presents the content of the current working
directory in a form of a list with details.

::: tip NOTE
File list navigation is slightly different on mobile devices and is covered 
[later on](#mobile-file-browser).
:::

You can select or deselect files by left-clicking on them. Hold down `Ctrl` 
(or `Opt` on MacOS) while clicking to select or deselect multiple files. 
To select a range of files, hold down `Shift`.

A double click on an item opens a directory (sets it as a new current working
directory) or downloads a file.

When an item or multiple selected items are right-clicked, a context menu with
available actions appears.

![Context menu for selected files](../../images/user-guide/web-file-browser/layout-context-menu.png#screenshot)

The file browser uses the "infinite scroll" method to display large
directories — new items are dynamically loaded when the list is scrolled down.

![Dynamically loaded file list](../../images/user-guide/web-file-browser/layout-infinite-scroll.png#screenshot)

Apart from basic details displayed on the list, additional information and
characteristics of files is presented using tags. For instance, the tags include
information whether a file is shared, has Quality of Service requirements
attached or an Access Control List (ACL) assigned. 


![Example of additional information about files using tags](../../images/user-guide/web-file-browser/layout-file-tags.png#screenshot)

## File browser features

<!-- TODO: VFS-9383 documentation of features introduced in 21.02 -->

All file management operations offered by the file browser are available in the
context menu invoked with a right-click or using the three-dots button on
the left of each list entry.

::: tip
Some operations require appropriate [privileges](spaces.md#space-privileges) 
in the space and are disabled in the menu in case the user's privileges are not
sufficient.
:::

::: tip
It is possible to invoke the context-menu for more than one selected item, but
only some of the operations are available in this mode.
:::

![Context menu for single file](../../images/user-guide/web-file-browser/feature-file-context-menu.png#screenshot)

### Information

This action brings up a modal with information about a single file or directory.

![Information about file](../../images/user-guide/web-file-browser/feature-info.png#screenshot)

You can also excess the Information tab by hovering over icon of file or directory

### Download

This action simply downloads chosen single file or directory. You can also download single 
files by double-clicking on them.

### Share

Using the **Share** tab in the **Details** modal, you can make a file or
directory publicly accessible by anyone knowing the share link (no authentication or account in
Onedata is needed). If the item has not been shared yet, this action will open a
modal that allows creating a new [share](shares.md).

![Share directory modal](../../images/user-guide/web-file-browser/feature-share.png#screenshot)

If the item has already been shared, you will see the list of existing
shares, with the possibility to copy their public links, view their details
(using the green links) or create another share.

![Share directory modal](../../images/user-guide/web-file-browser/feature-shared-already.png#screenshot)

### Datasets

This action brings up **Datasets** modal, where you can assign a dataset status to
your file or directory. Datasets are files or directories that space users identify
as meaningful data collections to them. To read more about the functionality of the
Datasets head over to this 


### Metadata

This action allows browsing end editing custom file
[metadata](metadata.md#web-gui), divided into three classes: basic (key-value),
JSON and RDF. The last two feature a code editor with syntax checking and
highlighting.

![Share directory modal](../../images/user-guide/web-file-browser/feature-metadata-json.png#screenshot)


### Permissions

Invokes an editor of [permissions](data.md#permissions) assigned to the file —
[POSIX](data.md#posix-permissions) or [Access Control List
(ACL)](data.md#access-control-lists). 
You can assign only one permission type to each file at a time.
To select the currently applied permission type, use the **Permissions type** toggle.

Edit the POSIX permissions for each file by using the octal representation 
field or manipulating the checkboxes.

![POSIX permissions of file](../../images/user-guide/web-file-browser/feature-permissions-posix.png#screenshot)

Upon switching to the **ACL** type, a different editor is presented. It allows
creating and editing entries for different principals in the space and assigning
allowing/denying rules for granular operations concerning the file or directory.

![ACL of file](../../images/user-guide/web-file-browser/feature-permissions-acl.png#screenshot)


### Data distribution

This tab is used to monitor and manage the [distribution of file
data](data.md#file-distribution) among supporting providers. The green bars
visualize which blocks (fragments of the file) are stored on the storage systems
of the corresponding providers. When more than one file is selected, the
distribution can be viewed in a summarized or detailed manner.

![Data distribution charts](../../images/user-guide/web-file-browser/feature-distribution-bar.png#screenshot)

The handy status bar indicates ongoing [replication, migration and
eviction](replication-and-migration.md) jobs and allows scheduling new ones for
the corresponding provider. In the detailed view, there is also a shortcut to
the history of data transfers for the subject file (as shown in the screenshot
above).

![Data distribution actions](../../images/user-guide/web-file-browser/feature-distribution-schedule.png#screenshot)


### QoS

Brings up an editor of [Quality of Service](quality-of-service.md) (QoS)
requirements defined for the selected file(s), which are used to automatically 
manage the file data replication according to logical rules.

You can put down the rules using a visual block-based expression editor. 
Evaluate these rules against the QoS parameters assigned to different supporting
storages to determine where the replicas should be stored.

![QoS visual editor: block editing](../../images/user-guide/web-file-browser/feature-qos-visual.png#screenshot)

Below the requirement, there is information what storages match the requirement
and an action that copies the expression in textual form, to be reused when
creating a new requirement or using the [REST API](rest-api.md).

![QoS visual editor: storage match and expression](../../images/user-guide/web-file-browser/feature-qos-visual-match.png#screenshot)


Enter expressions in textual form. They will be converted to block form upon 
confirmation and can be further edited.

![QoS editor in text mode](../../images/user-guide/web-file-browser/feature-qos-text.png#screenshot)

If the selected files have any QoS requirements defined, they are displayed on
the list along with their status of fulfillment, matching storages and other
information. It is possible to remove selected QoS requirements, unless they
are inherited from any parent directory. 

![QoS requirements browser](../../images/user-guide/web-file-browser/feature-qos-requirements.png#screenshot)


### Run workflow

This action brings up modal containing list of all the uploaded workflows, that
you can choose to tun your file on. To read more about the functionality of the
workflows head over to 

![Share directory modal](../../images/user-guide/web-file-browser/feature-metadata-json.png#screenshot)


### Rename

Basic operation used to change the file name.

![Rename file modal](../../images/user-guide/web-file-browser/feature-rename.png#screenshot)


### Create symbolic link

This action lets you create a symbolic link to single file or directory nad place it in a chosen destination. 
Symbolic link also known as a symlink , is a file that acts as a reference or 
pointer to another file or directory. To place symbolic link in directory you are in,
click on the highlighted button in top right corner.

![Copy, cut and paste feature](../../images/user-guide/web-file-browser/feature-copy-cut.png#screenshot)


### Create hard link

As above this action lets you create a hard link to single file or directory nad place it in a chosen
destination. A hard link is a reference to a file that points directly to the
underlying data of that file on a file system. In simpler terms, a hard link is
an additional name or entry for an existing file. Multiple hard links can exist
for a single file, and they all refer to the same underlying data on the disk

To place a hardlink follow the same steps as you would with placing a symbolic link.
As you create hardlink, the original file or directory will now display label with
amount of hard links created to this file. You can click on the label you will 
see the list of existing hard links in **Details** modal. 


![Copy, cut and paste feature](../../images/user-guide/web-file-browser/feature-copy-cut.png#screenshot)


### Copy, Cut and Paste

The  **copy** or **cut** action from the context-menu can be used on one or
more selected items. Then, a **paste** action will appear in the toolbox, which
can be used to copy or move the files to the current working directory.

![Copy, cut and paste feature](../../images/user-guide/web-file-browser/feature-copy-cut.png#screenshot)


### Delete

This action permanently deletes the selected files and directories. 

![Rename file modal](../../images/user-guide/web-file-browser/feature-delete.png#screenshot)


## Mobile file browser

Onedata web file browser supports mobile devices such as smartphones or tablets.
Available features are the same as in desktop mode, but the page layout is
adjusted to small devices.

![Mobile web file browser - overview](../../images/user-guide/web-file-browser/mobile-overview.png#screenshot)

In the mobile mode, the navigation is adapted for touch screens. Instead of a
double click, a tap gesture is used to download a file or open a directory.

![Mobile web file browser - download](../../images/user-guide/web-file-browser/mobile-download.png#screenshot)

Selection is performed by pressing and holding on a file for about a second, and
then selecting further files is done by tapping on them. The context menu for a
file can be invoked using the three-dots menu in the file row or the
**Selection** button at the bottom of screen.

![Mobile web file browser - context menu](../../images/user-guide/web-file-browser/mobile-menu.png#screenshot)

Operations on the current working directory, such as creating new directory or
uploading files, are available in the breadcrumbs navigator. When an upload is
started, a progress bar appears at the bottom of the screen.

![Mobile web file browser - upload](../../images/user-guide/web-file-browser/mobile-upload.png#screenshot)


## Switching between providers

The file browser view is provided by one of the providers supporting the space.
The currently selected provider is shown on the top of file browser in the
**View provided by...** bar. Although the provider is chosen automatically, it
is possible to manually select a different one using the **Choose other
Oneprovider...** action at the top of file browser, given that there is more
than one supporting provider. Alternatively, you can switch providers by using a 
world map visual representation, available under the globe icon.

![Switch supporting provider view](../../images/user-guide/web-file-browser/oneprovider-switch.png#screenshot)

::: tip
After switching to another provider, the user will eventually see the same
content, but new changes might appear with different delay. Providers
continuously synchronize the data changes within spaces, and depending on the
system usage intensity, they can take from a couple of seconds to even hours to
propagate. To see the changes immediately, it is recommended to choose the
Oneprovider on which the user is making them (modifying file content,
creating new files or directories, scheduling data transfers etc).
:::
