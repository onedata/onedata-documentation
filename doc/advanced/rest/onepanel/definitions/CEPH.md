
<a name="ceph"></a>
### CEPH
*Polymorphism* : Inheritance  
*Discriminator* : type


|Name|Description|Schema|
|---|---|---|
|**clusterName**  <br>*optional*|Cluster name.|string|
|**key**  <br>*optional*|The key to access the Ceph resource.|string|
|**monitorHostname**  <br>*optional*|Monitor host name.|string|
|**type**  <br>*required*|Type of storage resource|enum (POSIX, S3, CEPH)|
|**username**  <br>*optional*|The username for authentication to Ceph.|string|



