
<a name="modify_supported_space"></a>
#### Modify supported space
```
PATCH /provider/spaces/{sid}
```


##### Description
Modifies supported space parameters.

This operation requires peer certificate authentication.

***Example cURL requests***

**Change supported size**
```bash
curl --key ./certs/ozp_key.pem --cert ./certs/ozp_cert.pem -X PATCH \
-d '{"size": 1024000}' \
https://$HOST:8443/api/v3/onezone/provider/spaces/803ZirkUfdiWDd4W3bI4QaPBog_0kCdUddUIsgAxi5I
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**sid**  <br>*required*|Space ID.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|Space modified successfully.|No Content|
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
"/provider/spaces/string"
```


##### Example HTTP response

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



