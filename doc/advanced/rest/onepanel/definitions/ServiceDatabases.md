
<a name="servicedatabases"></a>
### ServiceDatabases
The service hosts configuration.


|Name|Description|Schema|
|---|---|---|
|**bucketQuota**  <br>*optional*|The bucket quota is the amount of RAM memory in bytes allocated to an individual bucket for caching data.|integer|
|**hosts**  <br>*required*|The list of hosts where service should be deployed.|< string > array|
|**serverQuota**  <br>*optional*|The server quota is the RAM memory in bytes that is allocated to the server when Couchbase Server is first installed. This sets the limit of RAM allocated by Couchbase for caching data for all buckets and is configured on a per-node basis.|integer|

**Example**
```
{
  "hosts" : [ "node1.example.com", "node2.example.com", "node3.example.com" ]
}
```



