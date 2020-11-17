# Metadata

[[toc]]

## Quickstart

See [GUI wizard](#gui-wizard) usage examples for quick guide on how to set or obtain
file custom metadata.


## Basics

Metadata in Onedata are organized into 3 levels:

* **Filesystem attributes** - basic metadata related to file system operations such as file size, creation and modification timestamps, POSIX access rights, etc.,
* **Extended attributes** - these attributes enable assigning custom key-value pairs with resources in Onedata. They can include for instance information about owner and creators of the file, Access Control Lists, license, etc.,
* **Custom metadata** - this level provides most flexibility and Onedata itself does not assume any schema related with these metadata. For each file, user can assign a separate document in one of supported metadata formats (currently JSON and RDF).

The filesystem and extended level attributes are accessible directly via POSIX, CDMI and REST protocols.
Custom metadata, on the other hand, is accessible directly via REST and only indirectly via POSIX and CDMI protocols 
(as extended attributes under special names of `onedata_json` and `onedata_rdf`).


## Filesystem attributes

Filesystem attributes are attributes set and modified automatically while performing various filesystem operations. 
Most of them are read-only, which means their values cannot be directly modified (with exception to posix mode). 
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

Some of the filesystem attributes are considered private and masked when accessing file in share mode.
They are:
- storage_user_id - special value of `2147483646` is returned instead
- storage_group_id - special value of `2147483646` is returned instead
- owner_id - `unknown` will be returned instead
- provider_id - `unknown` will be returned instead
- mode - `owner` and `group` bits will be zeroed
- shares - only share used to access file will be shown in the array (the rest will be omitted)


## Extended attributes

In a general case, extended attributes are platform agnostic and users can choose whatever keys and values to be assigned for these level attributes.
One restriction is that all keys beginning with `onedata_` or `cdmi_` prefixes are reserved as they are used by Onedata platform for special purposes, 
in particular for presentation in Graphical User Interface and Open Data publishing and management.


## Custom metadata

In addition to filesystem level and extended attributes, Onedata supports arbitrary metadata documents to be assigned to a file or directory, 
which are stored in separate metadata backends. Currently supported backends include:
- JSON
- RDF


## GUI wizard
The easiest way to create, modify and browse metadata attached to files or directories is using the Web GUI metadata editor. 

In order to edit the metadata of a file or directory, simply select the **Metadata** from the file context menu:

![image](../../images/user-guide/metadata/set_file_metadata.png)

In the same way metadata can be edited for entire data space, but it has to be called from the space context menu.

![image](../../images/user-guide/metadata/set_space_metadata.png)

The metadata editor allows to edit 3 types of metadata:
* **Basic** - simple [key-value pairs](#extended-attributes)
* **JSON** - a valid [JSON document](#custom-metadata)
* **RDF** - [RDF (Resource Description Framework) document](#custom-metadata)

### Basic metadata
Basic metadata is the simplest type of metadata where named keys have assigned a single value (which can be numberic or string). Adding and modifying these key value
pairs can be done through the metadata editor easily:

![image](../../images/user-guide/metadata/set_file_xattrs.png)

These metadata can be later used to create complex indexes over the data collections, and can be accessed on the filesystem level using extended attribute mechanism (e.g. through `xattr` command line tool).

### JSON
JSON metadata can be also edited or pasted into the metadata editor, it will also be validated before it can be saved, to avoid storing invalid JSON documents. 

![image](../../images/user-guide/metadata/set_file_json_metadata.png)

### RDF
Finally also RDF triples in XML format can be added to a resource throgh the GUI:

![image](../../images/user-guide/metadata/set_file_rdf_metadata.png)


## Metadata management using Oneclient and OnedataFS

Metadata can also be accessed and managed using both Oneclient and OnedataFS.

In case of Oneclient, the metadata is exposed through the extended attributes mechanism, i.e. it can be accessed and modified using such tools as [xattr](https://github.com/xattr/xattr):


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

Please note that the extended attributes starting with `org.onedata.` prefix are Onedata system attributes and cannot be modified. They however provider useful information about files such as:

* `org.onedata.uuid` - the internal GUID of a file or directory in Onedata
* `org.onedata.space_id` - the ID of the space to which this resource belongs
* `org.onedata.file_id` - the storage file ID (e.g. a path on POSIX storage)
* `org.onedata.storage_id` - the storage ID on which this file is located
* `org.onedata.access_type` - type of access available for this file, if the value is `direct`, it means that the client has direct access to the storage (e.g. S3 bucket or Ceph pool), if the value is `proxy` it means that the direct access is not available and all data read and write requests will go through Oneprovider. In case the value is `unknown` it means the data access type has not been established yet (it is done only on the first I/O operation on a storage from given mountpoint).
* `org.onedata.file_blocks` - the distribution of file blocks, which are available on this storage for this file
* `org.onedata.file_blocks_count` - the number of file blocks, which are available on this storage for this file
* `org.onedata.replication_progress` - the percentage of file blocks, which are available on this storage for this file

Extended attributes and metadata can also be accessed and modified from the OnedataFS Python interface:

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
Metadata can also be managed using REST API. For reading filesystem attributes see 
[Basic File Operations API documentation](https://onedata.org/#/home/api/latest/oneprovider?anchor=tag/Basic-File-Operations).
As for extended attributes and custom metadata management please refer to 
[Custom File Metadata API documentation](https://onedata.org/#/home/api/latest/oneprovider?anchor=tag/Custom-File-Metadata).
