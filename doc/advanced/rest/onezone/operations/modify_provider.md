
<a name="modify_provider"></a>
#### Modify provider details
```
PATCH /provider
```


##### Description
Updates information about the Oneprovider identified by the
peer certificate used for the request.

***Example cURL requests***

**Update provider geo location**
```bash
curl --cert ozp_cert.pem --key ozp_key.pem -X PATCH \
-d '{"latitude": 50.068968,"longitude": 20.909444}'  \
https://$HOST:8443/api/v3/onezone/provider
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Body**|**data**  <br>*required*|Provider data.|[ProviderDetails](../definitions/ProviderDetails.md#providerdetails)|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|Provider details updated successfully.|No Content|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**401**|Authentication error.|[Error](../definitions/Error.md#error)|
|**403**|Authorization error.|[Error](../definitions/Error.md#error)|
|**404**|Resource not found.|[Error](../definitions/Error.md#error)|
|**500**|Internal server Error.|[Error](../definitions/Error.md#error)|


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
  "name" : "Example provider",
  "providerId" : "H8ez0CwDZ7JMYRWn1ipmBpgJHPXzIXj0123upGkf9tk",
  "urls" : [ "http://beta.onedata.org/provider1", "http://beta.onedata.org/provider2" ],
  "redirectionPoint" : "http://beta.onedata.org/provider2",
  "latitude" : 50.0647,
  "longitude" : 19.945
}
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



