# Data

[toc]()

The Onedata system organizes all user data into logical containers called spaces.
Refer to [this](spaces.md) chapter for details about this concept and how
the logical files are mapped to their physical content on storage backends.

## File path and ID

You can globally identify files and directories in Onedata using unique file IDs
or logical paths. Whenever possible, it is recommended to use File IDs for better
performance and no need for escaping or encoding.

### File path

All logical paths in Onedata use the slash `/` delimiter and must start with a
space name:

```
/CMS 1/directory/images&videos/garden.png
```

The path-based navigation is used mainly in the Web GUI and Oneclient interfaces.

[Web GUI](#web-gui) — the path is represented in the file browser's breadcrumbs.

![image](../../images/user-guide/data/file-gui-path-and-info.png#screenshot)

[Oneclient](#oneclient) — when using a shell to access the mounted filesystem,
some characters in paths should be properly escaped:

```
~$ cat /CMS\ 1/directory/images\&videos/garden.png
```

[REST](#rest-api) or [CDMI](#cdmi) API — paths used in URLs must be URL-encoded:

```
{...}/CMS%201/directory/images%26videos/garden.png
```

<!-- TODO VFS-9288 unify all NOTE blocks -->

> **NOTE:** Duplicate space names are generally allowed. For that reason,
> referencing files by path may be ambiguous. During file path resolution, the
> first space whose name matches the first segment of the path is always taken,
> but the order in which spaces are checked cannot be guaranteed.

### File ID

The file ID is a unique, global identifier associated with a file or directory.
You can universally utilize it in the [REST](#rest-api) and [CDMI](#cdmi) APIs.
To find out the File ID of a given file or directory, you have several options:

[Web GUI](#web-gui) — the `File ID` can be obtained using the **Information** action in the
file/directory context menu:
![image](../../images/user-guide/data/file-gui-path-and-info.png#screenshot)

[Oneclient](#oneclient) — useful information about every file is accessible
using the `xattr` command (that reads extended attributes) — the below command
returns specifically the File ID attribute:

```bash
~$ xattr -p org.onedata.file_id garden.png
094576776E667431723230677767776C6B497031394E445F6E3868677873...
```

> **NOTE:** Use `xattr -l garden.png` to list all available attributes.

[REST](#rest-api) — use the File ID
[resolution endpoint](https://onedata.org/#/home/api/stable/oneprovider?anchor=operation/lookup_file_id).
The below example returns the File ID of <br />`/CMS 1/directory/images&videos/garden.png`, where `CMS 1` is the space name
(consult [file path](#file-path)):

```bash
curl -H "X-Auth-Token: ${ACCESS_TOKEN}" \
-X POST "https://${ONEPROVIDER_DOMAIN}/api/v3/oneprovider/lookup-file-id/CMS%201/directory/images%26videos/garden.png"
```

```json
{
    "fileId": "094576776E667431723230677767776C6B497031394E445F6E3868677873..."
}
```

> **NOTE:** Paths used in URLs must be url-encoded.

> **NOTE:** The `${ONEPROVIDER_DOMAIN}` can be obtained as shown
> [below](#oneprovider-domain).

## Interfaces

Onedata offers several ways of accessing and managing user data.
Regardless of the interface you choose, you will have a unified view of all your files.
All data management interfaces are available in the [Oneprovider service](../intro.md#architecture).
Depending on the environment, there might be several Oneprovider services
[supporting user spaces](spaces.md#space-support) that you can use to access the data.
While the [Web GUI](#web-gui) offers natural navigation between services,
the other interfaces require that the user chooses one of their Oneproviders
and is aware of its domain (see below).

### Oneprovider domain

Oneprovider's domain is required to mount a [Oneclient](#oneclient) instance or
utilize the [REST](#rest-api) and [CDMI](#cdmi) APIs. It can be found in the Web
GUI: ![image](../../images/user-guide/data/provider-domain.png#screenshot)

### Oneclient

Oneclient is a command-line based application used for mounting
Onedata spaces in the local file system tree. To that end, Oneclient requires a
network connection to chosen Oneprovider instance. [This chapter](oneclient.md)
covers information about its setup and usage.

### REST API

Oneprovider service offers a comprehensive REST API for data management. All
endpoints use [File IDs](#file-id) to identify files and directories. The
documentation based on OpenAPI (a.k.a. Swagger) can be found
[here](https://onedata.org/#/home/api/stable/oneprovider). General information
on using the REST APIs in Onedata are covered in [this chapter](rest-api.md).

### CDMI

Oneprovider implements a subset of **Cloud Data Management Interface**
specification, as described in [this chapter](cdmi.md).

### Web GUI

The most end-user friendly method of data management.
You can find a visual guide in [this chapter](web-file-browser.md).

## Data Access Control

Access to the Onedata filesystem is regulated by applying **authentication and
authorization** checks for every operation.

### Authentication

Each operation is done in the context of a specific authenticated user. If the
requesting client provides no authentication, they are treated as **guest**, who
is entitled only to publicly accessible data. Authentication is carried by
[access tokens](tokens.md#access-tokens) — bearer tokens issued in the name of
a specific subject (e.g. user). Access tokens are used uniformly in the system,
in [REST API](rest-api.md), [Oneclient](oneclient.md) or [Web GUI](#web-gui)
(the Web application obtains an access token after a user logs in and refreshes
it as needed).

### Authorization

The decision of whether an authenticated client is allowed to perform the requested
operation depends on a series of security checks on different levels. The
procedure can be divided into steps as follows (the steps are processed in
sequence unless the procedure finishes upon **access denied** or **granted**):

1. The provided access token is analyzed concerning
   [caveats](tokens.md#token-caveats) that can restrict the authorization.
   Especially [data access caveats](tokens.md#data-access-caveats) have a
   significant impact on data access. If the requested operation or resource is
   forbidden in regard to any caveat, **access is denied**.

2. If the user is not a [space member](spaces.md#space-members), **access is
   denied**.

3. [Dataset protection flags](datasets.md) are checked — if the requested
   operation is forbidden by current protection flags, **access is denied**. For
   example, a file content modification request will be denied if the file is
   located in a dataset that has data protection enabled.

4. If the user is a [space owner](spaces.md#space-owner), **access is
   granted** (space owners omit space privilege and permission checks).

5. If the user does not have the [space privileges](spaces.md#space-privileges)
   required for the requested operation, **access is denied**. For example, no
   `space_write_data` privilege in case of file modification request, or no
   `space_read_data` privilege in case of directory listing request.

6. If a [CDMI Access Control List](#access-control-lists) (ACL) exists on the
   file, it is evaluated to determine whether access should be **denied** or
   **granted**.

7. Otherwise, [POSIX permissions](#posix-permissions) are checked to determine
   whether access should be **denied** or **granted**.

In case of unauthenticated (**guest**) access, the steps are as follows:

1. The requested resource identifier is analyzed if it points to a file or
   directory that is [publicly shared](shares.md) — if not, **access is
   denied**.

2. Steps 6 or 7 from the previous procedure are applied (it is possible to
   limit access to shared data using the [`ANONYMOUS@`](#access-control-entry) ACL
   principal or the POSIX permissions for [`others`](#posix-permissions)).

> **NOTE:** in case of [publicly shared](shares.md) files or directories, the
> access is additionally limited to read-only operations, even if ACLs or POSIX
> permissions allow write access.

### Access Control Lists

**Access Control Lists (ACL)** are a mechanism for regulating access to files
and directories using hierarchical rules that grant and deny granular operations
for a specific principal. Onedata supports a subset of CDMI ACL which are based
on NFSv4 standard [RFC 3530](https://tools.ietf.org/html/rfc3530).

An ACL is an ordered list of **ACEs (Access Control Entries)**. Oneprovider
evaluates ACEs strictly in the same order as they were added, top-down. If any
of the ACEs denies or grants access to the considered principal, evaluation is
stopped.

#### Access Control Entry

An ACE consists of four fields:

* `who` — the principal whom the ACE affects:
  * user or group represented by their identifier

  <!---->

  * `OWNER@` — the owner of the file
  * `OWNING GROUP@` — members of space which contain the file
  * `ANONYMOUS@` — guest client (accessing through a share)
  * `EVERYONE@` — everyone, including the anonymous users
* `type` — `ALLOW` or `DENY` operation specified by `access_mask` to the principal (`who`)
* `flags` — currently only the flag indicating whether the principal identifier points to
  the user or group is supported, other flags can be set or
  [imported](../admin-guide/oneprovider/configuration/storage-import.md),
  but they will be ignored during ACE evaluation
* `access_mask` — the permissions regulated by this ACE

You can change permissions using the [Web file browser](web-file-browser.md#permissions)
in the **File Details** modal or using the [CDMI API](cdmi.md#set-file-acl).

#### Permissions

ACL provides more fine-grained control of access to resources than POSIX permissions.

All available permissions and their meaning for files or directories are presented below.

#### ACL for file

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

#### ACL for directory

| Permissions        |                                                     |
| ------------------ | --------------------------------------------------- |
| List files         | list directory content                              |
| Add files          | add file to directory                               |
| Add subdirectory   | add subdirectory to directory                       |
| Traverse directory | navigate through a directory structure              |
| Delete child       | delete file or subdirectory from directory          |
| Read ACL           | delete file or subdirectory from directory          |
| Change ACL         | read attributes metadata                            |
| Read metadata      | read directory metadata                             |
| Write metadata     | write directory metadata                            |
| Read attributes    | read metadata associated with directory attributes  |
| Write attributes   | write metadata associated with directory attributes |
| Delete             | delete directory                                    |

#### Evaluation

Each ACE in an ACL either allows or denies some set of permissions.
Oneprovider will evaluate the resource (file or directory) ACEs until
all requested permissions are granted or any of them is denied using
the following algorithm:

1. The ACE is checked for applicability. ACEs that do not refer to the principal
   requesting the operation or any requested permission are ignored.

2. If the ACE denies any of the requested permissions, then access is denied and
   the algorithm terminates.

3. If the ACE allows any of the requested permissions, then they are added
   to the list of granted permissions. If the list includes all the requested
   permissions, the access is granted and the algorithm terminates.

4. If the end of the ACL list is reached and permission has neither been
   fully granted nor explicitly denied, access is denied and the algorithm
   terminates.

### POSIX permissions

Onedata implements traditional POSIX permissions typical for Unix or Linux
systems for specifying access rights to files or directories.
However, all space members are treated as a virtual group which is
the **group** owner of all files in the space. This means that whenever a file
is accessed by a space member who is not the owner of the file, the **group**
permissions are taken into consideration. Permissions for **others** are
considered when a [public share](shares.md) is accessed (as an anonymous
**guest**). These differences stem from the fact that unlike on POSIX systems,
there is an additional layer of access control imposed by membership in
[spaces](spaces.md) (which are completely separated logical data containers),
and the concepts of POSIX **group** and Onedata [group](groups.md) are
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

* files: `r-x r-x r--` (octal: `664`)
* directories: `rwx rwx r-x` (octal: `775`)

You can change permissions using the [Web file browser](web-file-browser.md) in
the **Permissions** tab in **File Details modal**, or using the
[REST API](https://onedata.org/#/home/api/stable/oneprovider?anchor=operation/set_attr).

Oneprovider admins should keep in mind that the
[Local User Mapping Database](../admin-guide/oneprovider/configuration/luma.md)
must be properly set up for each storage supporting a space. This is required so
that file permissions are accurately enforced in the space and the permissions in
Onedata are correctly mapped onto and from actual permissions on the storage,
especially concerning the above-mentioned **group** and **others** semantics.

## File distribution

[Replication and migration](replication-and-migration.md)
