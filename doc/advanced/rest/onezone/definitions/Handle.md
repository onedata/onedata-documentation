
<a name="handle"></a>
### Handle
Handle properties.


|Name|Description|Schema|
|---|---|---|
|**handle**  <br>*optional*|The globally unique handle.|string|
|**handleId**  <br>*optional*|Unique ID the handle (internal to Onedata).|string|
|**handleServiceId**  <br>*optional*|ID of the service where the handle was registered.|string|
|**handleType**  <br>*optional*|Type of Handle (e.g. DOI, PID).|string|
|**metadata**  <br>*optional*|Dublin Core metadata for the resource encoded in XML.|string|
|**resourceId**  <br>*optional*|The Onedata GUID of the resource to which the handle should be resolved.|integer|

**Example**
```
{
  "handleId" : "2MTQwMTQ0CjAwMmZzaWduYXR1cmUg88",
  "handleType" : "DOI",
  "handle" : "10.572/test-handle-G9uZXpvbmUKMDAzYmlkZW50aWZpZXIgOEh/123",
  "resourceId" : "RsNk1CVHZTU3Z0OThwcHAhRN1NPawowMDFhY2lkIHRpbWUgPC",
  "handleServiceId" : "JKAxNWxvY2F0aW9uImSEFSSGdrbHFCa1pWST2OTQ4cz"
}
```



