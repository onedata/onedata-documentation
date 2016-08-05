
<a name="posix"></a>
### Posix
*Polymorphism* : Inheritance  
*Discriminator* : type


|Name|Description|Schema|
|---|---|---|
|**gid**  <br>*optional*|POSIX user group ID in the local system.|string|
|**type**  <br>*required*|Type of storage.|enum (Posix, Ceph, S3, Swift)|
|**uid**  <br>*optional*|POSIX user ID in the local system.|string|



