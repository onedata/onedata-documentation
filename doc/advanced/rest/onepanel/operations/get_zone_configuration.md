
<a name="get_zone_configuration"></a>
#### Get zone cluster configuration
```
GET /zone/configuration
```


##### Description
Returns the zone cluster configuration.


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The zone cluster configuration.|[ZoneConfiguration](../definitions/ZoneConfiguration.md#zoneconfiguration)|
|**401**|Unauthorized request.|No Content|
|**403**|Forbidden request.|No Content|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


##### Produces

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/zone/configuration"
```


##### Example HTTP response

###### Response 200
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


###### Response 500
```
json :
{
  "error" : "Invalid Request",
  "description" : "User role must be one of 'admin' or 'regular'."
}
```



