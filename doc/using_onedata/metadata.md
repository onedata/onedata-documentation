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

Onedata supports creation of custom view indexes on files metadata. They can be used for:
 * efficient querying for files
 * producing tables and lists of information based on files' metadata
 * extracting or filtering information from files' metadata
 * calculating, summarizing or reducing the information on the stored metadata  

Indexing mechanism processes documents stored in the database in order to create a view.
Documents are mapped using user-defined mapping function. Optionally, results of 
the mapping can also be reduced using a reduce function if it is provided by the user.
Internally, indexes are based on [Couchbase View Indexes](https://docs.couchbase.com/server/5.5/views/views-intro.html).
Please visit this site for more comprehensive explanation of concepts used among this documentation.  

There are two types of views that can be created:
* [map-reduce views](https://docs.couchbase.com/server/5.5/views/views-writing.html)
* [spatial views](https://docs.couchbase.com/server/5.5/views/sv-writing-views.html) - 
spatial views are similar to map-reduce views. They are supposed to be used for querying multi-dimensional data.
The main difference is that they don't have a reduce function

Currently, view indexes can be created on the following models:
 * `file_meta` - model used for storing filesystem attributes (except timestamps)
 * `times` - model used for storing filesystem timestamps
 * `custom_metadata` - model used for storing [extended attributes](#extended-attributes) and [custom metadata](#custom-metadata). 
    Currently, indexes can operate on both extended attributes as well as JSON metadata - RDF metadata backend
    indexing is not yet supported
 * `file_popularity` - model used for tracking the [file popularity](../administering_onedata/file_popularity.md)

### Concepts

#### Mapping function

All information presented in this section is relevant to both map-reduce and spatial views.
Function used by spatial views is called as a *spatial* in Couchbase documentation. For simplicity, in this documentation, 
the *mapping* name will be used for both terms, as they must comply to the same rules (with one exception, emphasised below).

In order to create an index, it is necessary to write a simple Javascript mapping
function. It will be used to map the data stored in the document to the value which should be indexed.
Mapping is performed by using `emit()` function. Each call to `emit()` results in a new row of data in the view result.
More info on mapping functions concepts can be found [here](https://docs.couchbase.com/server/5.5/views/views-writing-map.html).

In Onedata indexes API, the mapping function submitted by the user is wrapped by
additional Javascript code, in order to comply with Couchbase API.

The mapping function should accept 4 arguments:
 * id - CDMI object id of a file,
 * type - type of the document that is being mapped by the function. One of:
    * "file_meta"
    * "times"
    * "custom_metadata"
    * "file_popularity"
 * meta - values stored in the document being mapped,
 * ctx - context object used for storing helpful information. Currently it stores:
    * providerId,
    * spaceId.

The mapping function should return (key, value) pair or pairs that are to be emitted
 to the view via `emit()` function.

 If one document shall be mapped to exactly one row in the view, the mapping
 function should return 2-element list [key, value], where key and value can be any JS object.

 If one document shall be mapped to many rows in the view, the mapping
 function should return an object with the key `'list'`. The value should be
 a list of 2-element lists [key, value]. The `emit()` function will be called for
 each 2-element list in the top-level list. 

**NOTE:**
The mapping function defined for a spatial view must return key in a suitable format, described [here](https://docs.couchbase.com/server/5.5/views/sv-writing-views-keys.html).

Examples of the mapping function:
 * returning a single view row
    ```javascript
    function (id, type, meta, ctx) {
        var key = ...
        var value = ...
        return [key, value];
    }
    ```
 * returning multiple view rows
      ```javascript
      function (id, type, meta, ctx) {
          var key1 = ...
          var value1 = ...
          var key2 = ...
          var value2 = ...
          .
          .
          .
          var keyN = ...
          var valueN = ...

          return {'list': [
              [key1, value1],
              [key2, value2],
              .
              .
              .
              [keyN, valueN]
          ]};
      }
      ```

#### Reduce function (optional)

Reduce function is optional. It can be used only for map-reduce views.
Typical uses for a reduce function are to produce a summarized count of the 
input data, or to provide sum or other calculations on the input data.

Contrary to the mapping function, the reduce function is not wrapped by any 
additional Javascript code. It is passed as it is to the Couchbase and therefore all
information and notices presented [here](https://docs.couchbase.com/server/5.5/views/views-writing-reduce.html) 
are relevant. In particular: 
* the description of builtin reduce functions:
    * [`_count`](https://docs.couchbase.com/server/5.5/views/views-writing-count.html)
    * [`_sum`](https://docs.couchbase.com/server/5.5/views/views-writing-sum.html)
    * [`_stats`](https://docs.couchbase.com/server/5.5/views/views-writing-stats.html)
* the description of writing [custom reduce functions](https://docs.couchbase.com/server/5.5/views/views-writing-custom-reduce.html)

### REST API

All operations on indexes are listed in the below table, with links to comprehensive description of appropriate requests and their parameters. 

| Request                      | Link to API |
|------------------------------|-------------|
| Create index                 | [API](https://onedata.org/#/home/api/latest/oneprovider?anchor=operation/create_space_index)|        
| Get index                    | [API](https://onedata.org/#/home/api/latest/oneprovider?anchor=operation/get_space_index)|        
| Update index                 | [API](https://onedata.org/#/home/api/latest/oneprovider?anchor=operation/update_space_index)|        
| Remove index                 | [API](https://onedata.org/#/home/api/latest/oneprovider?anchor=operation/remove_space_index)|        
| Update index reduce function | [API](https://onedata.org/#/home/api/latest/oneprovider?anchor=operation/update_index_reduce_function)|        
| Remove index reduce function | [API](https://onedata.org/#/home/api/latest/oneprovider?anchor=operation/remove_index_reduce_function)|        
| List indexes                 | [API](https://onedata.org/#/home/api/latest/oneprovider?anchor=operation/get_space_indexes)|        
| Query index                  | [API](https://onedata.org/#/home/api/latest/oneprovider?anchor=operation/query_space_index)|        


### Example

The example below presents a simple function which creates an index over a
`license` extended attribute.

```javascript
function (id, type, meta, ctx) {
    if(type === "custom_metadata"){
        if(meta['license']) {
            return [meta['license'], id];
        }
    }
}
```

It is possible to create custom indexes, based on multiple attribute fields, e.g.:

```javascript
function(id, type, meta, ctx) {
    if(type === "custom_metadata"){
        if(meta['license'] && meta['year']) {
            return [[meta['license'], meta['year']], id];
        }
    }
}
```

In order to register this index in the space, the following REST API call has
to be made:

```bash
curl --tlsv1.2 -X POST -H "X-Auth-Token: $TOKEN" \
-H 'Content-type: application/javascript' -d @license_index.js \
"https://$HOST/api/v3/oneprovider/spaces/$SPACE_ID/indexes/$INDEX_NAME"
```

Once the index is created, it can be easily queried using the REST API:
```bash
curl -v -k --tlsv1.2 -Ss -H "X-Auth-Token: $TOKEN" \
-X GET "https://$HOST/api/v3/oneprovider/spaces/$SPACE_ID/indexes/$INDEX_ID/query/?key=\"CC-0\"&stale=false"
```

#### JSON metadata
In order to create indexes over user JSON metadata, the functions attribute path
must start from `onedata_json` key, which is a special attribute which provides
access to user-defined JSON document attached to a resource, e.g.:

```javascript
function(id, type, meta, ctx) {
    if (type === "custom_metadata"){
        if(meta['onedata_json']['title']) {
            return [meta['onedata_json']['title'], id];
        }
    }
}
```