
<a name="swift"></a>
### swift
*Polymorphism* : Inheritance  
*Discriminator* : type


|Name|Description|Schema|
|---|---|---|
|**aclName**  <br>*optional*|User ACL name.|string|
|**password**  <br>*optional*|OpenStack Keystone user password.|string|
|**storageId**  <br>*optional*|Storage Id. Either storageId or storageName are required.|string|
|**storageName**  <br>*optional*|Storage name. Either storageId or storageName are required.|string|
|**type**  <br>*required*|Type of storage.|enum (posix, ceph, s3, swift, glusterfs)|
|**username**  <br>*required*|OpenStack Keystone user name.|string|



