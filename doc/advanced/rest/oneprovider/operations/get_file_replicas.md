
<a name="get_file_replicas"></a>
#### Get replicas by path
```
GET /replicas/{path}
```


##### Description
Returns file distribution information about a specific file replicated at this provider.

***Example cURL requests***

**Get file distribution map by path**
```bash
curl --tlsv1.2 -X GET -H "X-Auth-Token: $TOKEN" \
"https://$HOST:8443/replicas/MySpace1/MyFile1.txt"

[
  {
    "blocks": [ [ 0, 4 ], [ 10, 20 ] ],
    "providerId": "784dae9d-34a3-4aef-ab4b-2c6c60b74e27"
  },
  {
    "blocks": [ [ 5, 9 ] ],
    "providerId": "b296ab05-3d62-4755-be46-c57ced411ff1"
  }
]
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**path**  <br>*required*|File path (e.g. '/My Private Space/testfiles/file1.txt')|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The list of file blocks stored at each provider.|< [FileDistribution](../definitions/FileDistribution.md#filedistribution) > array|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|[Error](../definitions/Error.md#error)|
|**404**|Oneprovider REST API not available.|[Error](../definitions/Error.md#error)|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


##### Produces

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/replicas/string"
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



