
<a name="list_spaces"></a>
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
curl -u admin:password -X GET \
https://$HOST:8443/api/v3/onezone/spaces

{
  "spaces": [
    "S0Y9FSe9TFJFFzzLtBEs8",
    "IkHBv8CoAFmbFU4fj26"
  ]
}
```


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|List of spaces Id's.|[Spaces](../definitions/Spaces.md#spaces)|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**401**|Authentication error.|[Error](../definitions/Error.md#error)|
|**403**|Authorization error.|[Error](../definitions/Error.md#error)|
|**404**|Resource not found.|[Error](../definitions/Error.md#error)|
|**500**|Internal server Error.|[Error](../definitions/Error.md#error)|


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
{
  "spaces" : [ "Bmav38YI0Z2-dw-fvrZ3XP-J0HjCN0taT3_WungK", "ASmlkZW50aWZpZXIgOEhmSEFSSGdrbHFCa1pWSTR" ]
}
```


###### Response 400
```
json :
{
  "error" : "Provided data could not be understood by the server"
}
```


###### Response 401
```
json :
{
  "error" : "Provided data could not be understood by the server"
}
```


###### Response 403
```
json :
{
  "error" : "Provided data could not be understood by the server"
}
```


###### Response 404
```
json :
{
  "error" : "Provided data could not be understood by the server"
}
```


###### Response 500
```
json :
{
  "error" : "Provided data could not be understood by the server"
}
```



