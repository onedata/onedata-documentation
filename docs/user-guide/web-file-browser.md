# Web file browser
<!-- This file is referenced at least one time as "web-file-browser.md" -->

When you have an access to a data space that is [supported](spaces.md#gui-guide) by at least one Oneprovider, you can access and manage the data using the web file browser, which is available in the **DATA > Space > Data** tab.

![Location of file browser in data tab](../../images/user-guide/web-file-browser/intro-data-overview.png#bordered)

## Choosing supporting Oneprovider

The file browser features are backed up by the one of Oneproviders supporting the space. The currently used provider is shown on the top of file browser in the **View provided by...** bar. Although a default one will be choosen, you can switch it using **Choose other Oneprovider...** button on the top of file browser if the space is supported by multiple providers. You can then choose a provider using tabbar or use a globe icon on the right to open a Oneproviders map that will present locations of providers.

![Switch supporting Oneprovider view](../../images/user-guide/web-file-browser/switch-provider.png#bordered)

> *NOTE:* 
> If you choose another Oneprovider, you will eventually see the same content, but new changes might appear with different delay. Oneproviders continuously synchronize the data changes within space, and depending on the system usage intensity, they can take from couple of seconds to even hours to propagate. To see the changes immediately, make sure to choose the Oneprovider on which you are working (making computations, scheduling data transfers etc).

## Uploading the data

The empty space that does not contain any data will welcome you with the following screen:

![View of empty data space](../../images/user-guide/web-file-browser/intro-empty.png#bordered)

To put a life into this empty place, you can add some files using upload button or drag&drop files from your computer. While files or directories are sent, a progress panel will appear in the bottom-right corner of the screen. You can upload multiple files at a time, as well as add more files at any moment.

![Uploading files to an empty directory](../../images/user-guide/web-file-browser/intro-upload.png#bordered)

To manage uploads easily, an **UPLOADS** tab will appear in the main menu sidebar, providing advanced view of all uploads that have been started by current user in current browser window. The information can be grouped by Oneprovider to which files are sent.

![Upload tab](../../images/user-guide/web-file-browser/intro-upload-tab.png#bordered)

## File browser layout

The file browser can be splitted into two main parts:

1. Header, that contains breadcrumbs showing current directory path and basic actions toolbar.
2. Files list.

### File browser header

The breadcrumbs bar contains a path to currently viewed directory and allows to navigate to one of its parent directory by clicking on its link. The currently opened directory, that is shown on the breadcrumbs end, provides a context menu with file actions.

On the right of directory breadcrumbs, there are basic action buttons that allows to upload files, create a new directory and refresh files list of current directory. Note, that these actions are also available in the current directory context menu.

![Directory breadcrumbs](../../images/user-guide/web-file-browser/breadcrumbs.png#bordered)

### File list

The file list shows listing of currenlty chosen directory. Each file row has displayed its name, size (if its not a directory) and modification time.

Navigation slightly differs on mobile devices and on desktop browsers. In this section, we describe usage of file browser on desktop.

By clicking once on a non-selected file, it will be selected or deselcted when it was. You can select or deselect multiple files using Ctrl (or Opt on MacOS) when clicking on them. You can also select range of files, when some file is selected and another file is clicked using Shift.

By clicking on an file item twice, you can open the directory or download a file.

When an item or set of selected items are clicked with right mouse button, a context menu appears with file actions.

![Context menu for selected files](../../images/user-guide/web-file-browser/selected-context-menu.png#bordered)

When there are more files than can be displayed on single screen, you can scroll down to browse full list of files. The list is dynamically loaded while scrolling down - don't worry, that a one-million list of files will be loaded right after entering a directory.

![Dynamically loaded file list](../../images/user-guide/web-file-browser/infinite-scroll.png#bordered)

In addition to aftermentioned file attributes on the list, additional information about files can be displayed using tags. These include information whether file is shared, have Quality of Service requirements attached or have ACL assigned.

![Example of additional information about files using tags](../../images/user-guide/web-file-browser/file-tags.png#bordered)


## File browser features

The context-menu for files provides a rich set of both basic file operations such as deleting and copying files, as well as advanced ones, that utilizes Onedata unique features, like data distribution. Note, that some of them requires appropriate [privileges](spaces.md#space-privileges) in the space for current user and some of them are applicable to sigle files or directories, while other can be used on multiple files at a time.

![Context menu for single file](../../images/user-guide/web-file-browser/single-file-context-menu.png#bordered)

### Information

**Information** shows a modal with additional information about file such as name, path, associated identifiers and owner name.

![Information about file](../../images/user-guide/web-file-browser/action-info.png#bordered)

### Share

**Share** option gives you the power to make a file or directory public to non-Onedata users. If file is not shared yet, this action will open a modal that allows to set a name of the share that will be visible to others.

![Share directory modal](../../images/user-guide/web-file-browser/action-share.png#bordered)

If the file is shared, the modal will show a list of shares associated with it. You can copy public links or go to their configuration views. You can also create more shares for this file.

![Share directory modal](../../images/user-guide/web-file-browser/action-shared-already.png#bordered)

Detailed information about shares can be found in the [shares](shares.md) documentation.

### Metadata

**Metadata** allows to browse and edit [metadata](metadata.md) for files. The modal contains basic (key-value), JSON and RDF editor. The two last provide a code editor features like syntax checking and highlighting.

![Share directory modal](../../images/user-guide/web-file-browser/action-metadata-json.png#bordered)

### Permissions

Using **permissions** option, you can change POSIX permissions and Access Control List (ACL) of file.

You can enter an octal representation or use checkboxes to change detailed permissions and see a text representation.

![POSIX permissions of file](../../images/user-guide/web-file-browser/action-permissions-posix.png#bordered)

Selecting **ACL** switch in the modal shows the ACL editor that allows to add users or groups to the access control list and configure detailed permissions for each. Detailed information about ACL configuration can be found in [Access Control Lists](data.md#access-control-lists) documentation.

![ACL of file](../../images/user-guide/web-file-browser/action-permissions-acl.png#bordered)

### Data distribution

**Data distribution** is a powerful tool to manage and monitor distribution of file data among supporting providers.

Data charts shows visualization of file blocks located on supporting providers for each selected file or on summarized view.

![Data distribution charts](../../images/user-guide/web-file-browser/action-distribution-bar.png#bordered)

You can watch and schedule a data [replication, migration and eviction](replication-and-migration.md) on the status/action toolbar. There are also information about ongoing and past data transfers with link to detailed [transfers](replication-and-migration.md) view.

![Data distribution actions](../../images/user-guide/web-file-browser/action-distribution-schedule.png#bordered)

### QoS

**Quality of Service** option provides view and management of [Quality of Service](quality-of-service.md) requirements defined for files and their status of fulfillment.

You can add new QoS requirements for a single or multiple files using visual editor. A block-based editor allows to create a logical expression with set operators using QoS parameters with their values defined for supporting storages.

![QoS visual editor: block editing](../../images/user-guide/web-file-browser/action-qos-visual.png#bordered)

You can check which storages will be used to fulfill the requirement any time and copy an expression as text to reuse it for example in REST API.

![QoS visual editor: storage match and expression](../../images/user-guide/web-file-browser/action-qos-visual-match.png#bordered)

You can also write the expression as text and convert it to visual form for validation and further edition.

![QoS editor in text mode](../../images/user-guide/web-file-browser/action-qos-text.png#bordered)

When selected files have QoS requirements already defined, the modal shows a list of the expressions with their status of fullfilment, matching storages and other information. There is also an option to remove the requirement if it is assigned directly to the selected file.

![QoS requirements browser](../../images/user-guide/web-file-browser/action-qos-requirements.png#bordered)


### Rename

**Rename** option simply shows a modal that allows to change a file name.

![Rename file modal](../../images/user-guide/web-file-browser/action-rename.png#bordered)

### Copy, Cut and Paste

You can **copy** or **cut** one or multiple files using context menu, and then a **paste** option should appear in each directory. Simply clicking this icon will start files copy or move.

![Rename file modal](../../images/user-guide/web-file-browser/action-copy-cut.png#bordered)

### Delete

**Delete** option removes selected files and directories, showing summary and progress of the operation.

![Rename file modal](../../images/user-guide/web-file-browser/action-delete.png#bordered)

# Mobile file browser

Onedata web file browser supports mobile devices such as smartphones and tablets. Available features are literally the same as in desktop mode, but the view is designed for small devices.

![Mobile web file browser - overview](../../images/user-guide/web-file-browser/mobile-overview.png#bordered)

The navigation is also customized for touch screens.

Instead of double click, user should just tap a file or directory to download or open it,

![Mobile web file browser - download](../../images/user-guide/web-file-browser/mobile-download.png#bordered)

Selection is done by holding a file for about a second, and selecting more by tapping other files. A context menu for files can be invoked using three-dots menu or convenient **Selection...** tool on the bottom of screen.

![Mobile web file browser - context menu](../../images/user-guide/web-file-browser/mobile-menu.png#bordered)

To perform operations such as create new directory or upload files in current directory you should use its context menu. When an upload will be started, a progress appears in the bottom of the screen.

![Mobile web file browser - upload](../../images/user-guide/web-file-browser/mobile-upload.png#bordered)
