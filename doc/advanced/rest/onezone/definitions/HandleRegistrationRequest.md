
<a name="handleregistrationrequest"></a>
### HandleRegistrationRequest
This type contains attributes necessary to register a handle identifier
for some Onedata resource (e.g. share).


|Name|Description|Schema|
|---|---|---|
|**handleServiceId**  <br>*required*|The Onedata GUID of the handle service registered.|string|
|**metadata**  <br>*optional*|Dublin Core metadata for the resource encoded in XML.|string|
|**resourceId**  <br>*required*|The ID of the resource to be assigned a handle identifier.|string|
|**resourceType**  <br>*required*|The type of resource to be registered.|string|

**Example**
```
{
  "handleServiceId" : "ALKJSDH77i79ASDKJA-ASDBAS9-87",
  "resourceType" : "Share",
  "resourceId" : "LKJAHSDA796IASDKBjkhaksjdk568787asdhjbasd"
}
```



