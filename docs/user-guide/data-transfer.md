# Transfer

[toc][]

Transfer is a process of data movement between providers. This operation is 
asynchronous and it can take a long time depending on the size of the data 
to move.

Types of transfers:

1. replication - process of copying data to achieve a complete replica in 
    destination provider. The data will be copied from one or more providers 
    in the space that hold replicas or some fragments. 
    >**NOTE:** This operation requires `space_schedule_replication` privilege.

2. eviction - process of removing replica(s) from provider specified. This 
    operation is safe and will succeed only if there exist at least one file 
    replica on other providers suporting the space. 
    >**NOTE:** This operation requires `space_schedule_eviction privilege` privilege.
    
3. migration - replication followed by eviction. 
    >**NOTE:** This operation requires both `space_schedule_replication` and 
    `space_schedule_eviction` privileges.


## Web GUI

<!-- TODO add -->
<!-- Web interface provides visual information on the current replication of each file among the storage providers supporting the user space in which this file is located. The information is visible in the Data distribution window. It can be used to perform all of the operations mentioned in the previous section. Screenshot of the sample data distribution window is presented in the image below:

Using GUI

In order to initiate a transfer, simply select the Data distribution icon in the top menu of the file browser of Oneprovider and select the target provider:

Transfers can be conveniently managed and monitored using Oneprovider GUI. For each space, under tab Transfers on the left a dedicated transfer management view is available:

For each transfer within the current data space an appropriate entry in the list below is added, which provides information on current throughput of a specific transfer.

Overall throughput for the space can be observed on the world map. -->


## REST API

All operations on transfers can be performed using the REST API.
Refer to the linked API documentation for detailed information and examples.

| Request                      | Link to API |
|------------------------------|-------------|
| List all space transfers     | [API](https://onedata.org/#/home/api/stable/oneprovider?anchor=operation/get_all_transfers)|
| Create transfer              | [API](https://onedata.org/#/home/api/stable/oneprovider?anchor=operation/create_transfer)|
| Get transfer status          | [API](https://onedata.org/#/home/api/stable/oneprovider?anchor=operation/get_transfer_status)|
| Cancel ongoing transfer      | [API](https://onedata.org/#/home/api/stable/oneprovider?anchor=operation/cancel_transfer)|
| Rerun ended  transfer        | [API](https://onedata.org/#/home/api/stable/oneprovider?anchor=operation/rerun_transfer)|


## Advanced operations using views

It is possible to schedule transfer of files that are included in the result 
of a query on a [view](views.md). 
>**NOTE:** Currently, scheduling of such operations is possible only via REST interface.

In order to schedule replica operations by view, you must ensure that the 
mapping (or reduce) function returns a list containing solely file IDs as 
a value. The list of IDs can be arbitrarily nested (it will be flattened). 
Any deviation from this format will result in errors.

Below is an example of a mapping function that retrieves the list of all files 
with an extended attribute whose name starts with `org.onedata.jobId.`. 
The latter part of the extended attribute serves as the key in the view.

```json
function (id, type, meta, ctx) {
    const JOB_PREFIX = "org.onedata.jobId.";
    var results = [];
    for (var key of Object.keys(meta))
        if (key.startsWith(JOB_PREFIX)){
            var jobId = key.slice(JOB_PREFIX.length);
            results.push([jobId, id]);
        }
    return {"list": results};
}
```
>**NOTE:** Currently, scheduling operations on replicas works only for files. 
> Directory Ids are ignored in the results.
