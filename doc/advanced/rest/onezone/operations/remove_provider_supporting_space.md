
<a name="remove_provider_supporting_space"></a>
#### Remove space support
```
DELETE /spaces/{id}/providers/{pid}
```


##### Description
Removes support from provider for a specific space.

This operation requires `space_remove_provider` privilege.

***Example cURL requests***

**Remove space support**
```bash
curl -k -u username:password -X DELETE \
https://$HOST:8443/api/v3/onezone/spaces/IkHBv8CoAFm5FCswhAJynbFU4fj26yiE1lhpK3p-0Y8/providers/H8ez0CwDZ7JMYRWn1ipmBpgJHPXzIXj0__-upGkf9tk
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*|Space ID.|string|--|
|**Path**|**pid**  <br>*required*|Provider ID.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|A space is no longer supported by this provider.|No Content|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**401**|Authentication error.|[Error](../definitions/Error.md#error)|
|**403**|Authorization error.|[Error](../definitions/Error.md#error)|
|**404**|Resource not found.|[Error](../definitions/Error.md#error)|
|**500**|Internal server Error.|[Error](../definitions/Error.md#error)|


##### Example HTTP request

###### Request path
```
json :
"/spaces/string/providers/string"
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


###### Response 401
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



