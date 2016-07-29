
<a name="put_zone_configuration"></a>
#### Create zone deployment
```
PUT /zone/configuration
```


##### Description
Configures and starts zone services, such as database, cluster manager
and cluster worker.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Body**|**zoneConfiguration**  <br>*required*||[ZoneConfiguration](../definitions/ZoneConfiguration.md#zoneconfiguration)|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|Deployment process successfully started.  <br>**Headers** :   <br>`Location` (string) : The path to the task resource, which can be queried  to check operation status.|No Content|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|No Content|
|**500**|Internal server error.|No Content|


##### Consumes

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/zone/configuration"
```


###### Request body
```
json :
{
  "cluster" : {
    "domainName" : "onezone.onedata.example.com",
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
    }
  },
  "onezone" : {
    "name" : "example"
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



