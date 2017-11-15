
<a name="glusterfs"></a>
### glusterfs
*Polymorphism* : Inheritance  
*Discriminator* : type


|Name|Description|Schema|
|---|---|---|
|**aclName**  <br>*optional*|User ACL name.|string|
|**caCertificate**  <br>*optional*|The certificate of the CA signing the user certificate. Must include the entire necessary chain of trust, and the GlusterFS server must trust this CA.|string|
|**certificate**  <br>*optional*|User certificate in PEM format. The value must be formatted properly (including newlines) in PEM format.|string|
|**gid**  <br>*optional*|POSIX user group ID in the GlusterFS server.|integer|
|**key**  <br>*optional*|User private key for certificate in PEM format.|string|
|**storageId**  <br>*optional*|Storage Id. Either storageId or storageName are required.|string|
|**storageName**  <br>*optional*|Storage name. Either storageId or storageName are required.|string|
|**type**  <br>*required*|Type of storage.|enum (posix, ceph, s3, swift, glusterfs)|
|**uid**  <br>*optional*|POSIX user ID in the GlusterFS server.|integer|


