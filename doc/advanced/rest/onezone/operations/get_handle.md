
<a name="get_handle"></a>
#### Get handle
```
GET /handles/{hndl}
```


##### Description
Returns the properties of a specific handle.

This operation requires `view_handle` privilege.

***Example cURL requests***

**Get handle**
```bash
curl -u username:password -X GET \
https://$HOST:8443/api/v3/handles/oOVF-KrO1P6rpA0LFgNVI8NxuhxyQMUnrYzjAnKiyAY

{
  "handleId": "oOVF-KrO1P6rpA0LFgNVI8NxuhxyQMUnrYzjAnKiyAY",
  "handleServiceId": "ASKDGHKAJSHDukjhasdlkjalksjd76876asdkb",
  "resourceType": "Share",
  "resourceId": "dlkjalkADKDGHKAJSHDukjhassjd76876asdkb",
  "metadata": "<?xml version=\"1.0\"?>
      <!DOCTYPE rdf:RDF SYSTEM \\"http://dublincore.org/2000/12/01-dcmes-xml-dtd.dtd\">
      <rdf:RDF xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\"
               xmlns:dc=\"http://purl.org/dc/elements/1.1/\">
        <rdf:Description rdf:about=\"http://example.com/resouces/1\">
          <dc:title>Example Resource</dc:title>
          <dc:creator>John Doe</dc:creator>
          <dc:publisher>MIT</dc:publisher>
          <dc:date>2000-06-06</dc:date>
        </rdf:Description>
      </rdf:RDF>",
  "timestamp": "1997-07-16T19:20"
}
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**hndl**  <br>*required*|The handle ID (internal Onedata GUID) of the identifier.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The properties of a specific handle.|[Handle](../definitions/Handle.md#handle)|
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
"/handles/string"
```


##### Example HTTP response

###### Response 200
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



