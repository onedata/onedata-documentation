
<a name="get_provider"></a>
#### Get provider details
```
GET /provider
```


##### Description
Returns the basic configuration information of the provider.


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The provider configuration details.|[ProviderDetails](../definitions/ProviderDetails.md#providerdetails)|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|[Error](../definitions/Error.md#error)|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


##### Produces

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/provider"
```


##### Example HTTP response

###### Response 200
```
json :
{
  "id" : "VAiDGZbs3k0FD8jPhyU1",
  "name" : "Provider1",
  "urls" : [ "192.168.11.23" ],
  "redirectionPoint" : "https://192.168.11.23",
  "geoLongitude" : -24.3776025,
  "geoLatitude" : -128.3519364
}
```


###### Response 400
```
json :
{
  "error" : "Authentication Error",
  "description" : "Invalid username or password."
}
```


###### Response 403
```
json :
{
  "error" : "Authentication Error",
  "description" : "Invalid username or password."
}
```


###### Response 500
```
json :
{
  "error" : "Authentication Error",
  "description" : "Invalid username or password."
}
```



