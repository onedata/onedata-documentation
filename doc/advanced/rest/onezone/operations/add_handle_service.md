
<a name="add_handle_service"></a>
#### Add handle service
```
POST /handle_services
```


##### Description
Allows to register a new handle service.

This operation requires `oz_handle_services_create` administrator privilege.

***Example cURL requests***

**Add handle services**
```bash
curl -u username:password -X POST  -H "Content-type: application/json" \
-d '{ ... }' https://$HOST:8443/api/v3/handle_services
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Body**|**handleService**  <br>*required*||[HandleService](../definitions/HandleService.md#handleservice)|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|Request successful.  <br>**Headers** :   <br>`Location` (string) : The endpoint of the new handle service resource including the generated GUID.|No Content|
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
"/handle_services"
```


###### Request body
```
json :
{
  "handleServiceId" : "SADHLKJhlkASHDLAKSHDLKJHJjLH",
  "name" : "MyCommunity Handle service",
  "proxyEndpoint" : "https://localhost:17000/handle_proxy",
  "serviceProperties" : {
    "type" : "DOI",
    "host" : "https://mds.test.datacite.org",
    "doiEndpoint" : "/doi",
    "metadataEndpoint" : "/metadata",
    "mediaEndpoint" : "/media",
    "prefix" : 10.5072,
    "username" : "alice",
    "password" : "pa$$word",
    "identifierTemplate" : "{{space.name}}-{{space.guid}}",
    "allowTemplateOverride" : false
  }
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



