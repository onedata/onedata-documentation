
<a name="swift"></a>
### Swift
The OpenStack Swift configuration.

*Polymorphism* : Inheritance  
*Discriminator* : type


|Name|Description|Schema|
|---|---|---|
|**authUrl**  <br>*required*|The URL to OpenStack Keystone identity service.|string|
|**blockSize**  <br>*optional*|Storage block size in bytes.|integer|
|**containerName**  <br>*required*|The name of the Swift storage container.|string|
|**insecure**  <br>*optional*|Defines whether storage administrator credentials (username and password) may be used by users without storage accounts to access storage in direct IO mode.  <br>**Default** : `false`|boolean|
|**password**  <br>*required*|The Keystone authentication password.|string|
|**readonly**  <br>*optional*|Defines whether storage is readonly.  <br>**Default** : `false`|boolean|
|**tenantName**  <br>*required*|The name of the tenant to which the user belongs.|string|
|**timeout**  <br>*optional*|Storage operation timeout in milliseconds.|integer|
|**type**  <br>*required*|The type of storage.|enum (POSIX, S3, Ceph, Swift)|
|**username**  <br>*required*|The Keystone authentication username.|string|



