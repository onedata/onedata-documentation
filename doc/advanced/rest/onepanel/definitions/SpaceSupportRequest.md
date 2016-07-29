
<a name="spacesupportrequest"></a>
### SpaceSupportRequest
The configuration details required to create or support a space by a provider.


|Name|Description|Schema|
|---|---|---|
|**name**  <br>*optional*|The space name. If this property is provided and space with given name will be created and automatically supported by a provider.|string|
|**size**  <br>*required*|The storage space size in bytes that provider is willing to assign to the space.|integer|
|**storageId**  <br>*optional*|The ID of the storage resource where the space data should be stored. To be used interchangeably with `storageName`.|string|
|**storageName**  <br>*optional*|The user defined name of the storage resource, where the space data should be stored. To be used interchangeably with `storageId`.|string|
|**token**  <br>*required*|The token for space creation or support.|string|

**Example**
```
{
  "name" : "MySpace1",
  "token" : "ASDJNASD87687ASDMNBMNASD87786asd",
  "size" : 1024000
}
```



