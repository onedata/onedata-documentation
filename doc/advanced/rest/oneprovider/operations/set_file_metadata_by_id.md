
<a name="set_file_metadata_by_id"></a>
#### Set metadata
```
PUT /metadata-id/{id}
```


##### Description
This method allows to set specific metadata document for a file, folder or space specified by ID in the request path.

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
https://$HOST:8443/api/v1/oneprovider/metadata-id/9e91571f-9dc9-4cea-a86a-9e6bae5aaaca
```

**Set RDF metadata for space from RDF file**
```bash
curl --tlsv1.2 -H "X-Auth-Token: $TOKEN" -X PUT \
-H "Content-type: application/rdf+xml" \
-d "@./space1_dublincore.rdf"
https://$HOST:8443/api/v1/oneprovider/metadata-id/1e65d5f4-c49d-495a-a2b6-50acd02a25b1
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*|File or folder path or space name (e.g. '/My Private Space/testfiles/file1.txt')|string|--|
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
"/metadata-id/string"
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



