
<a name="ceph"></a>
### ceph
*Polymorphism* : Inheritance  
*Discriminator* : type


|Name|Description|Schema|
|---|---|---|
|**key**  <br>*required*|Ceph user key.|string|
|**name**  <br>*optional*|Name of storage.|string|
|**type**  <br>*required*|Type of storage.|enum (posix, ceph, s3, swift)|
|**username**  <br>*required*|Ceph user name.|string|



