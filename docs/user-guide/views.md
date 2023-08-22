# Views

[toc][1]

Onedata supports creation of custom database views for indexing file metadata. They can be used for:

* efficient querying for files
* producing tables and lists of information based on file metadata
* extracting or filtering information from file metadata
* calculating, summarizing or reducing the information from file metadata

Views are a result of continuous indexing of documents.
Documents are mapped using a user-defined mapping function. Optionally, results of
the mapping can also be reduced using a reduce function if it is provided by the user.
Internally, views are based on [Couchbase Views][2].
Please visit this site for more detailed explanation of concepts used within this documentation.

There are two types of views that can be created:

* [map-reduce views][3] — a perspective on the data stored
  in a database in a format that can be used to represent the data in a specific way, define and filter the information,
  and provide a basis for searching or querying the data in the database based on the content.
* [spatial views][4] —
  spatial views are similar to map-reduce views. They are suited for querying multi-dimensional data.
  The main difference is that they don't have a reduce function.

Currently, views can be created on the following models storing file metadata:

* [`file_meta`][5]
* [`times`][6]
* [`custom_metadata`][7]
* [`file_popularity`][8]

## Concepts

### Mapping function

All information presented in this chapter is relevant to both map-reduce and spatial views.
Function used by spatial views is called as a *spatial* in Couchbase documentation. For simplicity, in this documentation,
the *mapping* name is used for both terms, as they must comply with the same rules (with one exception, emphasised below).

In order to create a view, it is necessary to provide a mapping function in JavaScript.
It is used to map the data stored in a document to the value which should be indexed.
Mapping is performed using `emit()` function. Each call to `emit()` results in a new row of data in the view result.
More information on mapping functions can be found [here][9].

In the *views* API, the mapping function submitted by the user is wrapped inside
additional Javascript code, in order to comply with Couchbase API.

The mapping function must accept 4 arguments:

* `id` — ID of the file (string)
* `type` — type of the document that is being mapped by the function, one of:
  * `"file_meta"`
  * `"times"`
  * `"custom_metadata"`
  * `"file_popularity"`
* `meta` — values stored in the document being mapped (formats are described [further on][10])
* `ctx` — additional information that might be helpful during indexing:
  * `providerId`
  * `spaceId`

```javascript 1.8
ctx = {
    "providerId": "b705b0f664645a2c69934d9043b33c2207228257",
    "spaceId": "86b1daff220b40c235e6af1c235769a4ec4fe91a"
}

```

> **NOTE:** The mapping function will be called for each file-related document (as listed in the `type` argument above).
> For example, `emit()` will be called separately for **the same file** when its name changes (`file_meta`),
> its content is modified (`times`) and an extended attributes is set (`custom_metadata`).
> It is important to consider the type of the indexed document to avoid duplicate mappings.

The mapping function must return `(key, value)` pair or pairs that are to be emitted
to the view via `emit()` function.

If one document shall be mapped to exactly one row in the view, the mapping
function must return a 2-element list `[key, value]`, where key and value can be any JS term.

If one document shall be mapped to many rows in the view, the mapping
function must return an object with the key `'list'`. The value must be
a list of 2-element lists `[key, value]`. The `emit()` function is called for
each 2-element list in the top-level list.

Valid formats of the mapping function are presented below. `key` and `value` can be any valid JSON objects:

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

A few examples of the mapping function are presented [here][11].

#### Spatial view key format

The mapping function defined for a spatial view must return the key as a multidimensional bounding box.
There are 3 accepted ways of defining a key in a spatial function:

* single values — list of numerical values, which is expanded to a collapsed range.
  For example, list `[1.0, 2, 3.5]` is internally expanded to  list of ranges `[[1.0, 1.0], [2 , 2], [3.5, 3.5]]`
* ranges — list of ranges. For example:  `[[1.0, 2.0], [100, 1000]]`
* GeoJSON geometry — the following GeoJSON objects are supported:
  * Point
  * MultiPoint
  * LineString
  * MultiLineString
  * MultiPolygon
  * GeometryCollection

Above formats of defining keys might be combined. The only constraint is that GeoJSON object must be the first element of the list.
Defining spatial view keys is thoroughly described [here][12].

### Reduce function (optional)

Reduce function is optional. It can be used only for map-reduce views.
Typical uses for a reduce function are to produce a summarized count of the
input data, or to provide sum or other calculations on the input data.

Contrary to the mapping function, the reduce function is not wrapped by any
additional Javascript code. It is passed as it is to the Couchbase and therefore all
information and notices presented [here][13]
are relevant, in particular:

* built-in reduce functions:
  * [`_count`][14]
  * [`_sum`][15]
  * [`_stats`][16]
* writing [custom reduce functions][17]

## Indexable metadata models

### File meta model

Indexed by the `emit(id, type, meta, ctx)` function where `type === "file_meta"`.

Model that stores basic file metadata:

* `name` — name of the file
* `type` — type of the file. One of: regular file (`REG`), directory (`DIR`)
* `mode` — POSIX access mode as a decimal integer
* `acl` — [access control list][18]
* `owner` — ID of an owner of the file
* `provider_id` – ID of a provider on which the file was created
* `deleted` – flag informing that file was marked to be deleted
* other fields that are hardly useful in views: `shares`, `is_scope`, `parent_uuid`

```javascript 1.8
file_meta = {
   "name": "results.txt",
   "type": "REG",
   "mode": 436, // "0664" in octal
   "acl": [{
       "acetype": 0,
       "aceflags": 0,
       "identifier": "bd3ae5725fd0348d8fbd97beafd5d3d1f23e1fb6",
       "name": "OWNER@",
       "acemask": 0
   }],
   "owner": "191417070ff9f0ad36d99065c9034b23d1ca799e",
   "provider_id": "bbdeee4b71842378f7834a12ddf04b68dd61d1c1",
   "deleted": false
}
```

### Times model

Indexed by the `emit(id, type, meta, ctx)` function where `type === "times"`.

This model was extracted from the `file_meta` due to efficiency reasons.
It stores classical Unix timestamps (in seconds since Epoch):

* `atime` – Unix last access timestamp
* `mtime` – Unix last modification timestamp
* `ctime` – Unix last status timestamp

```javascript 1.8
times = {
   "atime": 1582374672,
   "mtime": 1582374672,
   "ctime": 1582374672
}
```

### Custom metadata model

Indexed by the `emit(id, type, meta, ctx)` function where `type === "custom_metadata"`.

Model used for storing [extended attributes][19] and [custom metadata][20].
Currently, views can operate on both extended attributes as well as JSON metadata, RDF metadata backend
indexing is not yet supported.
The model has the following fields:

* `onedata_json` – map of JSON metadata values
* `onedata_rdf` – RDF metadata in plain text
* extended attributes set by users – a key-value map on the top level of the object

```javascript 1.8
custom_metadata = {
   "onedata_json": {
       "country": "FR",
       "year": 2020 
   },
   "onedata_rdf": "<?xml version=\"1.0\"?>\n\n<rdf:RDF\nxmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\"\nxmlns:si=\"https://www.w3schools.com/rdf/\">\n\n<rdf:Description rdf:about=\"https://www.w3schools.com\">\n  <si:title>W3Schools</si:title>\n  <si:author>Jan Egil Refsnes</si:author>\n</rdf:Description>\n\n</rdf:RDF>",
   "colour": "red",
   "licence": "MIT"
}
```

### File popularity model

Indexed by the `emit(id, type, meta, ctx)` function where `type === "file_popularity"`.

Model used for tracking [*file popularity*][21].
These documents are available only if collecting *file popularity* statistics is
[enabled in the given space][21] by a Oneprovider admin.
It can be turned on only by space admin via Onepanel.
The *file popularity* document is available only for files which have been opened at least once on a given provider.\
It stores:

* `size` – total sum of the file's blocks stored on given provider
* `open_count` – number of `open` operations on the file
* `last_open` – timestamp fo last `open` on the file
* `hr_hist`  – hourly histogram of number of `open` operations on the file per hour, in the last 24 hours, represented as
  a list of 24 integers
* `dy_hist`  – daily histogram of number of `open` operations on the file per day, in the last 30 days, represented as
  a list of 30 integers
* `mth_hist` – monthly histogram of number of `open` operations on the file per month, in the last 12 months, represented as
  a list of 12 integers
* `hr_mov_avg` – moving average of number of `open` operations on the file per hour
* `dy_mov_avg` – moving average of number of `open` operations on the file per day
* `mth_mov_avg` – moving average of number of `open` operations on the file per month

```javascript 1.8
file_popularity = {
   "size": 102423541,
   "open_count": 123,
   "last_open": 1601889434,
   "hr_hist": [15, 0, 0, 0, 0, 1, 25, 125, 11, 3, 4, 0, 0, 0, 11, 0, 1, 0, 13, 0, 0, 0, 2, 1],
   "dy_hist": [212, 0, 0, 10, 0, 0, 10, 0, 150, 0, 0, 0, 1250, 0, 20, 0, 40, 280, 30, 0, 10, 110, 0, 0, 90, 250, 110, 130, 110, 0],
   "mth_hist": [2812, 300, 0, 3750, 0, 3300, 0, 0, 2700, 0, 0, 0],
   "hr_mov_avg": 8.83,
   "dy_mov_avg": 93.73,
   "mth_mov_avg": 1071.83
}
```

## REST API

All operations on views can be performed using the REST API.
Refer to the linked API documentation for detailed information and examples.

| Request                     | Link to API |
| --------------------------- | ----------- |
| Create view                 | [API][22]   |
| Get view                    | [API][23]   |
| Update view                 | [API][24]   |
| Remove view                 | [API][25]   |
| Update view reduce function | [API][26]   |
| Remove view reduce function | [API][27]   |
| List views                  | [API][28]   |
| Query view                  | [API][29]   |

## Mapping function examples

### View based on single attribute

Index files by the value of `licence` field:

```javascript
function (id, type, meta, ctx) {
    if(type === "custom_metadata"){
        if(meta['license']) {
            return [meta['license'], id];
        }
    }
}
```

### View based on multiple attributes

Index files by values of `licence` and `year` fields:

```javascript
function(id, type, meta, ctx) {
    if(type === "custom_metadata"){
        if(meta['license'] && meta['year']) {
            return [[meta['license'], meta['year']], id];
        }
    }
}
```

### View based on file name

Index files by their names (`name` attribute of the `file_meta` model):

```javascript
function (id, type, meta, ctx) {
    if(type === "file_meta"){
        if(meta['name']) {
            return [meta['name'], id];
        }
    }
}
```

### View based on JSON metadata

Index files by values of `title` field stored in user-defined JSON custom metadata:

```javascript
function(id, type, meta, ctx) {
    if (type === "custom_metadata"){
        if(meta['onedata_json']['title']) {
            return [meta['onedata_json']['title'], id];
        }
    }
}
```

### Spatial view with list of values as a key

Create a spatial view over two extended attributes: `'jobPriority'`  and `'jobScheduleTime'`.
Such view can be queried for files with the attributes' values within range passed to the query.

```javascript
function(id, type, meta, ctx) {
    if(type === "custom_metadata"){
        if (meta['jobPriority'] && meta['jobScheduleTime']){
            return [
                [meta['jobPriority'], meta['jobScheduleTime']], // key 
                id                                              // value 
            ];
        }
    }
}
```

### Spatial view with list of ranges as a key

Create a spatial view over ranges of two extended attributes: `'jobMaxExecutionTime'`  and `'jobMaxIterations'`.
Such view can be queried for files with the attributes' ranges within range passed to the query.

```javascript
function(id, type, meta, ctx) {
    if(type === "custom_metadata"){
        if (meta['jobMaxExecutionTime'] && meta['jobMaxIterations']){
            return [
                [[0, meta['jobMaxExecutionTime']], [0, meta['jobMaxIterations']]], // key
                id                                                                 // value
            ];
        }
    }
}
```

### Spatial view with GeoJSON as a key

Create a view which has a GeoJSON object as a key.

```javascript
function(id, type, meta, ctx) {
    if(type === "custom_metadata"){
        if (meta['latitude'] && meta['longitude']){
            return [
                [{
                    "type": "Point",
                    "coordinates": [meta['latitude'], meta['longitude']]
                }],                                                         // key 
                id                                                          // value
            ];
        }
    }
}
```

<!-- references -->

[1]: <>

[2]: https://docs.couchbase.com/server/5.5/views/views-intro.html

[3]: https://docs.couchbase.com/server/5.5/views/views-writing.html

[4]: https://docs.couchbase.com/server/5.5/views/sv-writing-views.html

[5]: #file-meta-model

[6]: #times-model

[7]: #custom-metadata-model

[8]: #file-popularity-model

[9]: https://docs.couchbase.com/server/5.5/views/views-writing-map.html

[10]: #indexable-metadata-models

[11]: #mapping-function-examples

[12]: https://docs.couchbase.com/server/5.5/views/sv-writing-views-keys.html

[13]: https://docs.couchbase.com/server/5.5/views/views-writing-reduce.html

[14]: https://docs.couchbase.com/server/5.5/views/views-writing-count.html

[15]: https://docs.couchbase.com/server/5.5/views/views-writing-sum.html

[16]: https://docs.couchbase.com/server/5.5/views/views-writing-stats.html

[17]: https://docs.couchbase.com/server/5.5/views/views-writing-custom-reduce.html

[18]: data.md#access-control-lists

[19]: metadata.md#extended-attributes

[20]: metadata.md#custom-metadata

[21]: ../admin-guide/oneprovider/configuration/file-popularity.md

[22]: https://onedata.org/#/home/api/latest/oneprovider?anchor=operation/create_space_view

[23]: https://onedata.org/#/home/api/latest/oneprovider?anchor=operation/get_space_view

[24]: https://onedata.org/#/home/api/latest/oneprovider?anchor=operation/update_space_view

[25]: https://onedata.org/#/home/api/latest/oneprovider?anchor=operation/remove_space_view

[26]: https://onedata.org/#/home/api/latest/oneprovider?anchor=operation/update_view_reduce_function

[27]: https://onedata.org/#/home/api/latest/oneprovider?anchor=operation/remove_view_reduce_function

[28]: https://onedata.org/#/home/api/latest/oneprovider?anchor=operation/get_space_views

[29]: https://onedata.org/#/home/api/latest/oneprovider?anchor=operation/query_space_view
