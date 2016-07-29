
<a name="providerclusterconfiguration"></a>
### ProviderClusterConfiguration
The provider cluster configuration.


|Name|Description|Schema|
|---|---|---|
|**databases**  <br>*required*||[ClusterDatabases](ClusterDatabases.md#clusterdatabases)|
|**domainName**  <br>*required*|The name of a domain common for all services in the cluster. Together with a node hostname constitutes a fully qualified domain name (FDQN) of the node.|string|
|**managers**  <br>*required*||[ClusterManagers](ClusterManagers.md#clustermanagers)|
|**nodes**  <br>*required*|The collection of nodes aliases associated with nodes properties.|< string, [nodes](#providerclusterconfiguration-nodes) > map|
|**storages**  <br>*optional*|The cluster storage configuration.|< string, [ClusterStorages](ClusterStorages.md#clusterstorages) > map|
|**workers**  <br>*required*||[ClusterWorkers](ClusterWorkers.md#clusterworkers)|

<a name="providerclusterconfiguration-nodes"></a>
**nodes**

|Name|Description|Schema|
|---|---|---|
|**hostname**  <br>*required*|The name of a host.|string|



