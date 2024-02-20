# Web file browser

[toc][]

The Web file browser is a graphical interface offering a broad spectrum of file
management features, including basic file operations (e.g. filesystem
navigation, file upload or download) and advanced capabilities, specific to Onedata 
(e.g. Quality of Service, data distribution, datasets & archives).

The file browser is always presented in the context of a single [space][]. It becomes
available when the space is [supported][space-support] by at least one [provider][] and
can be invoked by navigating to the **DATA > *Space name* > Files** tab, or clicking the
**FILES** tile in the space **Overview**.

![screen-intro-data-overview][]

## Uploading data

An empty space will welcome you with the following screen:

![screen-uploading-empty][]

To upload new files, use the **upload** button or drag and drop them into the
file browser area. While the data is being uploaded, a progress panel will appear
in the bottom-right corner of your screen. You can upload multiple files
simultaneously or add more files while an upload is in progress.

![screen-uploading-upload][]

After any upload is started, the **UPLOADS** tab will appear in the main menu
sidebar, providing a detailed view of all uploads that have been done in the
current browser tab. View the information in a summarized form or per the target provider.

![screen-uploading-tab][]

## File browser layout

The top section of the file browser accommodates a breadcrumb navigator and a
toolbox.

The breadcrumb navigator presents the path to the current working directory and
allows navigation to its parent directories. The current working directory is
the last element in the breadcrumbs and has a context menu with all available
actions for the directory (identical to the context menus on the file list,
described below).

The toolbox, located in the top right corner, contains shortcuts for common
directory actions (*upload files*, *create a new directory*, and *refresh the file list*).

![screen-layout-breadcrumbs][]

The remainder part of the file browser presents the content of the current working
directory as a list with details.

::: tip NOTE
File list navigation is slightly different on mobile devices and is covered
[later on][mobile-file-browser].
:::

You can select or deselect files by left-clicking on them. Hold down `Ctrl` 
(or `Opt` on macOS) while clicking to select or deselect multiple files. 
To select a range of files, hold down `Shift`.

A double click on an item opens a directory (sets it as a new current working
directory) or downloads a file.

When an item or multiple selected items are right-clicked, a context menu with
available actions appears.

![screen-layout-context-menu][]

You can customize the file browser layout by specifying what columns (file attributes) are
displayed. Click the **Configure columns** button, in the upper-right corner of the file
browser, and choose the desired columns.

![screen-column-configuration][]

The file browser uses the “infinite scroll” method to display large
directories — new items are dynamically loaded when the list is scrolled down.

![screen-layout-infinite-scroll][]

To quickly jump to a file or directory, type the beginning of its name in the search bar
located below the breadcrumbs.

![screen-prefix-search][]

Apart from basic details displayed on the list, additional information and characteristics
of files are presented using tags. For instance, the tags include information on whether a
file is shared, has Quality of Service requirements attached, or is marked as Dataset.

![screen-layout-file-tags][]

## File browser features

All file management operations offered by the file browser are available in the
context menu invoked with a right-click or using the three-dots button on
the right of each list entry.

::: tip
Some operations require appropriate [privileges][space-privileges]
in the space and are disabled in the menu in case the user's privileges are not
sufficient.
:::

::: tip
It is possible to invoke the context menu for more than one selected item, but only some
operations are available in this mode.
:::

![screen-feature-file-context-menu][]

### Information

This action brings up the **Info** tab in a **Details** modal with information about a single file or directory.

![screen-feature-info][]

You can also access the Information tab by hovering over the icon of a file or directory.

### Download

This action simply downloads the chosen single file or directory. You can also download
a single file with a double-click.

### Share

Using the **Share** tab in the **Details** modal, you can make a file or
directory publicly accessible by anyone knowing the share link (no authentication or account in
Onedata is needed). If the item has not been shared yet, this action will open a
modal that allows the creation of a new [share][].

![screen-feature-share][]

If the item has already been shared, you will see the list of existing
shares, with the possibility to copy their public links, view their details
(using the green links), or create another share.

![screen-feature-shared-already][]

### Datasets

This action brings up the **Datasets** modal, where you can assign a dataset status to
your file or directory. Datasets are files or directories that space users identify
as meaningful data collections to them. To read more about the functionality of the
Datasets head over to this [page][5].

![screen-feature-datasets][]

### Metadata

This action allows browsing end editing custom file [metadata][metadata-gui], divided into three
classes: basic (key-value), JSON, and RDF. The last two feature a code editor with syntax
checking and highlighting.

![screen-feature-metadata-json][]

### Permissions

Invokes an editor of [permissions][] assigned to the file — [POSIX][posix-permissions] or 
[Access Control List (ACL)][acl]. A file can use only one of the permission types at a
time. To select the currently applied one, use the **Permissions type** toggle.

POSIX permissions are the default type for every new file. You can edit them by using the
octal representation field or manipulating the checkboxes.

![screen-feature-permissions-posix][]

Upon switching to the **ACL** type, a different editor is presented. It allows
creating and editing entries for different principals in the space and assigning
allowing/denying rules for granular operations concerning the file or directory.

![screen-feature-permissions-acl][]

### Data distribution

This tab is used to monitor and manage the [distribution of file data][data-distribution]
among supporting providers. The blue bars visualize which blocks (fragments of the file)
are stored on the storage systems of the corresponding providers. When more than one file
is selected, the distribution can be viewed in a summarized or detailed manner.

![screen-feature-distribution-bar][]

The handy status bar indicates ongoing [replication, migration, and eviction][replication-migration] jobs and
allows scheduling new ones for the corresponding provider. In the detailed view, there is
also a shortcut to the history of data transfers for the subject file (as shown in the
screenshot above).

![screen-feature-distribution-schedule][]

### QoS

The QoS tab brings up an editor of [Quality of Service][] requirements defined for the
selected file(s), which are used to automatically manage the replication of file data
according to logical rules.

You can put down the rules using a visual block-based expression editor. These rules are
evaluated against the QoS parameters assigned to different supporting storage backends 
to determine where the replicas should be stored.

![screen-feature-qos-visual][]

Below the requirement, it is displayed what storage backends match the requirement
and an action that copies the expression in textual form, to be reused when creating a new
requirement or using the [REST API][].

![screen-feature-qos-visual-match][]

Expressions can be entered in the textual form. They are converted to block form
upon confirmation, and then can be further edited.

![screen-feature-qos-text][]

If the selected files have any QoS requirements defined, they are displayed on
the list along with their status of fulfillment, matching storage backends, transfer
statistics, and other information. It is possible to remove selected QoS requirements
unless they are inherited from any parent directory.

![screen-feature-qos-requirements][]

### Rename

The basic operation used to change the file name.

![screen-feature-rename][]

### Create symbolic link

A symbolic link, also known as a symlink, is a special file that acts as a reference or
pointer to another file or directory. First, use the **Create symbolic link** action on
the target file or directory. Then, navigate to the directory where the symbolic link
should be placed and click on the highlighted button in the top right corner.

![screen-feature-symlink][]

### Create hard link

A hard link is a reference to a file that points directly to the underlying data of that
file on a file system. In simpler terms, a hard link is an additional name or entry for an
existing file. Multiple hard links can exist for a single file, and they all refer to the
same underlying data on the disk.

To place a hard link, follow the same steps as for a symbolic link. As you create a hard
link, both the original file and the hard link will now display a label with the number of
hard links referencing the same file. You can click on the label to view the list of hard
links. 


![screen-feature-hardlink][]

### Copy, Cut, and Paste

The **copy** or **cut** action from the context menu can be used on one or
more selected items. Then, a **paste** action will appear in the toolbox, which
can be used to copy or move the files to the current working directory.

![screen-feature-copy-cut][]

### Delete

This action permanently deletes the selected files and directories.

![screen-feature-delete][]

## Mobile file browser

Onedata web file browser supports mobile devices such as smartphones or tablets.
Available features are the same as in desktop mode, but the page layout is adjusted for small devices.

![screen-mobile-overview][]

In mobile mode, the navigation is adapted for touch screens. Instead of a
double click, a tap gesture is used to download a file or open a directory.

Selection is performed by pressing and holding on a file for about a second, and
then selecting further files is done by tapping on them. The context menu for a
file can be invoked using the three-dots menu in the file row or the
**Selection** button at the bottom of the screen.

![screen-mobile-menu][]

![screen-mobile-upload][]

Operations on the current working directory, such as creating a new directory or
uploading files, are available in the breadcrumb navigator. When an upload is
started, a progress bar appears at the bottom of the screen.

## Switching between providers

The file browser view is provided by one of the providers supporting the space.
The currently selected provider is shown on the top of the file browser in the
**View provided by...** bar. Although the provider is chosen automatically, it
is possible to manually select a different one using the **Choose other
Oneprovider...** action at the top of the file browser, given that there is more
than one supporting provider. Alternatively, providers can be switched using a
world map visual representation, available under the globe icon.

![screen-oneprovider-switch][]

::: tip 
After switching to another provider, you will eventually see the same content, but new
changes might appear with different delays. Providers continuously synchronize the data
changes within spaces, and depending on the resource usage, they can take from a couple of
seconds to even hours to propagate. To see the changes immediately, you should choose the
Oneprovider on which you are making them (modifying file content, creating new files or
directories, scheduling data transfers, etc.). 
:::

<!-- references -->

[toc]: <>

[space]: spaces.md

<!-- TODO VFS-7218 improve when the support docs are there -->
[space-support]: spaces.md#request-support-for-space

[provider]: providers.md

[mobile-file-browser]: #mobile-file-browser

[space-privileges]: spaces.md#space-privileges

[share]: shares.md

[metadata-gui]: metadata.md#web-gui

[permissions]: data.md#permissions

[posix-permissions]: data.md#posix-permissions

[acl]: data.md#access-control-lists

<!-- TODO VFS-7218 change to a valid link -->
[data-distribution]: replication-and-migration.md

[replication-migration]: replication-and-migration.md

[Quality of Service]: quality-of-service.md

[REST API]: rest-api.md


[screen-intro-data-overview]: ../../images/user-guide/web-file-browser/intro-data-overview.png

[screen-uploading-empty]: ../../images/user-guide/web-file-browser/uploading-empty.png

[screen-uploading-upload]: ../../images/user-guide/web-file-browser/uploading-upload.png

[screen-uploading-tab]: ../../images/user-guide/web-file-browser/uploading-tab.png

[screen-layout-breadcrumbs]: ../../images/user-guide/web-file-browser/layout-breadcrumbs.png

[screen-layout-context-menu]: ../../images/user-guide/web-file-browser/layout-context-menu.png

[screen-layout-infinite-scroll]: ../../images/user-guide/web-file-browser/layout-infinite-scroll.png

[screen-layout-file-tags]: ../../images/user-guide/web-file-browser/layout-file-tags.png

[screen-feature-file-context-menu]: ../../images/user-guide/web-file-browser/feature-file-context-menu.png

[screen-column-configuration]: ../../images/user-guide/web-file-browser/feature-configure-columns.png

[screen-prefix-search]: ../../images/user-guide/web-file-browser/jump-to-prefix.png

[screen-feature-info]: ../../images/user-guide/web-file-browser/feature-info.png

[screen-feature-share]: ../../images/user-guide/web-file-browser/feature-share.png

[screen-feature-datasets]: ../../images/user-guide/web-file-browser/datasets-modal.png

[screen-feature-shared-already]: ../../images/user-guide/web-file-browser/feature-shared-already.png

[screen-feature-metadata-json]: ../../images/user-guide/web-file-browser/feature-metadata-json.png

[screen-feature-permissions-posix]: ../../images/user-guide/web-file-browser/feature-permissions-posix.png

[screen-feature-permissions-acl]: ../../images/user-guide/web-file-browser/feature-permissions-acl.png

[screen-feature-distribution-bar]: ../../images/user-guide/web-file-browser/feature-distribution-bar.png

[screen-feature-distribution-schedule]: ../../images/user-guide/web-file-browser/feature-distribution-schedule.png

[screen-feature-rename]: ../../images/user-guide/web-file-browser/feature-rename.png

[screen-feature-symlink]: ../../images/user-guide/web-file-browser/feature-sumbolic-link.png

[screen-feature-hardlink]: ../../images/user-guide/web-file-browser/feature-hard-link.png

[screen-feature-copy-cut]: ../../images/user-guide/web-file-browser/feature-copy-cut.png

[screen-feature-delete]: ../../images/user-guide/web-file-browser/feature-delete.png

[screen-feature-qos-visual]: ../../images/user-guide/web-file-browser/feature-qos-visual.png

[screen-feature-qos-visual-match]: ../../images/user-guide/web-file-browser/feature-qos-visual-match.png

[screen-feature-qos-text]: ../../images/user-guide/web-file-browser/feature-qos-text.png

[screen-feature-qos-requirements]: ../../images/user-guide/web-file-browser/feature-qos-requirements.png

[screen-mobile-overview]: ../../images/user-guide/web-file-browser/mobile-overview.png

[screen-mobile-menu]: ../../images/user-guide/web-file-browser/mobile-menu.png

[screen-mobile-upload]: ../../images/user-guide/web-file-browser/mobile-upload.png

[screen-oneprovider-switch]: ../../images/user-guide/web-file-browser/oneprovider-switch.png
