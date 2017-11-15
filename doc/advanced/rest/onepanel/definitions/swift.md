
<a name="swift"></a>
### swift
The OpenStack Swift configuration.

*Polymorphism* : Inheritance  
*Discriminator* : type


|Name|Description|Schema|
|---|---|---|
|**authUrl**  <br>*required*|The URL to OpenStack Keystone identity service.|string|
|**blockSize**  <br>*optional*|Storage block size in bytes.|integer|
|**containerName**  <br>*required*|The name of the Swift storage container.|string|
|**id**  <br>*optional*|The ID of storage.|string|
|**insecure**  <br>*optional*|Defines whether storage administrator credentials (username and password) may be used by users without storage accounts to access storage in direct IO mode.  <br>**Default** : `false`|boolean|
|**lumaApiKey**  <br>*optional*|LUMA API Key, must be identical with API Key in external LUMA service.|string|
|**lumaCacheTimeout**  <br>*optional*|LUMA cache timeout in minutes.|integer|
|**lumaEnabled**  <br>*optional*|If true LUMA and reverse LUMA services will be enabled.  <br>**Default** : `false`|boolean|
|**lumaUrl**  <br>*optional*|URL of external LUMA service|string|
|**name**  <br>*optional*|The name of storage.|string|
|**password**  <br>*required*|The Keystone authentication password.|string|
|**readonly**  <br>*optional*|Defines whether storage is readonly.  <br>**Default** : `false`|boolean|
|**tenantName**  <br>*required*|The name of the tenant to which the user belongs.|string|
|**timeout**  <br>*optional*|Storage operation timeout in milliseconds.|integer|
|**type**  <br>*required*|The type of storage.|enum (posix, s3, ceph, swift, glusterfs)|
|**username**  <br>*required*|The Keystone authentication username.|string|


