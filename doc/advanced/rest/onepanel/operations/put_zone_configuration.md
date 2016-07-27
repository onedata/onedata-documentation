
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
|**204**|Deployment process successfully started.  <br>**Headers** :   <br>`Location` (string) : The path to the task resource, which can be queried to check<br>operation status.|No Content|
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
    }
  },
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



