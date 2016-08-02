
<a name="get_space_index"></a>
#### Get index
```
GET /index/{iid}
```


##### Description
This method returns a specific index source code.  

The indexes are defined as JavaScript functions which are executed 
on the database backend.

***Example cURL requests***

**Get list of indexes for space**
```bash
curl --tlsv1.2 -H "X-Auth-Token: $TOKEN" -X GET \
https://$HOST:8443/api/v1/oneprovider/index/f209c965-e212-4149-af72-860faea4187a


function(x) {
  ...
}
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**iid**  <br>*required*|Id of the index to return.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|Index source returned successfully.|string|
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
"/index/string"
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



