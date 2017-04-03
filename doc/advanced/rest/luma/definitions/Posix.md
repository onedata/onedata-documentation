
<a name="posix"></a>
### Posix
*Polymorphism* : Inheritance  
*Discriminator* : type


|Name|Description|Schema|
|---|---|---|
|**gid**  <br>*required*|POSIX user group ID in the local system.|string|
|**type**  <br>*required*|Type of storage.|enum (Posix, Ceph, S3, Swift)|
|**uid**  <br>*required*|POSIX user ID in the local system.|string|



