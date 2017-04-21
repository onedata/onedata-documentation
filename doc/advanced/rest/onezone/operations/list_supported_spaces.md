
<a name="list_supported_spaces"></a>
#### List spaces at provider
```
GET /provider/spaces
```


##### Description
Returns the list of spaces managed by the Oneprovider that performed the
request.

This operation requires peer certificate authentication.

***Example cURL requests***

**Get spaces supported by provider**
```bash
curl --key ./certs/ozp_key.pem --cert ./certs/ozp_cert.pem -X GET  \
https://$HOST:8443/api/v3/onezone/provider/spaces

{
  "spaces": [
    "ASDKJHKLAJSDHKjhAsdkjh68asdASDlk"
  ]
}
```


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
"/provider/spaces"
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



