
<a name="posix"></a>
### posix
*Polymorphism* : Inheritance  
*Discriminator* : type


|Name|Description|Schema|
|---|---|---|
|**gid**  <br>*optional*|POSIX user group ID in the local system.|string|
|**id**  <br>*required*|Storage Id.|string|
|**name**  <br>*optional*|Username for POSIX compatible ACL's.|string|
|**type**  <br>*required*|Type of storage.|enum (posix, ceph, s3, swift, glusterfs)|
|**uid**  <br>*optional*|POSIX user ID in the local system.|string|



