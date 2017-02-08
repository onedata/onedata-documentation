
<a name="ceph"></a>
### Ceph
*Polymorphism* : Inheritance  
*Discriminator* : type


|Name|Description|Schema|
|---|---|---|
|**key**  <br>*required*|Ceph user key.|string|
|**type**  <br>*required*|Type of storage.|enum (Posix, Ceph, S3, Swift)|
|**username**  <br>*required*|Ceph user name.|string|



