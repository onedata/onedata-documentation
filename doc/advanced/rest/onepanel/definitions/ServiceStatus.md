
<a name="servicestatus"></a>
### ServiceStatus
Provides status information on requested service.


|Name|Description|Schema|
|---|---|---|
|**result**  <br>*optional*|The service status.|enum (ok, error)|
|**service**  <br>*optional*|The type of service.<br>* oz_worker - an instance of Onezone worker process<br>* op_worker - an instance of Oneprovider worker process<br>* cluster_manager - an instance of ClusterManager process<br>* couchbase - an instance of Couchbase metadata database|enum (op_worker, oz_worker, cluster_manager, couchbase)|

**Example**
```
{
  "service" : "op_worker",
  "result" : "ok"
}
```



