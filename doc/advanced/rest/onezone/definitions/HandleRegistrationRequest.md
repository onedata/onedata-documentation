
<a name="handleregistrationrequest"></a>
### HandleRegistrationRequest
This type contains attributes necessary to register a handle identifier
for some Onedata resource (e.g. share).


|Name|Description|Schema|
|---|---|---|
|**handleServiceId**  <br>*required*|The Onedata GUID of the handle service registered.|string|
|**metadata**  <br>*required*|Dublin Core metadata for the resource encoded in XML.|string|
|**resourceId**  <br>*required*|The ID of the resource to be assigned a handle identifier.|string|
|**resourceType**  <br>*required*|The type of resource to be registered.|string|

**Example**
```
{
  "handleServiceId" : "ALKJSDH77i79ASDKJA-ASDBAS9-87",
  "resourceType" : "Share",
  "resourceId" : "LKJAHSDA796IASDKBjkhaksjdk568787asdhjbasd",
  "metadata" : "<?xml version=\\\"1.0\\\"?> <!DOCTYPE rdf:RDF SYSTEM \\\\\"http://dublincore.org/2000/12/01-dcmes-xml-dtd.dtd\\\"> <rdf:RDF xmlns:rdf=\\\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\\\"\n         xmlns:dc=\\\"http://purl.org/dc/elements/1.1/\\\">\n  <rdf:Description rdf:about=\\\"http://example.com/resouces/1\\\">\n    <dc:title>Example Resource</dc:title>\n    <dc:creator>John Doe</dc:creator>\n    <dc:publisher>MIT</dc:publisher>\n    <dc:date>2000-06-06</dc:date>\n  </rdf:Description>\n</rdf:RDF>"
}
```



