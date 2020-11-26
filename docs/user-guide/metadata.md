# Metadata

[[toc]]

## Quickstart

See [GUI wizard](#gui-wizard) usage examples for the quick guide on how to set or 
obtain file/directory custom metadata.


## Basics

Metadata in Onedata are organized into 3 levels:

* **Filesystem attributes** - basic metadata related to file system operations 
such as file size, creation and modification timestamps, POSIX access rights, etc.
* **Extended attributes** - these attributes enable assigning custom key-value 
pairs with file/directory in Onedata. They are compatible with POSIX extended 
attributes and can include for instance information about the creator of the file, 
Access Control Lists, license, etc.
* **Custom metadata** - for each file/directory, user can assign a separate 
document in one of supported metadata formats (currently JSON and RDF). This level 
provides most flexibility and Onedata itself does not assume any schema related 
with this metadata.

The filesystem and extended level attributes are accessible directly via POSIX, 
CDMI and REST protocols. Custom metadata, on the other hand, is accessible 
directly only via REST and indirectly via POSIX and CDMI protocols (as extended 
attributes under special names of `onedata_json` and `onedata_rdf`).


## Filesystem attributes

Filesystem attributes are attributes set and modified automatically while performing 
various filesystem operations. Most of them are read-only, which means their values 
cannot be directly modified (with exception to posix mode). 
All such attributes are shown in table below.


Attribute           | Sample value                              | Description
--------------------|-------------------------------------------|-----------------------------------
name                | "file.txt"                                | The name of the object (Space, directory or file)
type                | "reg"                                     | Specifies whether the resource is a regular file (`reg`) or a directory (`dir`)
size                | 1024                                      | Size of the file in bytes
mode                | 0666                                      | POSIX access mode in octal form (i.e. 4 digits starting with 0)
atime               | 1470304148                                | Last access timestamp (in seconds)
mtime               | 1470304148                                | Last modification timestamp (in seconds)
ctime               | 1470304148                                | Last status change timestamp (in seconds)
storage_user_id     | 6001                                      | Uid of the storage owner of this file
storage_group_id    | 6001                                      | Gid of the storage group owner of this file (the same Gid is displayed via oneclient)
owner_id            | "6825604b0eb6a47b8b7a04b6369eb24d"        | ID of the file owner
provider_id         | "79c0ed35f32e43db3a87f76a588c9b2f"        | ID of the provider on which file was created
shares              | ["b3a87f76a588c9b279c0ed35f32e4db", ...]  | Array of share Id's associated with this file or directory

Some filesystem attributes are considered private and masked when accessing 
file in share mode. They are:
- storage_user_id - special value of `2147483646` is returned instead
- storage_group_id - special value of `2147483646` is returned instead
- owner_id - `unknown` will be returned instead
- provider_id - `unknown` will be returned instead
- mode - `owner` and `group` bits will be zeroed
- shares - only share used to access file will be shown in the array 
(the rest will be omitted)


## Extended attributes

In a general case, extended attributes are platform agnostic and users can choose 
whatever keys and values to be assigned for these level attributes. One restriction 
is that all keys beginning with `onedata_` or `cdmi_` prefixes are reserved as they 
are used by Onedata platform for special purposes, in particular for presentation 
in Graphical User Interface and Open Data publishing and management.


## Custom metadata

In addition to filesystem level and extended attributes, Onedata supports arbitrary 
metadata documents to be assigned to a file or directory. Currently supported 
formats include:
- JSON
- RDF


## GUI wizard
The easiest way to create, modify and browse metadata attached to files or directories 
is using the Web GUI metadata editor. 

In order to edit the metadata of a file or directory, simply select the **Metadata** 
from the file context menu.

![image](../../images/user-guide/metadata/set_file_metadata.png)

In the same way metadata can be edited for entire data space, but it has to be called 
from the space context menu.

![image](../../images/user-guide/metadata/set_space_metadata.png)

The metadata editor allows editing 3 types of metadata:
* **Basic** - simple [key-value pairs](#extended-attributes)
* **JSON** - a valid [JSON document](#custom-metadata)
* **RDF** - [RDF (Resource Description Framework) document](#custom-metadata)

### Basic metadata
Basic metadata is the simplest type of metadata where named keys are assigned 
a single value (which can be numeric or string).

![image](../../images/user-guide/metadata/set_file_xattrs.png)

This metadata can be later used to create complex indexes over the data collections, 
and can be accessed on the filesystem level using extended attribute mechanism 
(e.g. through `xattr` command line tool).

### JSON
JSON metadata can be edited in place or pasted into the editor, which performs 
live syntax validation.

![image](../../images/user-guide/metadata/set_file_json_metadata.png)

### RDF
RDF editor works similarly to the JSON editor, but accepts triples in the XML format.

![image](../../images/user-guide/metadata/set_file_rdf_metadata.png)


## Metadata management using Oneclient and OnedataFS

In an Oneclient mount, the metadata is exposed through the extended attributes 
mechanism, i.e. it can be accessed and modified using such tools as 
[xattr](https://github.com/xattr/xattr):


```bash
[/mnt/oneclient/Space1]$ ls
file.json

[/mnt/oneclient/Space1]$ xattr -l file.json
license: CC-0
org.onedata.uuid: Z3VpZCM1NzMwZjNjNjRjYmI0Y2M1MjllZjRlYWVhNDJkNDY4MyNmNzMzMzA1Zj
dhMGE4MWRjZTM5NjY2NzEzYTUxNmYwYg
org.onedata.space_id: f733305f7a0a81dce39666713a516f0b
org.onedata.file_id: /f733305f7a0a81dce39666713a516f0b/5/7/3/5730f3c64cbb4cc529e
f4eaea42d4683
org.onedata.storage_id: 55e4475e8dc60dc3ebd070f8dd424f24
org.onedata.access_type: direct
org.onedata.file_blocks: [##################################################]
org.onedata.file_blocks_count: 1
org.onedata.replication_progress: 100%

[/mnt/oneclient/Space1]$ xattr -w license CC-1 File2.txt
```

Please note that the extended attributes starting with `org.onedata.` prefix are 
Onedata system attributes and cannot be modified. They however provide useful 
information about files such as:

* `org.onedata.uuid` - the internal GUID of a file or directory in Onedata
* `org.onedata.space_id` - the ID of the space to which this file/directory belongs
* `org.onedata.file_id` - the storage file ID (e.g. a path on POSIX storage)
* `org.onedata.storage_id` - the storage ID on which this file is located
* `org.onedata.access_type` - type of access available for this file:
    * `direct` - it means that the client has direct access to the storage 
    (e.g. S3 bucket or Ceph pool), 
    * `proxy` - it means that the direct access is not available and all data read 
    and write requests will go through Oneprovider. 
    * `unknown` - it means the data access type has not been established yet 
    (it is done only on the first I/O operation on a storage from given mountpoint).
* `org.onedata.file_blocks` - the distribution of file blocks which are available 
on this storage for this file
* `org.onedata.file_blocks_count` - the number of file blocks which are available 
on this storage for this file
* `org.onedata.replication_progress` - the percentage of file blocks which are 
available on this storage for this file

Similarly to Oneclient, extended attributes and metadata can be accessed and modified 
from the OnedataFS Python interface:

```bash
from fs.onedatafs import OnedataFS
onedata_provider_host = "..."
onedata_access_token = "..."

# Create connection to Oneprovider
odfs = OnedataFS(onedata_provider_host, onedata_access_token)

# Open selected space directory
space = odfs.opendir('/Space1')

# List SpaceA contents
space.listdir('/')
['file.json']

# List extended attributes names for `file.json`
space.listxattr("file.json")
['license',
 'org.onedata.uuid',
 'org.onedata.space_id',
 'org.onedata.file_id',
 'org.onedata.access_type',
 'org.onedata.file_blocks_count',
 'org.onedata.file_blocks',
 'org.onedata.replication_progress',
 'org.onedata.storage_id']

space.getxattr("file.json", "org.onedata.space_id")
b'"f733305f7a0a81dce39666713a516f0b"'

space.setxattr("file.json", "license", '"MIT"')

space.removexattr("file.json", "license")
```

## Metadata management using REST
For reading filesystem attributes see 
[Basic File Operations API documentation](https://onedata.org/#/home/api/latest/oneprovider?anchor=tag/Basic-File-Operations).
As for extended attributes and custom metadata management please refer to 
[Custom File Metadata API documentation](https://onedata.org/#/home/api/latest/oneprovider?anchor=tag/Custom-File-Metadata).
