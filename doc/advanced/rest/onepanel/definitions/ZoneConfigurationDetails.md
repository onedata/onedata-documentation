
<a name="zoneconfigurationdetails"></a>
### ZoneConfigurationDetails
The zone cluster configuration.


|Name|Description|Schema|
|---|---|---|
|**cluster**  <br>*required*||[ClusterConfigurationDetails](ClusterConfigurationDetails.md#clusterconfigurationdetails)|
|**onezone**  <br>*required*|The zone custom configuration.|[onezone](#zoneconfigurationdetails-onezone)|

<a name="zoneconfigurationdetails-onezone"></a>
**onezone**

|Name|Description|Schema|
|---|---|---|
|**name**  <br>*required*|The name of a zone.|string|

**Example**
```
{
  "cluster" : {
    "manager" : {
      "mainHost" : "node1.onezone.onedata.example.com",
      "hosts" : [ "node1.onezone.onedata.example.com" ]
    },
    "worker" : {
      "hosts" : [ "node1.onezone.onedata.example.com" ]
    },
    "database" : {
      "hosts" : [ "node1.onezone.onedata.example.com" ]
    }
  },
  "onezone" : {
    "name" : "example"
  }
}
```



