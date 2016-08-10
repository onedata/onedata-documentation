
<a name="get_space_indexes"></a>
#### Get index list for space
```
GET /index
```


##### Description
This method returns the list of user defined index functions.

The result can be limited to specific space using query parameter `space_id`.    


***Example cURL requests***

**Get list of indexes for space**
```bash
curl --tlsv1.2 -H "X-Auth-Token: $TOKEN" -X GET \
https://$HOST:8443/api/v1/oneprovider/index?space_id=2e462492-a4d7-46b9-8641-abfdf50f06af

[
  {
    "spaceId": "2e462492-a4d7-46b9-8641-abfdf50f06af",
    "name": "My index",
    "indexId": "fdecdf35-5e18-4a9b-a01a-1702acd4d274"
  }
]
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Query**|**space_id**  <br>*optional*|Id of the space to query.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|Index list returned successfully.|< [Index](../definitions/Index.md#index) > array|
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
"/index"
```


###### Request query
```
json :
{
  "space_id" : "string"
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



