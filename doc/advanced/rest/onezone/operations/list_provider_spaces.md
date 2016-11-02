
<a name="list_provider_spaces"></a>
#### Get spaces supported by provider
```
GET /providers/{pid}/spaces
```


##### Description
Returns the list of spaces supported by specific provider.

This operation requires `list_spaces_of_provider` privilege.

***Example cURL requests***

**List spaces supported by provider**
```bash
curl -ksS -u username:password -X GET  \
https://$HOST:8443/api/v3/onezone/providers/ASDJKHASDASD5465asdvASDasd/spaces

{
  "spaces": [
    "ASDKJHKLAJSDHKjhAsdkjh68asdASDlk", 
    "JKLAHSDLKHASJKLDH76786ASDHBKJHMa"
  ]
}
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**pid**  <br>*required*|Provider ID.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The list of space ID's.|[Response 200](#list_provider_spaces-response-200)|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**401**|Authentication error.|[Error](../definitions/Error.md#error)|
|**403**|Authorization error.|[Error](../definitions/Error.md#error)|
|**404**|Resource not found.|[Error](../definitions/Error.md#error)|
|**500**|Internal server Error.|[Error](../definitions/Error.md#error)|

<a name="list_provider_spaces-response-200"></a>
**Response 200**

|Name|Description|Schema|
|---|---|---|
|**spaces**  <br>*optional*||< string > array|


##### Produces

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/providers/string/spaces"
```


##### Example HTTP response

###### Response 200
```
json :
"object"
```


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



