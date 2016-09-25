
<a name="get_handle_service"></a>
#### Get handle service
```
GET /handle_services/{id}
```


##### Description
Returns the properties of a specific handle service.

This operation requires `view_handle_service` privilege.

***Example cURL requests***

**Get handle services**
```bash
curl -k -u username:password -X GET \
https://$HOST:8443/api/v3/handle_services/SADHLKJhlkASHDLAKSHDLKJHJjLH

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
|**Path**|**id**  <br>*required*||string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The list of identifiers of registered handle services.|< string > array|
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
"/handle_services/string"
```


##### Example HTTP response

###### Response 200
```
json :
"array"
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



