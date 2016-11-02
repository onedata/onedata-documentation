
<a name="get_spaces"></a>
#### List all spaces
```
GET /spaces
```


##### Description
Returns the list of all spaces managed by the Onezone service.

This operation requires `list_spaces` privilege.

***Example cURL requests***

**List all spaces**
```bash
curl -k -u admin:password -X GET \
https://$HOST:8443/api/v3/onezone/spaces

{
  "spaces": ["S0Y9FSe9TFJFFzzLtBEs8","IkHBv8CoAFmbFU4fj26"]
}
```


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|List of spaces Id's.|[Response 200](#get_spaces-response-200)|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**401**|Authentication error.|[Error](../definitions/Error.md#error)|
|**403**|Authorization error.|[Error](../definitions/Error.md#error)|
|**404**|Resource not found.|[Error](../definitions/Error.md#error)|
|**500**|Internal server Error.|[Error](../definitions/Error.md#error)|

<a name="get_spaces-response-200"></a>
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
"/spaces"
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



