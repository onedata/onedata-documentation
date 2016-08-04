# Metadata

Onedata comes with extensive support for metadata management, which can be used to describe all kinds of resources in Onedata including files, folders, spaces and users.

## Metadata types in Onedata
Metadata in Onedata are organized into 3 levels:

* **Filesystem attributes** - basic metadata related to file system operation such as file size, creation and modification timestamps, POSIX access rights, etc.,
* **Extended attributes** - these attributes enable assigning custom key-value pairs with resources in Onedata. These attributes can include for instance information about owner and creators of the file, Access Control Lists, license, etc.,
* **User metadata** - this level provides most flexibility and Onedata itself does not assume any schema related with these metadata. For each resource, user can assign a separate document in one of supported formats (currently JSON and RDF).

The filesystem and extended level attributes are accessible directly via POSIX and CDMI protocols. 

On a Unix operating system, the extended attributes can be accessed and manipulated for instance using the `xattr` command line tool ().

## Filesystem attributes

This section describes typical filesystem metadata attributes. The list of attributes at this level is closed (i.e. users cannot add new attributes) and most of them are read-only, which means their values cannot be directly modified (`cdmi_` attributes). Other attributes (currently only `posix_mode`) can be modified by the user using the REST API.

|--------------------|------------------|------------------------|
| Attribute          | Description |  
|--------------------|------------------------|
| **cdmi_ctime** | 1470304148 | Unix creation timestamp |
| **cdmi_mtime** | 1470304148 | Unix last modification timestamp |
| **cdmi_atime** | 1470304148 | Unix last access timestamp |
| **cdmi_atime** | 1470304148 | Unix last access timestamp |
| **cdmi_size** | 1024 | File size in bytes |
| **cdmi_owner** | 79c0ed35-f32e-4db3-a87f-76a588c9b2f9 | ID of the file owner |
| **cdmi_acl** |  | Fine grained access control list for resource |
| **posix_mode**  | 0777 | POSIX access mode in octal form (i.e. 4 digits starting with 0) |
|--------------------|-------------------------|------------------------|


## Extended attributes

In a general case, extended attributes are platform agnostic and users can choose whatever keys and values to be assigned for these level attributes.
One restriction is that all keys, beginning with `x-onedata-` prefix, should be avoided as they are used by Onedata platform for special purposes, in particular for presentation in Graphical User Interface and Open Data publishing and management.

All the attributes prefixed with `x-onedata-` are optional, however when publishing a data set certain of these keys will be required, depending on the selected registration service (e.g. DataCite, OpenAIRE, etc.).

Table below contains current Onedata extended attributes and their purpose:
|--------------------|--------------------|------------------------|
| Extended attribute  | Sample value | Description |
|--------------------|------------------------|
| **x-onedata-doi**  | 10.572/test.txt | [DOI](https://www.doi.org/) identifier |
| **x-onedata-pid**  | 10916/Hello_World | EPIC [PID](http://www.pidconsortium.eu/) identifier |
| **x-onedata-license**  | CC-0 | License associated with the file, folder or space |
| **x-onedata-title**  | Image of Balaenoptera Acutorostrata  | User assigned title of resource |
| **x-onedata-subtitle**  | Minke Whale | User assigned subtitle of resource |
| **x-onedata-mimetype**  | application/xml+rdf | Mime-type of file |
| **x-onedata-version**  | 3.1.1 | User defined version of the resource |
| **x-onedata-creators**  | [{"firstName": "John", "lastName": "Doe", }]| JSON formatted list of creators which should be attributed with the resource |
| **x-onedata-bbox-east**  | 10.12341 | East-most coordinate of the geospatial bounding box|
| **x-onedata-bbox-west** | 10.12341 | West-most coordinate of the geospatial bounding box|
| **x-onedata-bbox-south** | 10.12341 | Soth-most coordinate of the geospatial bounding box|
| **x-onedata-bbox-north** | 10.12341 | Soth-most coordinate of the geospatial bounding box|
| **x-onedata-geo-point** |  -10.123,10.123 | Geospatial coordinate related to the resource |
| **x-onedata-woeid** |    502075 | Where On Earth IDentifier of the geospatial location |
|--------------------|-------------------------|------------------------|

### Setting extended attributes

Extended attributes can be modified either from the Graphical User Interface, from the command line as well as via the REST API. Below are some examples:

**Set file mimetype from command line**
```bash
xattr -w x-onedata-mimetype "application/json" ./my_file.txt
```

**Remove WOEID from command line**
```bash
xattr -d x-onedata-mimetype "application/json" ./my_file.txt
```

**Set file creators list using REST API**
```bash
curl --tlsv1.2 -X PUT -H "X-Auth-Token: $TOKEN" \
-H 'Content-type: application/json' -d '{ "name": "x-onedata-creators", "value": "[{\"firstName\": \"John\", \"lastName\": \"Doe\"}, {\"firstName\": \"Jane\", \"lastName\": \"Doe\"}]}'
"https://$HOST:8443/api/v3/oneprovider/attributes/MySpace1/File2.txt?extended=true"
```



