
<a name="put_provider"></a>
#### Register provider
```
PUT /provider
```


##### Description
Registers provider in the zone.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Body**|**providerRegisterRequest**  <br>*required*||[ProviderRegisterRequest](../definitions/ProviderRegisterRequest.md#providerregisterrequest)|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|Provider has been successfully registered.|No Content|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|No Content|
|**500**|Internal server error.|No Content|


##### Consumes

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/provider"
```


###### Request body
```
json :
{
  "name" : "Provider1",
  "redirectionPoint" : "https://192.168.11.23",
  "geoLongitude" : -24.3776025,
  "geoLatitude" : -128.3519364,
  "onezoneDomainName" : "onezone2.example.com"
}
```


##### Example HTTP response

###### Response 400
```
json :
{
  "error" : "Authentication Error",
  "description" : "Invalid username or password."
}
```



