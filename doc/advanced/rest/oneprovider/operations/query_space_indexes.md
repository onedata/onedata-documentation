
<a name="query_space_indexes"></a>
#### Query index
```
GET /query-index/{iid}
```


##### Description
This method returns the list of files which match the query on a predefined index.

Currently, indexes are defined per space, i.e. the result will be limited to files and folders in a space for which the index was defined.   


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


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**iid**  <br>*required*|Id of the index to query.|string|--|


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



