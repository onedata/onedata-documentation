
<a name="ceph"></a>
### Ceph
*Polymorphism* : Inheritance  
*Discriminator* : type


|Name|Description|Schema|
|---|---|---|
|**type**  <br>*required*|Type of storage.|enum (Posix, Ceph, S3, Swift)|
|**userKey**  <br>*optional*|Ceph user key.|string|
|**userName**  <br>*optional*|Ceph user name.|string|



