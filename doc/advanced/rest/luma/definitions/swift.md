
<a name="swift"></a>
### swift
*Polymorphism* : Inheritance  
*Discriminator* : type


|Name|Description|Schema|
|---|---|---|
|**id**  <br>*required*|Storage Id.|string|
|**password**  <br>*required*|OpenStack Keystone user password.|string|
|**type**  <br>*required*|Type of storage.|enum (posix, ceph, s3, swift, glusterfs)|
|**username**  <br>*required*|OpenStack Keystone user name.|string|



