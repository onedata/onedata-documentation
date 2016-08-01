
<a name="get_file_replicas_by_id"></a>
#### Get replicas by ID
```
GET /replicas-id/{fid}
```


##### Description
Returns file distribution information about a specific file replicated at this provider.

***Example cURL requests***

**Get file distribution map by ID**
```bash
curl --tlsv1.2 -X GET -H "X-Auth-Token: $TOKEN" \
"https://$HOST:8443/replicas-id/63aaab32-f5b0-41e6-b5f4-5a902ccf9c77"

[
  {
    "blocks": [ [ 0, 4 ], [ 10, 20 ] ],
    "providerId": "57ecb305-a097-4243-bd03-a995e78ab206
  },
  {
    "blocks": [ [ 5, 9 ] ],
    "providerId": "7dedd2c7-dc58-4e62-925e-94663faa70fc"
  }
]
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**fid**  <br>*required*|The ID of the file|string|--|


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
"/replicas-id/string"
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



