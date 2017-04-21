
<a name="share"></a>
### Share
Share parameters.


|Name|Description|Schema|
|---|---|---|
|**handleId**  <br>*optional*|The Id of open data Handle (e.g. DOI or PID) assigned to this share.|string|
|**name**  <br>*required*|The user defined name for the share.|string|
|**publicUrl**  <br>*required*|The publicly accessible URL for the share.|string|
|**rootFileId**  <br>*required*|The ID of the shared file or folder.|string|
|**shareId**  <br>*required*|Share ID.|string|
|**spaceId**  <br>*required*|The ID of the space in which the share was created.|string|

**Example**
```
{
  "shareId" : "8asd89asdlbKJSBD79a8sdkLKJH8asdkjasd8989",
  "name" : "MyNewShare",
  "publicUrl" : "https://onedata.org/shares/ASDLKJH8asdkjasd89898asd89asdlbKJSBDikjab89-asdmASD",
  "rootFileId" : "ASDkjlkkasdjoiwnafldnacbaasd8879a8sdkjb",
  "spaceId" : "LKJH8asdkjasd89898asd89asdlbKJSBD79a8sdk",
  "handleId" : "doi:10.15911/MyShares.726855"
}
```



