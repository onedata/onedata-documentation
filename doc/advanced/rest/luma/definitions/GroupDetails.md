
<a name="groupdetails"></a>
### GroupDetails
Group storage identity.


|Name|Description|Schema|
|---|---|---|
|**aclName**  <br>*optional*|Group ACL name.|string|
|**gid**  <br>*optional*|Group Id on the storage.|integer|
|**spaceId**  <br>*optional*|Space id in the context of which the request is performed.|string|
|**storageId**  <br>*optional*|Storage ID (site specific).|string|
|**storageName**  <br>*optional*|Storage Name (site specific).|string|

**Example**
```
{
  "storageId" : "Assdwe897Dsdjhx9",
  "storageName" : "NFS",
  "gid" : 1001,
  "aclName" : "users"
}
```



