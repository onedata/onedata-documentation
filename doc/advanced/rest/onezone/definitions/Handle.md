
<a name="handle"></a>
### Handle
Handle properties.


|Name|Description|Schema|
|---|---|---|
|**handleId**  <br>*optional*|Unique ID the handle (internal to Onedata).|string|
|**handleServiceId**  <br>*optional*|ID of the service where the handle was registered.|string|
|**metadata**  <br>*optional*|Dublin Core metadata for the resource encoded in XML.|string|
|**resourceId**  <br>*optional*|The Onedata GUID of the resource to which the handle should be resolved.|integer|
|**resourceType**  <br>*optional*|The type of resource to be registered.|enum (Share)|
|**timestamp**  <br>*optional*|Handle registration timestamp.|string|

**Example**
```
{
  "handleId" : "10.572/test-handle-G9uZXpvbmUKMDAzYmlkZW50aWZpZXIgOEh/123",
  "resourceType" : "Share",
  "resourceId" : "RsNk1CVHZTU3Z0OThwcHAhRN1NPawowMDFhY2lkIHRpbWUgPC",
  "handleServiceId" : "JKAxNWxvY2F0aW9uImSEFSSGdrbHFCa1pWST2OTQ4cz",
  "metadata" : "<?xml version=\\\"1.0\\\"?> <!DOCTYPE rdf:RDF SYSTEM \\\\\"http://dublincore.org/2000/12/01-dcmes-xml-dtd.dtd\\\"> <rdf:RDF xmlns:rdf=\\\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\\\"\n         xmlns:dc=\\\"http://purl.org/dc/elements/1.1/\\\">\n  <rdf:Description rdf:about=\\\"http://example.com/resouces/1\\\">\n    <dc:title>Example Resource</dc:title>\n    <dc:creator>John Doe</dc:creator>\n    <dc:publisher>MIT</dc:publisher>\n    <dc:date>2000-06-06</dc:date>\n  </rdf:Description>\n</rdf:RDF>\n",
  "timestamp" : "2016-07-16T18:20:30.450Z"
}
```



