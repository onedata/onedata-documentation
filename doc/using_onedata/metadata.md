# Metadata

Onedata comes with extensive support for metadata management, which can be used to describe all kinds of resources in Onedata including files, folders, spaces and users.

## Metadata types in Onedata
Metadata in Onedata are organized into 3 levels:

* **Filesystem attributes** - basic metadata related to file system operations such as file size, creation and modification timestamps, POSIX access rights, etc.,
* **Extended attributes** - these attributes enable assigning custom key-value pairs with resources in Onedata. These attributes can include for instance information about owner and creators of the file, Access Control Lists, license, etc.,
* **User metadata** - this level provides most flexibility and Onedata itself does not assume any schema related with these metadata. For each resource, user can assign a separate document in one of supported metadata formats (currently JSON and RDF).

The filesystem and extended level attributes are accessible directly via POSIX and CDMI protocols. 

On a Unix operating system, the extended attributes can be accessed and manipulated for instance using the `xattr` command line tool (https://en.wikipedia.org/wiki/Extended_file_attributes).

## Filesystem attributes

This section describes typical filesystem metadata attributes. The list of attributes at this level is closed (i.e. users cannot add new attributes) and most of them are read-only, which means their values cannot be directly modified (`cdmi_` attributes). Other attributes (currently only `posix_mode`) can be modified by the user using the REST API.

| Attribute          | Sample value | Description |  
| -------------------- | ------------------- | ---------- |
| **cdmi_ctime** | 1470304148 | Unix creation timestamp |
| **cdmi_mtime** | 1470304148 | Unix last modification timestamp |
| **cdmi_atime** | 1470304148 | Unix last access timestamp |
| **cdmi_atime** | 1470304148 | Unix last access timestamp |
| **cdmi_size** | 1024 | File size in bytes |
| **cdmi_owner** | 79c0ed35-f32e-4db3-a87f-76a588c9b2f9 | ID of the file owner |
| **cdmi_acl** |  | Fine grained access control list for resource |
| **posix_mode**  | 0777 | POSIX access mode in octal form (i.e. 4 digits starting with 0) |


## Extended attributes

In a general case, extended attributes are platform agnostic and users can choose whatever keys and values to be assigned for these level attributes.


One restriction is that all keys, beginning with `onedata_` prefix, should be avoided as they are used by Onedata platform for special purposes, in particular for presentation in Graphical User Interface and Open Data publishing and management.


### Setting extended attributes

Extended attributes can be modified either from the Graphical User Interface, from the command line as well as via the REST API. Below are some examples:

**Set file creators list using REST API**
```bash
curl --tlsv1.2 -X PUT -H "X-Auth-Token: $TOKEN" \
-H 'Content-type: application/json' -d '{ "name": "x-onedata-creators", "value": "[{\"firstName\": \"John\", \"lastName\": \"Doe\"}, {\"firstName\": \"Jane\", \"lastName\": \"Doe\"}]}'
"https://$HOST:8443/api/v3/oneprovider/attributes/MySpace1/File2.txt?extended=true"
```

**List all extended attributes using REST API**
```bash
curl --tlsv1.2 -X GET -H "X-Auth-Token: $TOKEN" \
"https://$HOST:8443/api/v3/oneprovider/attributes/MySpace1/File2.txt?extended=true"
```


## User metadata

In addition to filesystem level and extended attributes, Onedata supports arbitrary metadata documents to be assigned to each resource, which are stored in separate metadata backends supported. Currently supported backends include:
* JSON
* RDF

In each of these backends, user can store any properly formatted metadaate documents, which can be modified and retrieved using the [REST API](../../advanced/rest/oneprovider/overview.md) or in the future in the Graphical User Interface.

