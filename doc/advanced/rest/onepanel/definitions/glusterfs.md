
<a name="glusterfs"></a>
### glusterfs
The GlusterFS storage configuration.

*Polymorphism* : Inheritance  
*Discriminator* : type


|Name|Description|Schema|
|---|---|---|
|**hostname**  <br>*required*|The hostname (IP address or FQDN) of GlusterFS volume server.|string|
|**id**  <br>*optional*|The ID of storage.|string|
|**insecure**  <br>*optional*|Defines whether storage administrator credentials (username and key) may be used by users without storage accounts to access storage in direct IO mode.  <br>**Default** : `false`|boolean|
|**mountPoint**  <br>*optional*|Relative mountpoint within the volume which should be used by Oneprovider.  <br>**Default** : `""`|string|
|**name**  <br>*optional*|The name of storage.|string|
|**port**  <br>*optional*|The GlusterFS port on volume server.|integer|
|**readonly**  <br>*optional*|Defines whether storage is readonly.  <br>**Default** : `false`|boolean|
|**timeout**  <br>*optional*|Storage operation timeout in milliseconds.|integer|
|**transport**  <br>*optional*|The transport protocol to use to connect to the volume server.  <br>**Default** : `"tcp"`|enum (tcp, rdma, socket)|
|**type**  <br>*required*|The type of storage.|enum (posix, s3, ceph, swift, glusterfs)|
|**volume**  <br>*required*|The name of the volume to use as a storage backend.|string|
|**xlatorOptions**  <br>*optional*|Volume specific GlusterFS translator options, in the format:<br>  TRANSLATOR1.OPTION1=VALUE1;TRANSLATOR2.OPTION2=VALUE2;...  <br>**Default** : `""`|string|



