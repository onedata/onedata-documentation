
<a name="zoneconfiguration"></a>
### ZoneConfiguration
The zone deployment configuration.


|Name|Description|Schema|
|---|---|---|
|**cluster**  <br>*required*||[ZoneClusterConfiguration](ZoneClusterConfiguration.md#zoneclusterconfiguration)|
|**onezone**  <br>*optional*|The zone custom configuration.|[onezone](#zoneconfiguration-onezone)|

<a name="zoneconfiguration-onezone"></a>
**onezone**

|Name|Description|Schema|
|---|---|---|
|**domainName**  <br>*optional*|The name of a HTTP domain.|string|
|**name**  <br>*optional*|The name of a zone.|string|

**Example**
```
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



