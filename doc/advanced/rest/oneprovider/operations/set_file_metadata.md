
<a name="set_file_metadata"></a>
#### Set metadata
```
PUT /metadata/{path}
```


##### Description
This method allows to set specific metadata document for a file, folder or space specified in the request path.

The currently supported metadata stores include:
 * JSON
 * RDF

The metadata source will be selected automatically based on the "Content-type: " header in the request, or from the optional `metadata_type` query parameter.

This operation will replace the entire metadata document in the specified metadata backend.

***Example cURL requests***

**Set JSON metadata for file**
```bash
curl --tlsv1.2 -H "X-Auth-Token: $TOKEN" -X PUT \
-H "Content-type: application/json" \
-d '{ "key1": { "key2": ["val1", "val2", "val3", "val4"] } }'
https://$HOST:8443/api/v1/oneprovider/metadata/MySpace1/File2.txt
```

**Set RDF metadata for space from RDF file**
```bash
curl --tlsv1.2 -H "X-Auth-Token: $TOKEN" -X PUT \
-H "Content-type: application/rdf+xml" \
-d "@./space1_dublincore.rdf"
https://$HOST:8443/api/v1/oneprovider/metadata/MySpace1
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**path**  <br>*required*|File or folder path or space name (e.g. '/My Private Space/testfiles/file1.txt')|string|--|
|**Query**|**metadata_type**  <br>*optional*|Type of metadata backend (if not specified in `Accept` header)|enum (JSON, RDF)|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|Metadata document updated successfully.|No Content|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|[Error](../definitions/Error.md#error)|
|**404**|File not found.|[Error](../definitions/Error.md#error)|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


##### Consumes

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
  "metadata_type" : "string"
}
```


##### Example HTTP response

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



