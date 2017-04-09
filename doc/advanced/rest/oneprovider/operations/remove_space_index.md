
<a name="remove_space_index"></a>
#### Remove index
```
DELETE /index/{iid}
```


##### Description
This method removes an existing index.

***Example cURL requests***

**Remove existing index**
```bash
curl --tlsv1.2 -H "X-Auth-Token: $TOKEN" -X DELETE \
https://$HOST:8443/api/v1/oneprovider/index/f209c965-e212-4149-af72-860faea4187a
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**iid**  <br>*required*|Id of the index to update.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|Index removed successfully.|No Content|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|[Error](../definitions/Error.md#error)|
|**404**|File not found.|[Error](../definitions/Error.md#error)|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


##### Consumes

* `application/javascript`


##### Example HTTP request

###### Request path
```
json :
"/index/string"
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



