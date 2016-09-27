
<a name="clusterdatabases"></a>
### ClusterDatabases
The cluster database service configuration.


|Name|Description|Schema|
|---|---|---|
|**bucketQuota**  <br>*optional*|The bucket quota is the amount of RAM memory in bytes allocated to an individual bucket for caching data.|integer|
|**nodes**  <br>*required*|The list of aliases of cluster database nodes.|< string > array|
|**serverQuota**  <br>*optional*|The server quota is the RAM memory in bytes that is allocated to the server when Couchbase Server is first installed. This sets the limit of RAM allocated by Couchbase for caching data for all buckets and is configured on a per-node basis.|integer|



