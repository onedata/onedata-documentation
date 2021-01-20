# Views
<!-- This file is referenced at least one time as "views.md" -->

<!-- toc -->

Onedata supports creation of custom views on files' metadata. They can be used for:
 * efficient querying for files
 * producing tables and lists of information based on files' metadata
 * extracting or filtering information from files' metadata
 * calculating, summarizing or reducing the information on the stored metadata  

Views are a result of continuous indexing of documents.
Documents are mapped using user-defined mapping function. Optionally, results of 
the mapping can also be reduced using a reduce function if it is provided by the user.
Internally, views are based on [Couchbase Views](https://docs.couchbase.com/server/5.5/views/views-intro.html).
Please visit this site for more comprehensive explanation of concepts used among this documentation.  

There are two types of views that can be created:
* [map-reduce views](https://docs.couchbase.com/server/5.5/views/views-writing.html)
* [spatial views](https://docs.couchbase.com/server/5.5/views/sv-writing-views.html) - 
spatial views are similar to map-reduce views. They are suited for querying multi-dimensional data.
The main difference is that they don't have a reduce function.

Currently, views can be created on the following models storing files' metadata:
 * [`file_meta`](#file-meta-model)
 * [`times`](#times-model)
 * [`custom_metadata`](#custom-metadata-model)
 * [`file_popularity`](#file-popularity-model)

## Concepts

### Mapping function

All information presented in this section is relevant to both map-reduce and spatial views.
Function used by spatial views is called as a *spatial* in Couchbase documentation. For simplicity, in this documentation, 
the *mapping* name is used for both terms, as they must comply to the same rules (with one exception, emphasised below).

In order to create a view, it is necessary to write a simple Javascript mapping
function. It is used to map the data stored in the document to the value which should be indexed.
Mapping is performed by using `emit()` function. Each call to `emit()` results in a new row of data in the view result.
More info on mapping functions concepts can be found [here](https://docs.couchbase.com/server/5.5/views/views-writing-map.html).

In Onedata views API, the mapping function submitted by the user is wrapped inside
additional Javascript code, in order to comply with Couchbase API.

The mapping function should accept 4 arguments:
 * `id` - id of a file,
 * `type` - type of the document that is being mapped by the function. One of:
    * `"file_meta"`
    * `"times"`
    * `"custom_metadata"`
    * `"file_popularity"`
 * `meta` - values stored in the document being mapped,
 * `ctx` - context object used for storing helpful information. Currently it stores:
    * `providerId`,
    * `spaceId`.

The mapping function should return (key, value) pair or pairs that are to be emitted
 to the view via `emit()` function.

 If one document shall be mapped to exactly one row in the view, the mapping
 function should return 2-element list [key, value], where key and value can be any JS object.

 If one document shall be mapped to many rows in the view, the mapping
 function should return an object with the key `'list'`. The value should be
 a list of 2-element lists [key, value]. The `emit()` function is called for
 each 2-element list in the top-level list. 

>**NOTE: Spatial view key format**
>
>The mapping function defined for a spatial view must return the key as a multidimensional bounding box.
 There are 3 accepted ways of defining a key in a spatial function:
> * single values - list of numerical values, which is expanded to a collapsed range. 
    For example, list `[1.0, 2, 3.5]` is internally expanded to  list of ranges `[[1.0, 1.0], [2 , 2], [3.5, 3.5]]`
> * ranges - list of ranges. For example:  `[[1.0, 2.0], [100, 1000]]`
> * GeoJSON geometry - the following GeoJSON objects are supported: 
>     * Point
>     * MultiPoint
>     * LineString
>     * MultiLineString
>     * MultiPolygon
>     * GeometryCollection
>
> Above formats of defining keys might be combined. The only constraint is that GeoJSON object must be the first element of the list.
>
> Defining spatial view keys is thoroughly described [here](https://docs.couchbase.com/server/5.5/views/sv-writing-views-keys.html).

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

A few examples of the mapping function are presented [here](#mapping-function-examples).

### Reduce function (optional)

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

## Metadata models that can be indexed

### File meta model
Model that stores basic file metadata, such as:
* `name` - name of the file 
* `type` - specifies whether the resource is a regular file (`REG`) or a directory (`DIR`)
* `mode` - POSIX access mode in octal form (i.e. 4 digits starting with 0) 
* `owner` - Id of an owner of the file
* `acl` - [access control list](file_management.md#access-control-lists)
* `provider_id` - Id of a provider on which the file was created
* `shares` - list of share Id's associated with this file or directory
* `deleted` - flag informing that file was marked to be deleted

### Times model
This model was extracted from the `file_meta` due to efficiency reasons.
It stores classical Unix timestamps:
* `atime` - Unix last access timestamp
* `mtime` - Unix last modification timestamp
* `ctime` - Unix last status timestamp


### Custom metadata model
Model used for storing [extended attributes](metadata.md#extended-attributes) and [custom metadata](metadata.md#custom-metadata). 
Currently, views can operate on both extended attributes as well as JSON metadata, RDF metadata backend
indexing is not yet supported.
The model has the following fields:
* `onedata_json` - which stores map of JSON metadata values
* `onedata_rdf` - which stores RDF metadata
* extended attributes set by users

### File popularity model
<!-- This header is referenced at least one time as "#file-popularity-model" -->

Model used for tracking [file popularity](../administering_onedata/file_popularity.md).
These documents are available only if collecting file popularity statistics is turned on in the given space.
It can be turned on only by space admin via Onepanel. 
The `File popularity` document is available only for a file which has been opened at least once on a given provider.  
It stores:
* `size` - total sum of the file's blocks stored on given provider
* `open_count` - number of `open` operations on the file
* `last_open` - timestamp fo last `open` on the file
* `hr_hist`  - hourly histogram of number of `open` operations on the file per hour, in the last 24 hours  
* `dy_hist`  - daily histogram of number of `open` operations on the file per day, in the last 30 days
* `mth_hist` - monthly histogram of number of `open` operations on the file per month, in the last 12 months
* `hr_mov_avg` - moving average of number of `open` operations on the file per hour
* `dy_mov_avg` - moving average of number of `open` operations on the file per day
* `mth_mov_avg` - moving average of number of `open` operations on the file per month


## REST API

All operations on views are listed in the below table, with links to comprehensive description of appropriate requests and their parameters. 

| Request                      | Link to API |
|------------------------------|-------------|
| Create view                  | [API](https://onedata.org/#/home/api/latest/oneprovider?anchor=operation/create_space_view)|        
| Get view                     | [API](https://onedata.org/#/home/api/latest/oneprovider?anchor=operation/get_space_view)|        
| Update view                  | [API](https://onedata.org/#/home/api/latest/oneprovider?anchor=operation/update_space_view)|        
| Remove view                  | [API](https://onedata.org/#/home/api/latest/oneprovider?anchor=operation/remove_space_view)|        
| Update view reduce function  | [API](https://onedata.org/#/home/api/latest/oneprovider?anchor=operation/update_view_reduce_function)|        
| Remove view reduce function  | [API](https://onedata.org/#/home/api/latest/oneprovider?anchor=operation/remove_view_reduce_function)|        
| List views                   | [API](https://onedata.org/#/home/api/latest/oneprovider?anchor=operation/get_space_views)|        
| Query view                   | [API](https://onedata.org/#/home/api/latest/oneprovider?anchor=operation/query_space_view)|        


## Mapping function examples

### View based on single attribute

The example below presents a simple function which creates a view over a
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

### View based on multiple attributes

It is possible to create custom views, based on multiple attribute fields, e.g.:

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

The example below presents a function which can be used to create a view over file's name (`name`
attribute of the `file_meta` model).

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
In order to create views over user JSON metadata, the functions attribute path
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

### Spatial view with list of values as a key
The example below presents a function which can be used to create a spatial view over
2 extended attributes: `'jobPriority'`  and `'jobScheduleTime'`.
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
The example below presents a function which can be used to create a spatial view over ranges of
2 extended attributes: `'jobMaxExecutionTime'`  and `'jobMaxIterations'`.
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
The example below presents a function which returns a GeoJSON object as a key. 

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