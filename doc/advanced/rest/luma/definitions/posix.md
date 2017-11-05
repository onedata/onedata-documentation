
<a name="posix"></a>
### posix
*Polymorphism* : Inheritance  
*Discriminator* : type


|Name|Description|Schema|
|---|---|---|
|**gid**  <br>*optional*|POSIX user group ID in the local system.|string|
|**name**  <br>*optional*|Username for POSIX compatible ACL's.|string|
|**storageId**  <br>*optional*|Storage Id. Either storageId or storageName are required.|string|
|**storageName**  <br>*optional*|Storage name. Either storageId or storageName are required.|string|
|**type**  <br>*required*|Type of storage.|enum (posix, ceph, s3, swift, glusterfs)|
|**uid**  <br>*optional*|POSIX user ID in the local system.|string|



