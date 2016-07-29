
<a name="put_provider_configuration"></a>
#### Configure provider deployment
```
PUT /provider/configuration
```


##### Description
Configures and starts provider services, such as database, cluster manager
and cluster worker. Depending on the configuration, sets up provider storage
and registers in the zone.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Body**|**providerConfiguration**  <br>*required*||[ProviderConfiguration](../definitions/ProviderConfiguration.md#providerconfiguration)|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|Deployment process successfully started.  <br>**Headers** :   <br>`Location` (string) : The path to the task resource, which can be queried to check operation status.|No Content|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|No Content|
|**500**|Internal server error.|No Content|


##### Consumes

* `application/json`


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
      "defaultNode" : "node1",
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
        "type" : "POSIX",
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
  "error" : "Authentication Error",
  "description" : "Invalid username or password."
}
```



