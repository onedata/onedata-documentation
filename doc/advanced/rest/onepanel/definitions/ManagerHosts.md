
<a name="managerhosts"></a>
### ManagerHosts
The cluster manager service hosts configuration.


|Name|Description|Schema|
|---|---|---|
|**hosts**  <br>*required*|The list of hosts where service should be deployed.|< string > array|
|**mainHost**  <br>*required*|The name of a host where main cluster manager node should be deployed. Main cluster manager node is responsible for monitoring cluster worker nodes. Other nodes, called optional, are suspended. In case of main cluster manager node failure one of optional nodes is resumed and takes over main node responsibilities.|string|

**Example**
```
{
  "mainHost" : "node1.example.com",
  "hosts" : [ "node1.example.com", "node2.example.com", "node3.example.com" ]
}
```



