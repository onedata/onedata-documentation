
<a name="providerconfiguration"></a>
### ProviderConfiguration
The provider deployment configuration.


|Name|Description|Schema|
|---|---|---|
|**cluster**  <br>*required*||[ProviderClusterConfiguration](ProviderClusterConfiguration.md#providerclusterconfiguration)|
|**oneprovider**  <br>*optional*|The provider custom configuration.|[oneprovider](#providerconfiguration-oneprovider)|
|**onezone**  <br>*optional*|The zone custom configuration.|[onezone](#providerconfiguration-onezone)|

<a name="providerconfiguration-oneprovider"></a>
**oneprovider**

|Name|Description|Schema|
|---|---|---|
|**geoLatitude**  <br>*optional*|The geographical latitude of the provider.|number(float)|
|**geoLongitude**  <br>*optional*|The geographical longitude of the provider.|number(float)|
|**name**  <br>*required*|The name under which the provider will be registered in a zone.|string|
|**redirectionPoint**  <br>*required*|The address used for user redirection from a zone to the provider.|string|
|**register**  <br>*required*|Defines whether the provider should be registered in a zone.|boolean|

<a name="providerconfiguration-onezone"></a>
**onezone**

|Name|Description|Schema|
|---|---|---|
|**domainName**  <br>*required*|The domain name of a zone where provider will be registered.|string|

**Example**
```
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



