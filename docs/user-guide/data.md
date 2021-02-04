# Data
<!-- This file is referenced at least one time as "data.md" -->

[[toc]]

The Onedata system organizes all user data into logical containers called spaces. 
Please refer to [this](spaces.md) chapter for details about this concept and how 
the logical files are mapped to their physical content on storage backends.
 
 
## File path and ID
<!-- This header is referenced at least one time as "#file-path-and-id" -->

Files and directories in Onedata can be globally identified using unique file 
IDs or logical paths. Whenever possible, it is recommended to use File IDs, 
due to better performance and no need for escaping or encoding.

### File path
<!-- This header is referenced at least one time as "#file-paths" -->

All logical paths in Onedata use the slash `/` delimiter and must start with a
space name:
```
/CMS 1/file.txt
/MyExperiment/directory/subdirectory/image.jpg
```

The path-based navigation is used mainly in the Web GUI and Oneclient interfaces.

[Web GUI](#web-gui) - the path is represented in the file browser's breadcrumbs.  
![image](../../images/user-guide/data/file-gui.png)

[Oneclient](#oneclient) - please remember that some characters in paths should be properly escaped.
```
cat /CMS\ 1/file.txt
```        

[REST](#rest-api) or [CDMI](#cdmi) API - referencing by path should be avoided, 
otherwise make sure to urlencode the path if its the part of an URL:
```
{...}/CMS%201/file.txt
```        

>**NOTE:** Duplicate space names are generally allowed. For that reason, 
referencing files by path may be ambiguous. During file path resolution, the 
first space whose name matches the first segment of the path is always taken, 
but the order in which spaces are checked cannot be guaranteed.


### File ID
<!-- This header is referenced at least one time as "#file-id" -->

File ID is a unique, global identifier associated with a file or directory and
can be used universally in the [REST](#rest-api) and [CDMI](#cdmi) APIs.
There are several ways to find out the File ID of given file or directory:

[Web GUI](#web-gui) - click on **Information** in the file/directory context menu and look 
for `File ID`
![image](../../images/user-guide/data/file-information-gui.png)

[REST API](#rest-api) - use the File ID 
[resolution endpoint](https://onedata.org/#/home/api/stable/oneprovider?anchor=operation/lookup_file_id). 
Below example returns the File ID of <br />`/CMS 1/file.txt`, where `CMS 1` is the space name 
(consult [file path](#file-path)):
```bash
curl -H "X-Auth-Token: ${ACCESS_TOKEN}" \
-X POST "https://${ONEPROVIDER_DOMAIN}/api/v3/oneprovider/lookup-file-id/CMS%201/file.txt"
```
```json 
{
    "fileId": "094576776E667431723230677767776C6B497031394E445F6E3868677873..."
}
```
>**NOTE:** Make sure to urlencode the path if used in URL, as in above example.

>**NOTE:** See [below](#oneprovider-domain) to learn how to obtain the Oneprovider domain.

[Oneclient](#oneclient) - check [file extended attributes](oneclient.md#file-extended-attributes) and look for 
`org.onedata.file_id` attribute:
```bash
xattr -l file.txt 
```
```bash
org.onedata.file_id: 094576776E667431723230677767776C6B497031394E445F6E3868677873...
...
``` 


## Interfaces
Onedata offers several ways of accessing and managing user data. Regardless of 
the interface, the user is presented with a coherent view on all his files. All
data management interfaces are available in the [Oneprovider service](../intro.md#architecture).
Please note that depending on the environment, there might be several 
Oneprovider services [supporting user spaces](spaces.md#space-support) that can
be used to access the data. While the [Web GUI](#web-gui) offers natural navigation
between services, the other interfaces require that the user must choose one of 
his Oneproviders and be aware of its domain (see below).

### Oneprovider domain
<!-- This header is referenced at least one time as "#oneprovider-domain" -->
<!-- TODO VFS-7218 this should be moved somewhere else - maybe a new chapter with providers GUI
     from the user's point of view? -->

Oneprovider's domain is required to mount a [Oneclient](#oneclient) instance or
utilize the [REST](#rest-api) and [CDMI](#cdmi) APIs. It can be easily found in the Web GUI. 
Use the blue button to copy to clipboard:
![image](../../images/user-guide/data/provider-domain.png)

### Oneclient
Oneclient is a command-line based application used for mounting Onedata spaces
in the local file system tree. To that end, Oneclient requires a network 
connection to chosen Oneprovider instance. Please refer to [this](oneclient.md) 
chapter for information on its setup and usage.

### REST API
Oneprovider service offers a comprehensive REST API for data management. All
endpoints use [File IDs](#file-id) to identify files and directories. The documentation
based on OpenAPI (a.k.a. Swagger) can be found [here](https://onedata.org/#/home/api/stable/oneprovider).
For general information on using the REST APIs in Onedata, see [this](rest-api.md) chapter.

### CDMI
Oneprovider implements a subset of **Cloud Data Management Interface**
specification - please refer to [this](cdmi.md) chapter for more information.

### Web GUI
The most end-user friendly method of data management. Please refer to the
[Web file browser](web-file-browser.md) chapter for a visual guide.


## File permissions
Access to each file or directory can be controlled using traditional (POSIX) 
file permissions and Access Control Lists.

>**NOTE:** Each space can have one or more [space owners](spaces.md#space-owner),
who have full administrative power in the space and unrestricted access to data,
overriding the permissions and ACLs.


### POSIX permissions
<!-- This header is referenced at least one time as "#posix-permissions" -->

Onedata implements traditional POSIX permissions typical for Unix or Linux
systems for specifying access rights to files or directories. However, there
is one important nuance - all space members are treated as a virtual group which
is the **group** owner of all files in the space. This means that whenever a 
file is accessed by a space member who is not the owner of the file, the 
**group** permissions are taken into consideration. Permissions for **others** 
are considered when a public [share](shares.md) is accessed (as an anonymous 
guest). These differences stem from the fact that unlike on POSIX systems, there
is an additional layer of access control imposed by membership in 
[spaces](spaces.md) (which are completely separated logical data containers), 
and the concepts of POSIX **group** and Onedata [group](groups.md) are different. 

Examine the following example of file POSIX permissions:

    rwx r-- ---
     |   |   |
     |   |   guests
     |   |
     |   space members
     |
     owner user
     
In the above case, the creator of the file (its **owner** user) has full access 
to the file. All space members have read access to the file. Users (guests) who 
try to access the file through a public share will fail to do so as all 
permissions are declined for **others**.

>**NOTE:** regardless of the granted write permissions, all write operations are 
disallowed for guests that access the data through the public share. 

Default permissions (for newly created files/directories) are as follows:
* files: `r-x r-x r--` (octal: `664`)
* directories: `rwx rwx r-x` (octal: `775`)

Permissions can be changed using the [Web file browser](web-file-browser.md) in
the **Permissions** context menu, or using the 
[REST API](https://onedata.org/#/home/api/stable/oneprovider?anchor=operation/set_attr).

Oneprovider admins should keep in mind that the 
[Local User Mapping Database](../admin-guide/oneprovider/configuration/luma.md)
must be properly set up for each storage supporting a space. This is required so 
that file permissions are accurately enforced in the space and the permissions in 
Onedata are correctly mapped onto and from actual permissions on the storage,
especially concerning the above-mentioned **group** and **others** semantics.


### Access Control Lists
<!-- TODO VFS-7218 write me -->

## File distribution 
<!-- This header is referenced at least one time as "#file-distribution" -->

On the physical level, files in Onedata are divided into blocks of various sizes.
File blocks may be distributed among Oneproviders supporting space in which the file is stored.
List of file blocks present in Oneprovider is called a file replica. Onedata stores information about the mapping
between logical and physical files in the file metadata, which is replicated and synchronized between all supporting Oneproviders.

When a whole file or its part is read and some blocks are not present in the local Oneprovider,
missing blocks are replicated on demand from other Oneproviders. The process of replication is optimized
aiming to improve efficiency of file access on one hand and to decrease network traffic and Oneprovider's load as well as
space capacity usage on the other hand.

When a file is written in a given Oneprovider, overlapping blocks replicated to other Oneproviders are invalidated.   
In order to read the file, Oneprovider with invalidated blocks must once again replicate missing blocks from the
Oneprovider with the newest version of the blocks.

Simultaneous modifications of file may occur when many users access a certain file. In such case, if ranges of simultaneous modifications are not
overlapping, all modifications are safely applied. In case of a conflict, a conflict resolution algorithm is used which allows
all supporting providers to determine consistent, final version of the file. Conflict resolution is performed independently
by each provider without need to coordinate the resolution with other supporting Oneproviders which allows it to be fast. 


### Discovering file distribution
There are several ways to discover how the file blocks are distributed among providers supporting the space in which it is stored:

[Web GUI](#web-gui) - click on **Data distribution** in the file context menu:
![image](../../images/user-guide/data/file-distribution-gui.png) 

The following **Data distribution** modal, representing distribution of file blocks, will occur:
![image](../../images/user-guide/data/file-distribution-modal.png)

[REST API](#rest-api) - use [Get file distribution](https://onedata.org/#/home/api/stable/oneprovider?anchor=operation/get_file_distribution)
endpoint.
```bash
curl -H "X-Auth-Token: ${ACCESS_TOKEN}" \
 -X POST "https://${ONEPROVIDER_DOMAIN}/api/v3/oneprovider/data/$FILE_ID/distribution"
```
The distribution is returned in a JSON format:
```javascript 
[
  {
    "totalBlocksSize": 268435456,
    "providerId": "17d9da253bd54b480ec1f7ae2154aa25ch13c0",
    "blocks": [
      [
        1073741824, // block offset
        268435456   // block size
      ]
    ]
  },
  {
    "totalBlocksSize": 939524096,
    "providerId": "1d4f91163d67878b19c41e629aef9f59ch8429",
    "blocks": [
      [
        0,          // block offset
        268435456   // block size
      ],
      [
        402653184,  // block offset
        671088640   // block size
      ]
    ]
  },
  {
    "totalBlocksSize": 134217728,
    "providerId": "dac5b63b5b22a9c40c8ed41c1c6be27fchc8c0",
    "blocks": [
      [
        268435456,  // block offset
        134217728   // block size
      ]
    ]
  }
]
```

[Oneclient](#oneclient) - check [file extended attributes](oneclient.md#file-extended-attributes) and inspect 
`org.onedata.file_blocks`, `org.onedata.file_blocks_count` and `org.onedata.replication_progress` attributes:
```bash
xattr -l results.txt
``` 

```bash
org.onedata.file_blocks: [########################################.         ]
org.onedata.file_blocks_count: 1
org.onedata.replication_progress: 80% 
...
```
>**NOTE:** Please note that extended attributes presents only information about blocks of the file stored in
> Oneprovider to which the Oneclient is connected. In order to find information about replicas of the file
> in other providers Web GUI or REST API must be used.


### Distribution management

Advanced users who intend to achieve the best performance of data access must consciously manage distribution of the
files on which the computations are to be performed. Please remember that spaces have limited sizes of support
granted by the Oneproviders, which means that space capacity usage must also be taken into account.

The mechanisms which allow users and space admins to manage the data distribution are listed below:
1. [Data transfers](data-transfers.md) - allow users to intentionally replicate, evict and migrate file blocks
2. [Quality of Service](quality-of-service.md) - allows users to specify QoS requirements which may ensure that file
replicas in certain Oneproviders are automatically updated and protected from eviction 
3. [Auto-cleaning](../admin-guide/oneprovider/configuration/auto-cleaning.md) - automatically maintains storage usage at
a certain level and ensure that there is enough space for new replicas when performing continuous computations

>**NOTE:** Please note that Auto-cleaning can only be configured by a space admin.