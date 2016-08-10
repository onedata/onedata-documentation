
<a name="swift"></a>
### Swift
The OpenStack Swift configuration.

*Polymorphism* : Inheritance  
*Discriminator* : type


|Name|Description|Schema|
|---|---|---|
|**authUrl**  <br>*required*|The URL to OpenStack Keystone identity service.|string|
|**containerName**  <br>*required*|The name of the Swift storage container.|string|
|**password**  <br>*required*|The Keystone authentication password.|string|
|**tenantName**  <br>*required*|The name of the tenant to which the user belongs.|string|
|**type**  <br>*required*|The type of storage.|enum (POSIX, S3, Ceph, Swift)|
|**username**  <br>*required*|The Keystone authentication username.|string|



