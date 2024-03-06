# Data

[toc][]

## Onedata virtual filesystem

The Onedata system organizes all user data into logical containers called **spaces**.
Refer to [this][spaces] chapter for details about this concept and how
the logical files are mapped to their physical content on storage backends.

The Onedata filesystem is managed by [Providers][] cooperating in a peer-to-peer manner,
synchronizing information about commonly [supported spaces][space support]. A provider is
a data center that runs a [Oneprovider service][], registered in a [Onedata zone][].

<!-- TODO VFS-11766 More information about the Onedata filesystem, how it's built, 
file types, file trees etc. -->

## File path and ID

Any file in Onedata (**regular**, **directory**, **symbolic link**, or **hard
link**) can be globally identified using its unique **File ID** or **logical
path**.

**Logical path** specifies the location of a file or directory in the Onedata filesystem.
It uses the slash (`/`) delimiter and must start with a leading slash followed by a space name:

```
/CMS 1/directory/images&videos/garden.png
```

**File ID** is a unique, global identifier associated with a file, structured as
a string of alphanumeric characters:

```
094576776E667431723230677767776C6B497031394E445F6E3868677873...
```

The path-based navigation is used mainly in the [Web GUI][] and [Oneclient][]
interfaces. In the [REST][] and [CDMI][] APIs, it is **recommended to use File
IDs**, due to better performance and no need for escaping or encoding.

### Find out the File ID

There are several ways to find out the File ID of a file:

[Web GUI][] — click on **Information** in the context menu for a file/directory and look
for `File ID`:
![screen-file-gui-path-and-info][]

[Oneclient][] — use the `xattr` command (which reads extended attributes) to access
useful information about any file or directory. The below command returns specifically the
File ID attribute:

```bash
~$ xattr -p org.onedata.file_id garden.png
094576776E667431723230677767776C6B497031394E445F6E3868677873...
```

::: tip
Use `xattr -l garden.png` to list all available attributes.
:::

[REST API][REST] — use the [File ID resolution endpoint][]. The below example returns the
File ID of <br />`/CMS 1/directory/images&videos/garden.png`, where `CMS 1` is the space
name:

```bash
curl -H "X-Auth-Token: ${ACCESS_TOKEN}" -X POST \
"https://${PROVIDER_DOMAIN}/api/v3/oneprovider/lookup-file-id/CMS%201/directory/images%26videos/garden.png"
```

```json
{
    "fileId": "094576776E667431723230677767776C6B497031394E445F6E3868677873..."
}
```

::: warning NOTE
Paths used in URLs must be URL-encoded.
:::

::: tip
The `${PROVIDER_DOMAIN}` can be obtained as shown [below][Provider domain].
:::

### Working with file paths

[Web GUI][] — the path is represented in the file browser's **breadcrumb**. You may find
it as copyable text in the **File information** modal.

![screen-file-gui-path-and-info][]

[Oneclient][] — when using a shell to access the mounted filesystem,
some characters in paths should be properly escaped:

```
~$ cat /CMS\ 1/directory/images\&videos/garden.png
```

[REST][] or [CDMI][] API — make sure to URL-encode paths used in URLs:

```
{...}/CMS%201/directory/images%26videos/garden.png
```

<!-- TODO VFS-9288 unify all NOTE blocks -->

::: warning NOTE
Duplicate space names are generally allowed. For that reason, referencing
files by path may be ambiguous. During file path resolution, the first space whose name
matches the first segment of the path is always taken, but the order in which spaces are
checked cannot be guaranteed.
:::

## Interfaces

Onedata offers several ways of accessing and managing user data. Regardless of the
interface you choose, you will have a unified view of all your files. All data management
interfaces are available in Onedata [Providers][] that build a distributed environment.
You can use any provider that [supports your spaces][space support] to access the data.
While the [Web GUI][] offers natural navigation between providers, the other interfaces
require that you select one of your providers and are aware of its domain (see below).

### Provider domain

<!-- TODO VFS-11766 this should be moved somewhere else — maybe a new chapter with providers GUI
     from the user's point of view? -->

Provider's domain is required to mount a [Oneclient][] instance or utilize the
[REST][] and [CDMI][] APIs. It can be found in the Web GUI:

![screen-provider-domain][]

### Web GUI

The most user-friendly method of data management. You can find a visual guide in
[this chapter][Web file browser guide].

### Oneclient

Oneclient is a command-line-based application used for mounting
Onedata spaces in the local file system tree. To that end, Oneclient requires a
network connection to the chosen Oneprovider service. [This chapter][Oneclient chapter]
covers information about its setup and usage.

### REST API

Oneprovider service offers a comprehensive REST API for data management. All endpoints use
[File IDs][file-path-and-id] to identify files and directories, though some endpoints work
on file paths. The documentation based on OpenAPI (a.k.a. Swagger) can be found
[here][Oneprovider REST API]. General information on using the REST APIs in Onedata is
covered in [this chapter][REST API chapter].

### CDMI

Oneprovider implements a subset of **Cloud Data Management Interface** specification, as
described in [this chapter][CDMI chapter].

## Data Access Control

Access to the Onedata filesystem is regulated by applying **authentication and
authorization** checks for every operation.

### Authentication

Each operation is done in the context of a specific authenticated user. If the requesting
client provides no authentication, it is treated as **guest**, who is entitled only to
publicly accessible data. Authentication is carried by [access tokens][] — bearer tokens
issued in the name of a specific subject (e.g. user). Access tokens are used uniformly in
the system, in [REST API][REST], [Oneclient][], or [Web GUI][] (the Web application
obtains an access token after a user logs in and refreshes it as needed).

### Authorization

The decision of whether an authenticated client is allowed to perform the requested
operation depends on a series of security checks on different levels. The
procedure can be divided into steps as follows (the steps are processed in
sequence unless the procedure finishes upon **access denied** or **granted**):

1. The provided access token is analyzed concerning [caveats][] that can restrict the
   authorization. Especially [data access caveats][] have a significant impact on data
   access. If the requested operation or resource is forbidden regarding any caveat,
   **access is denied**.

2. If the user is not a [space member][], **access is denied**.

3. [Dataset protection flags][datasets] are checked — if the requested operation is forbidden by
   current protection flags, **access is denied**. For example, a file content
   modification request will be denied if the file is located in a dataset that has data
   protection enabled.

4. If the user is a [space owner][], **access is granted** (space owners omit space
   privilege and permission checks).

5. If the user does not have the [space privileges][] required for the requested
   operation, **access is denied**. For example, no `space_write_data` privilege in case
   of file modification request, or no `space_read_data` privilege in case of directory
   listing request.

6. If an [Access Control List][] (ACL) exists on the file, it is evaluated to
   determine whether access should be **denied** or **granted**.

7. Otherwise, [POSIX permissions][] are checked to determine whether access should be
   **denied** or **granted**.

In case of unauthenticated (**guest**) access, the steps are as follows:

1. The requested resource identifier is analyzed if it points to a file or directory that
   is [publicly shared][shares] — if not, **access is denied**.

2. Steps 6 or 7 from the previous procedure are applied (it is possible to limit access to
   shared data using the [`ANONYMOUS@`][ACE] or [`EVERYONE@`][ACE] ACL principal or the
   POSIX permissions for [`others`][POSIX permissions]).

::: tip NOTE
In the case of [publicly shared][shares] files or directories, the access is additionally
limited to read-only operations, even if ACLs or POSIX permissions allow write access.
:::

### POSIX permissions

Onedata implements traditional POSIX permissions typical for Unix or Linux systems for
specifying access rights to files or directories. However, all space members are treated
as a virtual group which is the **group** owner of all files in the space. This means that
whenever a file is accessed by a space member who is not the owner of the file, the
**group** permissions are taken into consideration. Permissions for **others** are
considered when a [public share][shares] is accessed (as an anonymous **guest**).

The above differences stem from the fact that in Onedata, there is an additional layer of
access control imposed by membership in [spaces][] (which are completely separated logical
data containers). Moreover, the concepts of POSIX **group** and Onedata [group][] are
different.

Examine the following example of file POSIX permissions:

```
rwx r-- ---
 |   |   |
 |   |   guests
 |   |
 |   space members
 |
 owner user
 
```

In the above case, the creator of the file (its **owner** user) has full access
to the file. All space members have read access to the file. Users (guests) who
try to access the file through a public share will fail to do so as all
permissions are denied for **others**.

Default permissions (for newly created files/directories) are as follows:

* files: `rw- rw- r--` (octal: `664`)
* directories: `rwx rwx r-x` (octal: `775`)

You can change the POSIX permissions using the [Web file browser][Web GUI change permissions]
in the **Permissions** tab in the **File Information** modal or using the [REST API][REST set attr].

Oneprovider admins should keep in mind that the [Local User Mapping Database][LUMA] must be
properly set up for each storage backend supporting a space. This is required so that file
permissions are accurately enforced in the space and the permissions in Onedata are
correctly mapped onto and from actual permissions on the storage, especially concerning
the above-mentioned **group** and **others** semantics.

### Access Control Lists

**Access Control Lists (ACL)** are a mechanism for regulating access to files
and directories using hierarchical rules that grant and deny granular operations
for a specific principal. Onedata supports a subset of CDMI ACL which are based
on NFSv4 standard [RFC 3530][].

An ACL is an ordered list of **ACEs (Access Control Entries)**. ACEs are
evaluated strictly in the same order as they were added, top-down. If any
of the ACEs denies or grants access to the considered principal, evaluation is
stopped.

#### Access Control Entry

An ACE consists of four fields:

* `who` — the principal whom the ACE affects:
  * user or [group][] represented by their identifier,
  * `OWNER@` — the owner of the file,
  * `OWNING GROUP@` — members of space which contain the file,
  * `ANONYMOUS@` — guest client (accessing through a share),
  * `EVERYONE@` — everyone, including the anonymous users.
* `type` — `ALLOW` or `DENY` operation specified by `access_mask` to the principal (`who`),
* `flags` — currently only the flag indicating whether the principal identifier points to
  the user or group is supported, other flags can be set or [imported][storage import],
  but they will be ignored during ACE evaluation,
* `access_mask` — the permissions regulated by this ACE.

You can assign ACL rules using the [Web file browser][Web GUI change permissions] in the
**File Information** modal or using the [CDMI API][CDMI set ACL operation].

#### Permissions

ACL provides more fine-grained control of access to resources than POSIX permissions:

#### ACL for a file

| Permissions      |                                                |
| ---------------- | ---------------------------------------------- |
| Read             | open file for read                             |
| Write            | open file for write                            |
| Read ACL         | read file ACL                                  |
| Change ACL       | write file ACL                                 |
| Read metadata    | read file metadata                             |
| Write metadata   | write file metadata                            |
| Read attributes  | read metadata associated with file attributes  |
| Write attributes | write metadata associated with file attributes |
| Delete           | delete file                                    |

#### ACL for a directory

| Permissions        |                                                     |
| ------------------ | --------------------------------------------------- |
| List files         | list directory content                              |
| Add files          | add file to directory                               |
| Add subdirectory   | add subdirectory to directory                       |
| Traverse directory | navigate through a directory structure              |
| Delete child       | delete file or subdirectory from directory          |
| Read ACL           | read attributes metadata                            |
| Change ACL         | change attributes metadata                          |
| Read metadata      | read directory metadata                             |
| Write metadata     | write directory metadata                            |
| Read attributes    | read metadata associated with directory attributes  |
| Write attributes   | write metadata associated with directory attributes |
| Delete             | delete directory                                    |

#### Evaluation

Each ACE in an ACL either allows or denies some set of permissions. The request
handling provider will evaluate the resource (file or directory) ACEs until all
requested permissions are granted or any of them is denied using the following
algorithm:

1. The ACE is checked for applicability. ACEs that do not refer to the principal
   requesting the operation or any requested permission are ignored.

2. If the ACE denies any of the requested permissions, then access is denied and
   the algorithm terminates.

3. If the ACE allows any of the requested permissions, then they are added
   to the list of granted permissions. If the list includes all the requested
   permissions, the access is granted and the algorithm terminates.

4. If the end of the ACL list is reached and **permission has neither been
   fully granted nor explicitly denied**, **access is denied** and the algorithm
   terminates.

::: warning NOTE
Because of the above, when setting ACL rules, you should make sure that there is at least
one rule with a principal matching yourself and allowing ACL reading/changing. Otherwise,
you will lose the ability to manage the ACLs. In such a case, only a [space owner][] can
help.
:::

<!-- TODO VFS-7189 revise, move? -->

## File distribution

On the physical level, Onedata organizes files into blocks of various sizes.
These file blocks can then be distributed across different providers that
support the space in which the files are stored. Each provider contains
a list of local file blocks, forming what we call a `file replica`.
Information about the mapping between logical and physical files is stored
in the file metadata, which is replicated and synchronized between all
supporting providers.

When you read a whole file or its part, and some blocks are not present in the
provider you're connected to, the missing blocks will be replicated on demand
from other providers.

When you write to a file in a given provider, the overlapping blocks replicated
to other providers are invalidated. To read the file, the provider with
invalidated blocks must once again replicate missing blocks from the provider
with the newest version of the blocks.

Simultaneous modifications of a file may occur when many users access it.
If the ranges of simultaneous modifications do not overlap, all modifications
are safely applied. In case of a conflict, a conflict resolution algorithm is
used. This allows all supporting providers to determine a consistent, final
version of the file. Conflict resolution is performed independently by each
provider without the need to coordinate the resolution with other supporting
providers, which allows it to be fast.

### Discovering file distribution

You can discover how the file blocks are distributed among providers supporting
the space in which it is stored like below:

1. `Web GUI` — open the context menu for the file and choose **Data distribution**:
   ![screen-file-distribution-gui][]

   and you will see **Data distribution** modal, representing the distribution
   of file blocks:
   ![screen-file-distribution-modal][]

2. `REST API` — use [get file distribution][REST get distribution] endpoint.

3. `Oneclient` — check [file extended attributes][Oneclient xattrs]
   and inspect `org.onedata.file_blocks`, `org.onedata.file_blocks_count` and
   `org.onedata.replication_progress` attributes:

   ```bash
   ~$ xattr -l results.txt

   org.onedata.file_blocks: [#######################################.         ]
   org.onedata.file_blocks_count: 1
   org.onedata.replication_progress: 80% 
   ...
   ```

   ::: tip
   Extended attributes present only information about file blocks stored in the provider
   to which the Oneclient is connected. To find information about replicas of the file in
   other providers, use the Web GUI or REST API (see above).
   :::

### Distribution management

You can manage the data distribution using:

1. [Transfers][] — allow to intentionally replicate, evict, and migrate file(s).

2. [Quality of Service][] — allows specifying requirements
   that may ensure that file replicas in certain providers are automatically
   updated and protected from eviction.

3. [Auto-cleaning][] — automatically maintains storage usage at a predefined level,
   creating space for new replicas during continuous computations.

   ::: tip NOTE
   Auto-cleaning can only be configured by a space admin.
   :::

<!-- references -->

[toc]: <>

[file-path-and-id]: #file-path-and-id

[Web GUI]: #web-gui

[Oneclient]: #oneclient

[REST]: #rest-api

[CDMI]: #cdmi

[Provider domain]: #provider-domain

[Access Control List]: #access-control-lists

[ACE]: #access-control-entry

[POSIX permissions]: #posix-permissions

[group]: groups.md

[spaces]: spaces.md

[space member]: spaces.md#space-members

[space privileges]: spaces.md#space-privileges

[space support]: spaces.md#space-support

[space owner]: spaces.md#space-owner

<!-- TODO VFS-10933 link to the providers section -->

[Providers]: ../intro.md#architecture

<!-- TODO VFS-11766 place some sensible link here -->

[Oneprovider service]: ../intro.md#architecture

<!-- TODO VFS-11766 place some sensible link here -->

[Onedata zone]: ../intro.md#architecture

[Web file browser guide]: web-file-browser.md

[Web GUI change permissions]: web-file-browser.md#permissions

[Oneclient chapter]: oneclient.md

[Oneclient xattrs]: oneclient.md#file-extended-attributes

[REST API chapter]: rest-api.md

[File ID resolution endpoint]: https://onedata.org/#/home/api/stable/oneprovider?anchor=operation/lookup_file_id

[CDMI chapter]: cdmi.md

[CDMI set ACL operation]: cdmi.md#set-file-acl

[Oneprovider REST API]: https://onedata.org/#/home/api/stable/oneprovider

[REST set attr]: https://onedata.org/#/home/api/stable/oneprovider?anchor=operation/set_attr

[REST get distribution]: https://onedata.org/#/home/api/stable/oneprovider?anchor=operation/get_file_distribution

[access tokens]: tokens.md#access-tokens

[caveats]: tokens.md#token-caveats

[data access caveats]: tokens.md#data-access-caveats

[datasets]: datasets.md

[shares]: shares.md

[RFC 3530]: https://tools.ietf.org/html/rfc3530

[storage import]: ../admin-guide/oneprovider/configuration/storage-import.md

[LUMA]: ../admin-guide/oneprovider/configuration/luma.md

[Transfers]: data-transfer.md

[Quality of Service]: qos.md

[Auto-cleaning]: ../admin-guide/oneprovider/configuration/auto-cleaning.md

[screen-file-gui-path-and-info]: ../../images/user-guide/data/file-gui-path-and-info.png

[screen-provider-domain]: ../../images/user-guide/data/provider-domain.png

[screen-file-distribution-gui]: ../../images/user-guide/data/file-distribution-gui.png

[screen-file-distribution-modal]: ../../images/user-guide/data/file-distribution-modal.png
