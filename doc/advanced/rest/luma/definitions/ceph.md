
<a name="ceph"></a>
### ceph
*Polymorphism* : Inheritance  
*Discriminator* : type


|Name|Description|Schema|
|---|---|---|
|**id**  <br>*required*|Storage Id.|string|
|**key**  <br>*required*|Ceph user key.|string|
|**type**  <br>*required*|Type of storage.|enum (posix, ceph, s3, swift, glusterfs)|
|**username**  <br>*required*|Ceph user name.|string|



