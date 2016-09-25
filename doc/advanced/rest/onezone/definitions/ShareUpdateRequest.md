
<a name="shareupdaterequest"></a>
### ShareUpdateRequest
Share parameters.


|Name|Description|Schema|
|---|---|---|
|**name**  <br>*optional*|The user defined name for the share.|string|
|**parentSpace**  <br>*optional*|The ID of the space in which the share was created.|string|
|**publicUrl**  <br>*optional*|The publicly accessible URL for the share.|string|
|**rootFileId**  <br>*optional*|The ID of the shared file or folder.|string|
|**shareId**  <br>*optional*|Share ID.|string|

**Example**
```
{
  "shareId" : null,
  "name" : "MyNewShare",
  "publicUrl" : "https://onedata.org/shares/ASDLKJH8asdkjasd89898asd89asdlbKJSBDikjab89-asdmASD",
  "rootFileId" : "ASDkjlkkasdjoiwnafldnacbaasd8879a8sdkjb",
  "parentSpace" : "LKJH8asdkjasd89898asd89asdlbKJSBD79a8sdk"
}
```



