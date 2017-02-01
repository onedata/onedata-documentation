
<a name="get_other_provider"></a>
#### Get provider details
```
GET /provider/{pid}
```


##### Description
Returns the information about another Oneprovider service, which is connected to the onezone.

If called by other provider doesn't require any special privileges. 

When called by a regular user, requires 'list_providers' privilege.

This operation requires `list_providers` privilege.

***Example cURL requests***

**Get specific provider details**
```bash
curl -k --cert ./etc/op_worker/certs/grpcert.pem -X GET  \
https://$HOST:8443/api/v3/onezone/provider/WEavnRE7c49EU2sjF0Rz7l_kpiA1IBrwbDxNfH87Plc
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**pid**  <br>*required*|Provider ID.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|Information about a provider.|[ProviderDetails](../definitions/ProviderDetails.md#providerdetails)|
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
"/provider/string"
```


##### Example HTTP response

###### Response 200
```
json :
{
  "providerId" : "LASDASJDBH89869ASD79869asd",
  "urls" : [ "http://beta.onedata.org/provider1", "http://beta.onedata.org/provider2" ],
  "redirectionPoint" : "http://beta.onedata.org/provider2",
  "latitude" : 50.0647,
  "longitude" : 19.945
}
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



