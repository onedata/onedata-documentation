
<a name="unregister_provider"></a>
#### Unregister provider
```
DELETE /provider
```


##### Description
Allows Oneprovider service to unregister from Onezone.

This operation allows a Oneprovider to unregister from a this Onezone, i.e.
it can only be invoked by Oneprovider which wants to unregister. It does't
require any parameters, as the provider is identified by the peer
certificate used for this connection.

***Example cURL requests***

**Unregister provider from Onezone**
```bash
curl --cert ozp_cert.pem --key ozp_key.pem -X DELETE  \
https://$HOST:8443/api/v3/onezone/provider
```


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**202**|Provider will be unregistered.|No Content|
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



