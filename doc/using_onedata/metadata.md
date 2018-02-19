# Metadata

<!-- toc -->

Onedata comes with extensive support for metadata management, which can be used to describe all kinds of resources in Onedata including files, folders, spaces and users.

## Metadata types in Onedata
Metadata in Onedata are organized into 3 levels:

* **Filesystem attributes** - basic metadata related to file system operations such as file size, creation and modification timestamps, POSIX access rights, etc.,
* **Extended attributes** - these attributes enable assigning custom key-value pairs with resources in Onedata. These attributes can include for instance information about owner and creators of the file, Access Control Lists, license, etc.,
* **Custom metadata** - this level provides most flexibility and Onedata itself does not assume any schema related with these metadata. For each resource, user can assign a separate document in one of supported metadata formats (currently JSON and RDF).

The filesystem and extended level attributes are accessible directly via POSIX and CDMI protocols.

## Filesystem attributes

This section describes typical filesystem metadata attributes. The list of attributes at this level is closed (i.e. users cannot add new attributes) and most of them are read-only, which means their values cannot be directly modified (`cdmi_` attributes). Other attributes (currently only `posix_mode`) can be modified by the user using the REST API.

| Attribute            | Sample value                             | Description                              |
| -------------------- | ---------------------------------------- | ---------------------------------------- |
| **size**             | 1024                                     | File size in bytes                       |
| **mode**             | 0666                                     | POSIX access mode in octal form (i.e. 4 digits starting with 0) |
| **ctime**            | 1470304148                               | Unix creation timestamp                  |
| **mtime**            | 1470304148                               | Unix last modification timestamp         |
| **atime**            | 1470304148                               | Unix last access timestamp               |
| **storage_group_id** | 1470304148                               | Gid of the storage group owner of this file (the same Gid is displayed via `oneclient`) |
| **storage_user_id**  | 1470304148                               | Uid of the storage owner of this file    |
| **name**             | file.txt                                 | The name of the object (Space, folder or file) |
| **owner_id**         | 79c0ed35-f32e-4db3-a87f-76a588c9b2f9     | ID of the file owner                     |
| **shares**           | ["b3-a87f-76a588c9b279c0ed35-f32e-4db", ...] | Array of share Id's associated with this file or folder |
| **type**             | 'reg'                                    | Specifies whether the reource is a regular file (`reg`), a directory (`dir`) or a link (`lnk`) |


## Extended attributes

In a general case, extended attributes are platform agnostic and users can choose whatever keys and values to be assigned for these level attributes.


One restriction is that all keys, beginning with `onedata_` prefix, should be avoided as they are used by Onedata platform for special purposes, in particular for presentation in Graphical User Interface and Open Data publishing and management.

### Setting extended attributes using Graphical User Interface

Graphical user interface provides means for editing extended attributes in the form of a key-value pairs, as presented in the figure below.

<img  style="display:block;margin:0 auto;" src="../img/edit_metadata_extended.png">

The extended metadata values can be assigned to either files or folders.

### Setting extended attributes using REST API

Extended attributes can be modified either from the Graphical User Interface, from the command line as well as via the REST API. Below are some examples:

**Set file creators list using REST API**
```bash
curl --tlsv1.2 -X PUT -H "X-Auth-Token: $TOKEN" \
-H 'Content-type: application/json' -d '{ "license": "CC-0" }'
"https://$HOST/api/v3/oneprovider/attributes/MySpace1/File2.txt?extended=true"
```

**List all extended attributes using REST API**
```bash
curl --tlsv1.2 -X GET -H "X-Auth-Token: $TOKEN" \
"https://$HOST/api/v3/oneprovider/attributes/MySpace1/File2.txt?extended=true"
```

### Setting extended attributes using command line

Oneclient mounted spaces have support for extended attribute (xattr) feature, which can be accessed and manipulating using such tools as `xattr` or `getfattr` and `setfattr`. For instance to set an attribute on a file:

```sh
[/mnt/oneclient/MySpace1]$ ls
File2.txt

[/mnt/oneclient/MySpace1]$ xattr -l File2.txt
license

[/mnt/oneclient/MySpace1]$ xattr -p license File2.txt
CC-0
```

## Custom metadata

In addition to filesystem level and extended attributes, Onedata supports arbitrary metadata documents to be assigned to each resource, which are stored in separate metadata backends supported. Currently supported backends include:
* JSON
* RDF

<img  style="display:block;margin:0 auto;" src="../img/edit_metadata_json.png">

In each of these backends, user can store any properly formatted metadata
documents, which can be modified and retrieved using the
[REST API](../advanced/rest/oneprovider/operations/get_file_metadata.md)
or in the future in the Graphical User Interface.

## Advanced metadata queries

Onedata supports creation of custom indexing functions over the metadata,
which enable efficient querying for files.

Currently indexes work within the scope of a single space. Indexes can operate
on both extended attributes as well as JSON metadata - RDF metadata backend
indexing is not yet supported.

In order to create an index, it is necessary to write a simple Javascript
function, which accepts as a single argument the metadata document related
to each object in a space and returns the value which should be indexed.

The example below presents a simple function which creates an index over a
`license` extended attribute.

```javascript
function(meta) {
    if(meta['license']) {
        return meta['license'];
    }
    return null;
}
```

It is possible to create custom indexes, based on multiple attribute fields, e.g.:

```javascript
function(meta) {
    if(meta['license'] && meta['year']) {
        return [meta['license'], meta['year']];
    }
    return null;
}
```

In order to register this index in the space, the following REST API call has
to be made:

```bash
curl --tlsv1.2 -X POST -H "X-Auth-Token: $TOKEN" \
-H 'Content-type: application/javascript' -d @license_index.js \
"https://$HOST/api/v3/oneprovider/index?space_id=$SPACE_ID&name=license_index"
```

This call returns the ID of the newly created index in the response `Location`
header.

The space ID required for this call can be obtained from Onezone as follows:

```bash
curl --tlsv1.2 -X GET -H "X-Auth-Token: $TOKEN" \
"https://$HOST/api/v3/onezone/user/spaces"
```

Once the index is created, it can be easily queried using the REST API:
```bash
curl -v -k --tlsv1.2 -Ss -H "X-Auth-Token: $TOKEN" \
-X GET "https://$HOST/api/v3/oneprovider/query-index/$INDEX_ID?key=\"CC-0\"&stale=false"
```

### JSON metadata
In order to create indexes over user JSON metadata, the functions attribute path
must start from `onedata_json` key, which is a special attribute which provides
access to user-defined JSON document attached to a resource, e.g.:

```javascript
function(meta) {
    if(meta['onedata_json']['title']) {
        return meta['onedata_json']['title'];
    }
    return null;
}
```

More information on writing index functions can be found in the official Couchbase [documentation](http://developer.couchbase.com/documentation/server/4.5/indexes/querying-using-map-reduce-views.html).
