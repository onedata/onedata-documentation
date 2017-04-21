
<a name="get_handle_service_group"></a>
#### Get handle service group details
```
GET /handle_services/{id}/groups/{gid}
```


##### Description
Get details of a group with access to handle service.

This operation requires `view_handle_service` administrator privilege.

***Example cURL requests***

**Get group handle service**
```bash
curl -u username:password -X GET \
https://$HOST:8443/api/v3/handle_services/SADHLKJhlkASHDLAKSHDLKJHJjLH/groups/HwUpk8jrwxKOe45uzLFX2GVa8lKEasj4q253sptVqF8

{
  "groupId":"HwUpk8jrwxKOe45uzLFX2GVa8lKEasj4q253sptVqF8",
  "name":"Group name",
  "type":"role"
}
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**gid**  <br>*required*|The ID of the group to add to handle service.|string|--|
|**Path**|**id**  <br>*required*|The ID of the handle service.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|Handle service details returned.|[HandleService](../definitions/HandleService.md#handleservice)|
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
"/handle_services/string/groups/string"
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



