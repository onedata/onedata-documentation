
<a name="create_group_handle"></a>
#### Create new group handle
```
POST /groups/{id}/handles
```


##### Description
Creates a new handle on behalf of a group.

This operation requires `register_handle` privilege, for the handle service
specified in the `handleServiceId` field.


***Example cURL requests***

**Create new group handle**
```bash
curl -u admin:password  -H "Content-type: application/json" -X POST \
-d '{ "handleServiceId": "LKJAHSDKJLHASD", "resourceType": "Share", "resourceId": "ASDasd7asdASDASD76", "metadata": "<?xml version=\'1.0\'?>..." }'
https://$HOST:8443/api/v3/onezone/groups/LKJAHGSDLKJHALSDkjashdasdk/handles
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*|Group ID.|string|--|
|**Body**|**handle**  <br>*required*|New handle parameters.|[Handle](../definitions/Handle.md#handle)|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**201**|ID of the created space in the form /groups/{id}/spaces/{sid} is returned in the response `Location` header.  <br>**Headers** :   <br>`Location` (string) : ID of the created handle.|No Content|
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
"/groups/string/handles"
```


###### Request body
```
json :
{
  "handleId" : "10.572/test-handle-G9uZXpvbmUKMDAzYmlkZW50aWZpZXIgOEh/123",
  "resourceType" : "Share",
  "resourceId" : "RsNk1CVHZTU3Z0OThwcHAhRN1NPawowMDFhY2lkIHRpbWUgPC",
  "handleServiceId" : "JKAxNWxvY2F0aW9uImSEFSSGdrbHFCa1pWST2OTQ4cz",
  "metadata" : "<?xml version=\\\"1.0\\\"?> <!DOCTYPE rdf:RDF SYSTEM \\\\\"http://dublincore.org/2000/12/01-dcmes-xml-dtd.dtd\\\"> <rdf:RDF xmlns:rdf=\\\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\\\"\n         xmlns:dc=\\\"http://purl.org/dc/elements/1.1/\\\">\n  <rdf:Description rdf:about=\\\"http://example.com/resouces/1\\\">\n    <dc:title>Example Resource</dc:title>\n    <dc:creator>John Doe</dc:creator>\n    <dc:publisher>MIT</dc:publisher>\n    <dc:date>2000-06-06</dc:date>\n  </rdf:Description>\n</rdf:RDF>\n",
  "timestamp" : "2016-07-16T18:20:30.450Z"
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



