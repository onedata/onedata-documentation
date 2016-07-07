
<a name="servicesstatus"></a>
### ServicesStatus
Provides status information about multiple services.


|Name|Description|Schema|
|---|---|---|
|**results**  <br>*optional*||< [results](#servicesstatus-results) > array|
|**service**  <br>*optional*|The type of service.<br>* oz_worker - an instance of Onezone worker process<br>* op_worker - an instance of Oneprovider worker process<br>* cluster_manager - an instance of ClusterManager process<br>* couchbase - an instance of Couchbase metadata database|enum (op_worker, oz_worker, cluster_manager, couchbase)|

<a name="servicesstatus-results"></a>
**results**

|Name|Description|Schema|
|---|---|---|
|**host**  <br>*optional*|The host where the service instance is deployed.|string|
|**result**  <br>*optional*|The status of the service instance on this host.|enum (ok, error)|

**Example**
```
{
  "service" : "op_worker",
  "results" : [ {
    "host" : "h1.example.com",
    "result" : "ok"
  }, {
    "host" : "h2.example.com",
    "result" : "error"
  }, {
    "host" : "h3.example.com",
    "result" : "ok"
  } ]
}
```



