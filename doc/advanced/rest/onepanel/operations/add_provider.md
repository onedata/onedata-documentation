
<a name="add_provider"></a>
#### Register provider
```
POST /provider
```


##### Description
Registers provider in the zone.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Body**|**providerRegisterRequest**  <br>*required*|The new provider details.|[ProviderRegisterRequest](../definitions/ProviderRegisterRequest.md#providerregisterrequest)|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|Provider has been successfully registered.|No Content|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**401**|Unauthorized request.|No Content|
|**403**|Forbidden request.|No Content|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


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
  "error" : "Invalid Request",
  "description" : "User role must be one of 'admin' or 'regular'."
}
```


###### Response 500
```
json :
{
  "error" : "Invalid Request",
  "description" : "User role must be one of 'admin' or 'regular'."
}
```


