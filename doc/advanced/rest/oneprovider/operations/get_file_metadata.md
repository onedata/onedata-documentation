
<a name="get_file_metadata"></a>
#### Get metadata
```
GET /metadata/{path}
```


##### Description
This method returns the metadata document for specified file, folder or space. Onedata supports multiple metadata backends in parallell.

The currently supported metadata stores include:
 * JSON
 * RDF

The metadata source will be selected automatically based on the "Accept: " header in the request, or from the optional `metadata_type` query parameter.

By default the method returns the complete metadata document of requested type. It is possible to request only a part of the document by specifying `filter_type` and `filter` attributes in the query.

Supported filter types are currently supported only for JSON backend:
  * **keypath** - list of JSON keys which point to requested JSON object, separated by `.`, array elements should be expressed as `[i]` (e.g. `key1.key2.[2].key3`)


***Example cURL requests***

**Get complete RDF metadata document for File2.txt**
```bash
curl --tlsv1.2 -H "X-Auth-Token: $TOKEN" -X GET \
-H "Accept: application/rdf+xml" \
https://$HOST:8443/api/v1/oneprovider/metadata/MySpace1/File2.txt
```

**Get specific JSON value from metadata document**
```bash
curl --tlsv1.2 -H "X-Auth-Token: $TOKEN" -X GET \
-H "Accept: application/json" \
https://$HOST:8443/api/v1/oneprovider/metadata/MySpace1/File2.txt?filter_type=keypath&filter=key1.key2.[2].key3
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**path**  <br>*required*|File or folder path or space name (e.g. '/My Private Space/testfiles/file1.txt')|string|--|
|**Query**|**filter**  <br>*optional*|The filter to apply to the metadata document before returning.|string|--|
|**Query**|**filter_type**  <br>*optional*|The type of filter to apply to the metadata document.|string|--|
|**Query**|**metadata_type**  <br>*optional*|Type of metadata backend (if not specified in `Accept` header)|enum (JSON, RDF)|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|Metadata returned successfully.|string|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|[Error](../definitions/Error.md#error)|
|**404**|File not found.|[Error](../definitions/Error.md#error)|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


##### Produces

* `application/json`
* `application/rdf+xml`


##### Example HTTP request

###### Request path
```
json :
"/metadata/string"
```


###### Request query
```
json :
{
  "filter" : "string",
  "filter_type" : "string",
  "metadata_type" : "string"
}
```


##### Example HTTP response

###### Response 200
```
json :
"string"
```


###### Response 400
```
json :
{
  "error" : "invalid_token",
  "error_description" : "Provided token could not be validated."
}
```


###### Response 403
```
json :
{
  "error" : "invalid_token",
  "error_description" : "Provided token could not be validated."
}
```


###### Response 404
```
json :
{
  "error" : "invalid_token",
  "error_description" : "Provided token could not be validated."
}
```


###### Response 500
```
json :
{
  "error" : "invalid_token",
  "error_description" : "Provided token could not be validated."
}
```



