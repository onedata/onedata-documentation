
<a name="get_supported_space"></a>
#### Get space details by provider
```
GET /provider/spaces/{sid}
```


##### Description
Returns information about a specific space supported by the Oneprovider that
performed the request.

This operation requires peer certificate authentication.

***Example cURL requests***

**Get space details**
```bash
curl --key ./certs/ozp_key.pem --cert ./certs/ozp_cert.pem -X GET \
https://$HOST:8443/api/v3/onezone/provider/spaces/803ZirkUfdiWDd4W3bI4QaPBog_0kCdUddUIsgAxi5I

{
  "spaceId": "803ZirkUfdiWDd4W3bI4QaPBog_0kCdUddUIsgAxi5I",
  "name": "new_space1",
  "providersSupports": {
    "hxfMCWmquqAIjG1GeG2eZY8qvs8iRIn09HzjCJilnSE" : 5368709120
  }
}
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**sid**  <br>*required*|Space ID.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|Returns the information about a specific space.|[Space](../definitions/Space.md#space)|
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

###### Response 200
```
json :
{
  "spaceId" : "Xnp1JVpWfL8_stHJgct76AFALjRsI0W3rNs1nfMwqnY",
  "name" : "My Private space",
  "providersSupports" : {
    "hxfMCWmquqAIjG1GeG2eZY8qvs8iRIn09HzjCJilnSE" : 5368709120
  }
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



