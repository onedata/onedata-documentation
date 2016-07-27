
<a name="posix"></a>
### POSIX
*Polymorphism* : Inheritance  
*Discriminator* : type


|Name|Description|Schema|
|---|---|---|
|**mountPoint**  <br>*required*|The absolute path to the directory where the POSIX storage is mounted<br>on the cluster nodes.|string|
|**type**  <br>*required*|The type of a storage.|enum (POSIX, S3, CEPH)|



