
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
    "domainName" : "string",
    "nodes" : {
      "string" : "object"
    },
    "databases" : {
      "nodes" : [ "string" ]
    },
    "managers" : {
      "mainNode" : "string",
      "nodes" : [ "string" ]
    },
    "workers" : {
      "nodes" : [ "string" ]
    },
    "storages" : {
      "string" : "[clusterstorages](#clusterstorages)"
    }
  },
  "oneprovider" : "object",
  "onezone" : "object"
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



