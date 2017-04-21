
<a name="get_user_handle_service"></a>
#### Get user handle service details
```
GET /user/handle_services/{hsid}
```


##### Description
Returns the details of a specific handle service.

This operation can be invoked on behalf of current user only.

***Example cURL requests***

**Get handle service details**
```bash
curl -u username:password -X GET \
https://$HOST:8443/api/v3/onezone/user/handle_services/oOVF-KrO1P6rpA0LFgNVI8NxuhxyQMUnrYzjAnKiyAY

{
    "name": "MyCommunity Handle service",
    "proxyEndpoint": "https://localhost:17000/handle_proxy",
    "serviceProperties": {
        "allowTemplateOverride": false,
        "doiEndpoint": "/doi",
        "host": "https://mds.test.datacite.org",
        "identifierTemplate": "{{space.name}}-{{space.guid}}",
        "mediaEndpoint": "/media",
        "metadataEndpoint": "/metadata",
        "password": "pa$$word",
        "prefix": 10.5072,
        "type": "DOI",
        "username": "alice"
    }
}
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**hsid**  <br>*required*|Handle service ID.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|Returns the details of a specific handle service.|[HandleService](../definitions/HandleService.md#handleservice)|
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
"/user/handle_services/string"
```


##### Example HTTP response

###### Response 200
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



