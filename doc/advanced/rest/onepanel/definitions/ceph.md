
<a name="ceph"></a>
### ceph
The Ceph storage configuration.

*Polymorphism* : Inheritance  
*Discriminator* : type


|Name|Description|Schema|
|---|---|---|
|**clusterName**  <br>*required*|The Ceph cluster name.|string|
|**id**  <br>*optional*|The ID of storage.|string|
|**insecure**  <br>*optional*|Defines whether storage administrator credentials (username and key) may be used by users without storage accounts to access storage in direct IO mode.  <br>**Default** : `false`|boolean|
|**key**  <br>*required*|The admin key to access the Ceph cluster.|string|
|**monitorHostname**  <br>*required*|The monitor host name.|string|
|**name**  <br>*optional*|The name of storage.|string|
|**poolName**  <br>*required*|The Ceph pool name.|string|
|**readonly**  <br>*optional*|Defines whether storage is readonly.  <br>**Default** : `false`|boolean|
|**timeout**  <br>*optional*|Storage operation timeout in milliseconds.|integer|
|**type**  <br>*required*|The type of storage.|enum (posix, s3, ceph, swift, glusterfs)|
|**username**  <br>*required*|The username of the Ceph cluster administrator.|string|



