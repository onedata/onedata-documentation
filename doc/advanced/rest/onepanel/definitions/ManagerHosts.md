
<a name="managerhosts"></a>
### ManagerHosts
The cluster manager service hosts configuration.


|Name|Description|Schema|
|---|---|---|
|**hosts**  <br>*required*|The list of service hosts.|< string > array|
|**mainHost**  <br>*required*|The main cluster manager host. Main cluster manager node is responsible for monitoring cluster worker nodes. Other nodes, which are redundant, are suspended. In case of main cluster manager node failure one of redundant nodes is resumed and takes over main node responsibilities.|string|

**Example**
```
{
  "mainHost" : "node1.example.com",
  "hosts" : [ "node1.example.com", "node2.example.com", "node3.example.com" ]
}
```



