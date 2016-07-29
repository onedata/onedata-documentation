
<a name="zoneclusterconfiguration"></a>
### ZoneClusterConfiguration
The zone cluster configuration.


|Name|Description|Schema|
|---|---|---|
|**databases**  <br>*required*||[ClusterDatabases](ClusterDatabases.md#clusterdatabases)|
|**domainName**  <br>*required*|The name of a domain common for all services in the cluster. Together with a node hostname constitute a node fully qualified domain name.|string|
|**managers**  <br>*required*||[ClusterManagers](ClusterManagers.md#clustermanagers)|
|**nodes**  <br>*required*|The collection of nodes aliases associated with nodes properties.|< string, [nodes](#zoneclusterconfiguration-nodes) > map|
|**workers**  <br>*required*||[ClusterWorkers](ClusterWorkers.md#clusterworkers)|

<a name="zoneclusterconfiguration-nodes"></a>
**nodes**

|Name|Description|Schema|
|---|---|---|
|**hostname**  <br>*required*|The name of a host.|string|



