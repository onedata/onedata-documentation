
<a name="list_provider_spaces"></a>
#### List spaces supported by provider
```
GET /providers/{pid}/spaces
```


##### Description
Returns the list of spaces supported by specific provider.

This operation requires `oz_providers_list_spaces` privilege.

***Example cURL requests***

**List spaces supported by provider**
```bash
curlsS -u username:password -X GET  \
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
|**200**|The list of space ID's.|[Spaces](../definitions/Spaces.md#spaces)|
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
"/providers/string/spaces"
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



