
<a name="get_provider_configuration"></a>
#### Get provider cluster configuration
```
GET /provider/configuration
```


##### Description
Returns the provider cluster configuration.


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The provider cluster configuration.|[ProviderConfiguration](../definitions/ProviderConfiguration.md#providerconfiguration)|
|**401**|Unauthorized request.|No Content|
|**403**|Forbidden request.|No Content|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


##### Produces

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/provider/configuration"
```


##### Example HTTP response

###### Response 200
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


###### Response 500
```
json :
{
  "error" : "Invalid Request",
  "description" : "User role must be one of 'admin' or 'regular'."
}
```



