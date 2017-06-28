
<a name="providerconfigurationdetails"></a>
### ProviderConfigurationDetails
The provider deployment configuration.


|Name|Description|Schema|
|---|---|---|
|**cluster**  <br>*required*||[ClusterConfigurationDetails](ClusterConfigurationDetails.md#clusterconfigurationdetails)|
|**oneprovider**  <br>*required*|The provider custom configuration.|[oneprovider](#providerconfigurationdetails-oneprovider)|

<a name="providerconfigurationdetails-oneprovider"></a>
**oneprovider**

|Name|Description|Schema|
|---|---|---|
|**name**  <br>*required*|The name of a provider.|string|

**Example**
```
{
  "cluster" : {
    "manager" : {
      "mainHost" : "node1.oneprovider.onedata.example.com",
      "hosts" : [ "node1.oneprovider.onedata.example.com" ]
    },
    "worker" : {
      "hosts" : [ "node1.oneprovider.onedata.example.com" ]
    },
    "database" : {
      "hosts" : [ "node1.oneprovider.onedata.example.com" ]
    }
  },
  "oneprovider" : {
    "name" : "example"
  }
}
```



