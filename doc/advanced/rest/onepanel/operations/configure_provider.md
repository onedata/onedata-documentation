
<a name="configure_provider"></a>
#### Configure provider deployment
```
POST /provider/configuration
```


##### Description
Configures and starts provider services, such as database, cluster manager and cluster worker. Depending on the configuration, sets up provider storage and registers in the zone.
This request can be executed unauthorized as long as there are no admin users.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Body**|**providerConfiguration**  <br>*required*|The provider configuration description.|[ProviderConfiguration](../definitions/ProviderConfiguration.md#providerconfiguration)|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**201**|Deployment process successfully started.  <br>**Headers** :   <br>`Location` (string) : The path to the task resource, which can be queried to check operation status.|No Content|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|No Content|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


##### Consumes

* `application/json`
* `application/x-yaml`


##### Example HTTP request

###### Request path
```
json :
"/provider/configuration"
```


###### Request body
```
json :
{
  "cluster" : {
    "domainName" : "oneprovider.onedata.example.com",
    "nodes" : {
      "node1" : {
        "hostname" : "node1"
      }
    },
    "manager" : {
      "mainNode" : "node1",
      "nodes" : [ "node1" ]
    },
    "worker" : {
      "nodes" : [ "node1" ]
    },
    "database" : {
      "nodes" : [ "node1" ]
    },
    "storage" : {
      "NFS" : {
        "type" : "posix",
        "mountPoint" : "/volumes/storage"
      }
    }
  },
  "oneprovider" : {
    "register" : true,
    "name" : "example",
    "redirectionPoint" : "https://node1.oneprovider.onedata.example.com",
    "geoLongitude" : -24.3776025,
    "geoLatitude" : -128.3519364
  },
  "onezone" : {
    "domainName" : "node1.onezone.onedata.example.com"
  }
}
```


##### Example HTTP response

###### Response 400
```
json :
{
  "error" : "Invalid Request",
  "description" : "User role must be one of 'admin' or 'regular'."
}
```


###### Response 500
```
json :
{
  "error" : "Invalid Request",
  "description" : "User role must be one of 'admin' or 'regular'."
}
```



