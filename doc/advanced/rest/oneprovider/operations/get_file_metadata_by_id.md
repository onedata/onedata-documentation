
<a name="get_file_metadata_by_id"></a>
#### Get metadata
```
GET /metadata-id/{id}
```


##### Description
This method returns the metadata document for specified file, folder or space by ID. Onedata supports multiple metadata backends in parallell.

The currently supported metadata stores include:
 * JSON
 * RDF

The metadata source will be selected automatically based on the "Accept: " header in the request, or from the optional `metadata_type` query parameter.

By default the method returns the complete metadata document of requested type. It is possible to request only a part of the document by specifying `filter_type` and `filter` attributes in the query.

Supported filter types are currently supported only for JSON backend:
  * **keypath** - list of JSON keys which point to requested JSON object, separated by `.`, array elements should be expressed as `[i]` (e.g. `key1.key2.[2].key3`)


***Example cURL requests***

**Get complete RDF metadata document for file**

```bash
curl --tlsv1.2 -H "X-Auth-Token: $TOKEN" -X GET \
-H "Accept: application/rdf+xml" \
https://$HOST:8443/api/v1/oneprovider/metadata-id/6fd04d80-3856-4f82-8382-4fca29b1171d
```

**Get specific JSON value from metadata document**

```bash
curl --tlsv1.2 -H "X-Auth-Token: $TOKEN" -X GET \
-H "Accept: application/json" \
https://$HOST:8443/api/v1/oneprovider/metadata-id/7f85c115-8631-4602-b7d5-47cd969280a2?filter_type=keypath&filter=key1.key2.[2].key3
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*|File or folder path or space ID|string|--|
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
"/metadata-id/string"
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



