
<a name="handle_service_register_handle"></a>
#### Register handle
```
POST /handles
```


##### Description
Allows to register a new handle identifier, using a specific handle service.

The handle service must be registered in Onedata separately.

This operation requires `handle_service_register_handle` privilege, which needs to
be assigned to a specific handle service.

***Example cURL requests***

**Register handle**
```bash
curl -u username:password -X POST -H "Content-type: application/json" \
-d '{ "handleServiceId": "LKJAHSDKJLHASD", "resourceType": "Share", "resourceId": "ASDasd7asdASDASD76", "metadata": "<?xml version=\'1.0\'?>..." }' \
https://$HOST:8443/api/v3/handles
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Body**|**handleRegistrationRequest**  <br>*required*||[HandleRegistrationRequest](../definitions/HandleRegistrationRequest.md#handleregistrationrequest)|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|Request successful.  <br>**Headers** :   <br>`Location` (string) : The endpoint of the new handle resource including the generated GUID.|No Content|
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
"/handles"
```


###### Request body
```
json :
{
  "handleServiceId" : "ALKJSDH77i79ASDKJA-ASDBAS9-87",
  "resourceType" : "Share",
  "resourceId" : "LKJAHSDA796IASDKBjkhaksjdk568787asdhjbasd",
  "metadata" : "<?xml version=\\\"1.0\\\"?> <!DOCTYPE rdf:RDF SYSTEM \\\\\"http://dublincore.org/2000/12/01-dcmes-xml-dtd.dtd\\\"> <rdf:RDF xmlns:rdf=\\\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\\\"\n         xmlns:dc=\\\"http://purl.org/dc/elements/1.1/\\\">\n  <rdf:Description rdf:about=\\\"http://example.com/resouces/1\\\">\n    <dc:title>Example Resource</dc:title>\n    <dc:creator>John Doe</dc:creator>\n    <dc:publisher>MIT</dc:publisher>\n    <dc:date>2000-06-06</dc:date>\n  </rdf:Description>\n</rdf:RDF>"
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



