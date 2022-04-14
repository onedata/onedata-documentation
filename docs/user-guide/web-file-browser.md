# Web file browser
<!-- This file is referenced at least one time as "web-file-browser.md" -->

[[toc]]

The Web file browser is a graphical interface offering a broad spectrum of file
management features, including basic file operations (e.g. filesystem
navigation, file upload or download) and advanced capabilities, specific for
Onedata (e.g. Quality of Service, data distribution management, dataset
management).

The file browser is always presented in the context a single [space](spaces.md).
It becomes available when the space is
[supported](spaces.md#request-support-for-space) by at least one provider and
can be invoked by navigating to the **DATA > _Space name_ > Files** tab, or
clicking the **FILES** tile in the space **Overview**.

![Location of file browser in the data tab](../../images/user-guide/web-file-browser/intro-data-overview.png#bordered)
<!-- FIXME add visual indication where is the FILES tile -->
<!-- FIXME refresh screenshots that say "Data" instead of "Files" -->

## Uploading data

A new, empty space welcomes users with the following screen:

![View of empty data space](../../images/user-guide/web-file-browser/uploading-empty.png#bordered)

New files can be uploaded using the **upload** button or y dragging and dropping
them in the file browser area. While the data is being uploaded, a progress
panel appears in the bottom-right corner of the screen. It is possible to upload
multiple files at once or add more files during an ongoing upload.

![Uploading files to an empty directory](../../images/user-guide/web-file-browser/uploading-upload.png#bordered)

After any upload is started, the **UPLOADS** tab will appear in the main menu
sidebar, providing detailed view of all uploads that have been done in the
current browser tab. The information can be viewed in a summarized form or per
the target provider.

![Upload tab](../../images/user-guide/web-file-browser/uploading-tab.png#bordered)


## File browser layout

<!-- FIXME add guide to the oneprovider switcher (and map) -->

The top section of the file browser accommodates a breadcrumb navigator and a
toolbox.

The breadcrumb navigator presents the path to the current working directory and
allows navigation to its parent directories. The current working directory is
the last element in the breadcrumbs and has a context menu with all available
actions for the directory (identical to the context menus on the file list,
described below).

The toolbox, located in the top right corner, contains shortcuts for common
directory actions (*upload files*, *create a new directory* and *refresh file list*).

![Directory breadcrumbs](../../images/user-guide/web-file-browser/layout-breadcrumbs.png#bordered)

The remainder part of the file browser presents the content of the current working
directory in a form of a list with details.

::: tip NOTE
File list navigation is slightly different on mobile devices than on desktop
browsers. This section addresses the latter, while [mobile file
browser](#mobile-file-browser) is covered later on.
:::

Files can be selected or deselected by left-clicking on them. By holding down
`Ctrl` (or `Opt` on MacOS) while clicking, it is possible to select/deselect
multiple files. A range of files can be selected by holding down `Shift`.

A double click on an item opens a directory (sets it as a new current working
directory) or downloads a file.

When an item or multiple selected items are right-clicked, a context menu with
available actions appears.

![Context menu for selected files](../../images/user-guide/web-file-browser/layout-context-menu.png#bordered)

The file browser uses "infinite scroll" approach to display large directories –
new items are dynamically loaded when the list is scrolled down.

![Dynamically loaded file list](../../images/user-guide/web-file-browser/layout-infinite-scroll.png#bordered)

FIXME
In addition to aforementioned file attributes on the list, additional
information are displayed using tags. These include information whether file is
shared, have Quality of Service requirements attached or have Access Control
List (ACL) assigned.

![Example of additional information about files using tags](../../images/user-guide/web-file-browser/layout-file-tags.png#bordered)


## File browser features

<!-- FIXME add missing features (as of 21.02) -->

The context-menu for files provides a rich set of both basic file operations,
such as deleting and copying files, as well as advanced ones, that utilizes
Onedata unique features, like data distribution.

::: tip
Some of file operations requires appropriate
[privileges](spaces.md#space-privileges) in the space for current user. Some of
the operations are applicable to single file or directory, while other can be
used on multiple files at once.
:::

![Context menu for single file](../../images/user-guide/web-file-browser/feature-file-context-menu.png#bordered)


### Information

**Information** shows a modal with additional information about a single file or
directory such as name, path, associated identifiers and owner name.

![Information about file](../../images/user-guide/web-file-browser/feature-info.png#bordered)


### Share

**Share** option gives you the power to make a file or directory public to
non-Onedata users. If file is not shared yet, this action will open a modal that
allows to create a new [share](shares.md), that could be accessed by other
people.

![Share directory modal](../../images/user-guide/web-file-browser/feature-share.png#bordered)

If the file is shared, the modal will show a list of shares associated with it.
You can copy public links or go to their configuration views. You can also
create more shares for this file or directory.

![Share directory modal](../../images/user-guide/web-file-browser/feature-shared-already.png#bordered)


### Metadata

**Metadata** option allows browsing end editing [metadata](metadata.md#web-gui) for
files. A modal that is shown, contains an editor of three types of metadata:
basic (key-value), JSON and RDF. The two last provide a code editor features
like syntax checking and highlighting.

![Share directory modal](../../images/user-guide/web-file-browser/feature-metadata-json.png#bordered)


### Permissions

Using **permissions** option, you can change POSIX permissions and Access
Control List (ACL) of a file.

You can enter an octal representation or use checkboxes to change permissions
details.

![POSIX permissions of file](../../images/user-guide/web-file-browser/feature-permissions-posix.png#bordered)

Selecting **ACL** in the modal switch shows an ACL editor that allows to add
users or groups to the Access Control List and configure detailed permissions
for each. Detailed information about ACL in Onedata can be found in [Access
Control Lists](data.md#access-control-lists) page.

![ACL of file](../../images/user-guide/web-file-browser/feature-permissions-acl.png#bordered)


### Data distribution

**Data distribution** gives you a powerful tool to manage and monitor
distribution of file data among supporting providers.

Data charts visualizes file blocks located on supporting providers for each
selected file or on a summarized view.

![Data distribution charts](../../images/user-guide/web-file-browser/feature-distribution-bar.png#bordered)

You can watch status and schedule a data [replication, migration and
eviction](replication-and-migration.md) on status/action toolbars. There are
also information about ongoing and past data transfers with link to detailed
[transfers](replication-and-migration.md) view.

![Data distribution actions](../../images/user-guide/web-file-browser/feature-distribution-schedule.png#bordered)


### QoS

**Quality of Service** option provides view and management of [Quality of
Service](quality-of-service.md) (QoS) requirements defined for files and their
status of fulfillment.

You can add new QoS requirements for a single or multiple files using a visual
expression editor. The block-based editor allows to create a logical expression
on sets utilizing QoS parameters with their values defined for supporting
storages.

![QoS visual editor: block editing](../../images/user-guide/web-file-browser/feature-qos-visual.png#bordered)

You can check which storages will be used to fulfill the requirement any time
and copy an expression as text to reuse it, e.g. in REST API calls.

![QoS visual editor: storage match and expression](../../images/user-guide/web-file-browser/feature-qos-visual-match.png#bordered)

You can also write the expression as text and convert it to block form for
validation and further edition.

![QoS editor in text mode](../../images/user-guide/web-file-browser/feature-qos-text.png#bordered)

When selected files have QoS requirements defined, the modal shows a list of the
expressions with their status of fulfillment, matching storages and other
information. There is also an option to remove the requirement if it is assigned
directly to the selected file.

![QoS requirements browser](../../images/user-guide/web-file-browser/feature-qos-requirements.png#bordered)


### Rename

**Rename** option shows a modal that allows to change a file name.

![Rename file modal](../../images/user-guide/web-file-browser/feature-rename.png#bordered)


### Copy, Cut and Paste

You can **copy** or **cut** one or multiple files using context menu, and then a
**paste** option should appear in each directory. Simply clicking on this icon
will start files copy or move to a currently opened directory.

![Copy, cut and paste feature](../../images/user-guide/web-file-browser/feature-copy-cut.png#bordered)


### Delete

**Delete** option is used for removing selected files and directories. An opened
modal shows summary and progress of the operation.

![Rename file modal](../../images/user-guide/web-file-browser/feature-delete.png#bordered)


## Mobile file browser

<!-- TODO VFS-7218 all images here should be centered -->

Onedata web file browser supports mobile devices such as smartphones or tablets.
Available features are literally the same as in desktop mode, while the view is
designed for small devices.

![Mobile web file browser – overview](../../images/user-guide/web-file-browser/mobile-overview.png#bordered)

In the mobile mode, navigation is customized for touch screens. Instead of
double click, user should just tap a file or directory to download or open it,

![Mobile web file browser – download](../../images/user-guide/web-file-browser/mobile-download.png#bordered)

Selection is done by holding a file for about a second, and selecting more file
can be achieved by tapping other files. A context menu for a file can be invoked
using three-dots menu in the file row or convenient **Selection...** tool on the
bottom of screen.

![Mobile web file browser – context menu](../../images/user-guide/web-file-browser/mobile-menu.png#bordered)

To perform operations such as creating new directory or uploading files, you
should use context menu of a current directory. When an upload will be started,
a progress appears in the bottom of the screen.

![Mobile web file browser – upload](../../images/user-guide/web-file-browser/mobile-upload.png#bordered)


## Choosing Oneprovider

The file browser features are brought by one of the Oneproviders supporting the
space. The currently used provider is shown on the top of file browser in the
**View provided by...** bar. Although a default one will be chosen
automatically, you can switch it using **Choose other Oneprovider...** on the
top of file browser and choosing a provider from tab bar if the space is
supported by multiple providers. Yo can also open a providers map showing their
locations from a globe icon.

![Switch supporting provider view](../../images/user-guide/web-file-browser/oneprovider-switch.png#bordered)

::: tip
If you choose another Oneprovider, you will eventually see the same
content, but new changes might appear with different delay. Oneproviders
continuously synchronize the data changes within space, and depending on the
system usage intensity, they can take from couple of seconds to even hours to
propagate. To see the changes immediately, make sure to choose the Oneprovider
on which you are working (making computations, scheduling data transfers etc).
:::
