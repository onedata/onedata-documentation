
<a name="posix"></a>
### posix
The POSIX storage configuration.

*Polymorphism* : Inheritance  
*Discriminator* : type


|Name|Description|Schema|
|---|---|---|
|**id**  <br>*optional*|The ID of storage.|string|
|**insecure**  <br>*optional*|Defines whether storage administrator credentials (username and key) may be used by users without storage accounts to access storage in direct IO mode.  <br>**Default** : `false`|boolean|
|**lumaApiKey**  <br>*optional*|LUMA API Key, must be identical with API Key in external LUMA service.|string|
|**lumaCacheTimeout**  <br>*optional*|LUMA cache timeout in minutes.|integer|
|**lumaEnabled**  <br>*optional*|If true LUMA and reverse LUMA services will be enabled.  <br>**Default** : `false`|boolean|
|**lumaUrl**  <br>*optional*|URL of external LUMA service|string|
|**mountPoint**  <br>*required*|The absolute path to the directory where the POSIX storage is mounted on the cluster nodes.|string|
|**name**  <br>*optional*|The name of storage.|string|
|**readonly**  <br>*optional*|Defines whether storage is readonly.  <br>**Default** : `false`|boolean|
|**timeout**  <br>*optional*|Storage operation timeout in milliseconds.|integer|
|**type**  <br>*required*|The type of storage.|enum (posix, s3, ceph, swift, glusterfs)|



