
<a name="modify_provider"></a>
#### Modify provider details
```
PATCH /provider
```


##### Description
Modifies basic provider details in the zone.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Body**|**providerModifyRequest**  <br>*required*|New values for provider configuration parameters which should be changed.|[ProviderModifyRequest](../definitions/ProviderModifyRequest.md#providermodifyrequest)|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|Provider details has been successfully modified.|No Content|
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
  "geoLatitude" : -128.3519364
}
```


##### Example HTTP response

###### Response 500
```
json :
{
  "error" : "Invalid Request",
  "description" : "User role must be one of 'admin' or 'regular'."
}
```


