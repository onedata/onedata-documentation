
<a name="posix"></a>
### posix
*Polymorphism* : Inheritance  
*Discriminator* : type


|Name|Description|Schema|
|---|---|---|
|**gid**  <br>*required*|POSIX user group ID in the local system.|string|
|**name**  <br>*optional*|Name of storage.|string|
|**type**  <br>*required*|Type of storage.|enum (posix, ceph, s3, swift)|
|**uid**  <br>*required*|POSIX user ID in the local system.|string|



