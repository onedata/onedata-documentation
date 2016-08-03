
<a name="query_space_indexes"></a>
#### Query index
```
GET /query-index/{iid}
```


##### Description
This method returns the list of files which match the query on a predefined index.

Currently, indexes are defined per space, i.e. the result will be limited to files and folders in a space for which the index was defined.   

This operation supports also custom index query attributes as provided by [Couchbase](http://docs.couchbase.com/admin/admin/Views/views-querying.html).

Additionaly, Couchbase [spatial queries](http://docs.couchbase.com/admin/admin/Views/views-geospatial.html) are possible using `bbox` query parameter.
These queries are possible on indexes which emit values conforming to the [GeoJSON](http://geojson.org/) format.

***Example cURL requests***

**Get list of files matching index with `value1` for `key1` attribute**
```bash
curl --tlsv1.2 -H "X-Auth-Token: $TOKEN" -X GET \
https://$HOST:8443/api/v1/oneprovider/query-index/2e462492-a4d7-46b9-8641-abfdf50f06af?key1=value1

[
  "2013f807-a25e-4a55-92bb-113ab46efd12",
  "5a019a9a-cfe5-4281-8a28-8435c4716524",
  "8081e12c-df3a-46b8-b27b-8627f146af4f"
]
```
**Get a 100 files from index skipping first 200**
```bash
curl --tlsv1.2 -H "X-Auth-Token: $TOKEN" -X GET \
https://$HOST:8443/api/v1/oneprovider/query-index/2e462492-a4d7-46b9-8641-abfdf50f06af?skip=200&limit=100

[
  "30518c78-6def-40e0-9a85-c90e7efe7ffc",
  "2013f807-a25e-4a55-92bb-113ab46efd12",
  "1af64b02-1bbd-48ad-a9ef-25e9af593391",
  "8081e12c-df3a-46b8-b27b-8627f146af4f",
  ...
]
```

**Get list of files associated with geospatial coordinates located in Europe**
```bash
curl --tlsv1.2 -H "X-Auth-Token: $TOKEN" -X GET \
https://$HOST:8443/api/v1/oneprovider/query-index/2e462492-a4d7-46b9-8641-abfdf50f06af?bbox=81.008797,39.869301,27.636311,-31.266001

[
  "5145c581-af6f-4add-b3c0-d6e0253e8862",
  "6c2e5abd-0495-4fec-95b7-f8601e244b45",
]
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**iid**  <br>*required*|Id of the index to query.|string|--|
|**Query**|**bbox**  <br>*optional*|Specify the bounding box for a spatial query (e.g. ?bbox=-180,-90,0,0)|string|--|
|**Query**|**descending**  <br>*optional*|Return the documents in descending by key order.|boolean|`"false"`|
|**Query**|**endkey**  <br>*optional*|Stop returning records when the specified key is reached.  Key must be specified as a JSON value.|string|--|
|**Query**|**endkey_docid**  <br>*optional*|Stop returning records when the specified document ID is reached.|string|--|
|**Query**|**inclusive_end**  <br>*optional*|Specifies whether the specified end key is included in the result.  ***Note:*** Do not use `inclusive_end` with `key` or `keys`.|boolean|`"false"`|
|**Query**|**key**  <br>*optional*|Return only documents that match the specified key.  Key must be specified as a JSON value.|string|--|
|**Query**|**keys**  <br>*optional*|Return only documents that match each of keys specified within the given array.  Key must be specified as a JSON value.  Sorting is not applied when using this option.|< string > array(multi)|--|
|**Query**|**limit**  <br>*optional*|Limit the number of the returned documents to the specified number.|integer|--|
|**Query**|**skip**  <br>*optional*|Skip this number of records before starting to return the results.|integer|--|
|**Query**|**stale**  <br>*optional*|Allow records from a stale view to be used.|boolean|`"false"`|
|**Query**|**startkey**  <br>*optional*|Return records with a value equal to or greater than the specified key.  Key must be specified as a JSON value.|string|--|
|**Query**|**startkey_docid**  <br>*optional*|Return records starting with the specified document ID.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|Index list returned successfully.|< string > array|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|[Error](../definitions/Error.md#error)|
|**404**|File not found.|[Error](../definitions/Error.md#error)|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


##### Produces

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/query-index/string"
```


###### Request query
```
json :
{
  "bbox" : "string",
  "descending" : true,
  "endkey" : "string",
  "endkey_docid" : "string",
  "inclusive_end" : true,
  "key" : "string",
  "keys" : "string",
  "limit" : 0,
  "skip" : 0,
  "stale" : true,
  "startkey" : "string",
  "startkey_docid" : "string"
}
```


##### Example HTTP response

###### Response 200
```
json :
"array"
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



