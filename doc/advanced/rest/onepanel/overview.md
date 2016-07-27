# Onepanel


<a name="overview"></a>
## Overview
This is the RESTful API definition of Onepanel component of Onedata data management system [http://www.onedata.org].

This API allows control and configuration of local Onedata deployment, in particular full control over the Onezone and Oneprovider services and their distribution on the local resources. 

Onezone and Oneprovider services are composed of 3 types of processes: managers, databases and workers. 

Each of these processes can be added on a specified host in the local site using this API, in the context
of either Onezone or Oneprovider service. 

The overall configuration can be controlled by updating `/zone/configuration` and
`/provider/configuration` resources.

All paths listed below are relative to the base Onepanel REST API which is `/api/v3/onepanel`, 
so complete URL for a request to Onepanel service is:

```
http://HOSTNAME:PORT/api/v3/onepanel/...
```

## Authentication
Onepanel supports only HTTP basic authentication, i.e. using `username` and `password` which were set when creating users.


## API structure
This API allows the management of 2 Onedata services, Onezone and Oneprovider, in terms of their distribution on the local site.
The API allows management of all these components as well as monitoring of their current status.

Each of these services is composed of the following components:
  * **Worker processes** - these are available under `/zone/workers` and `/provider/workers` paths,
  * **Databases instances** - each Onedata service stores it's metadata in a Couchbase backend which can be distributed on any number of nodes, these are available under `/zone/databases` and `/provider/databases` paths
  * **Cluster manager** - this is a process which controls other deployed processes in one site, these are availables under these are available under `/zone/managers` and `/provider/managers` paths

Below are some example requests to Onepanel using cURL:
  
**Create new user**
```bash
curl -X POST -k -vvv -H "content-type: application/json" \
-d '{"username": "admin", "password": "Password1", "userRole": "admin"}' \
https://172.17.0.6:9443/api/v3/onepanel/users
```

**Add storage resouce to provider**
```bash
curl -X PUT -u admin:Password1 -k -vvv -H "content-type: application/json" \
-d '{"NFS": {"type": "posix", "mountPoint": "/mnt/vfs"}}' \
https://172.17.0.4:9443/api/v3/onepanel/cluster/storages 
```

**Add new Onezone worker**
```bash
curl -X PUT -u admin:Password1 -k -vvv -H "content-type: application/json" \
-d '{"hosts": ["node1.p1.1.dev"]}' \
https://172.17.0.4:9443/api/v3/onepanel/zone/workers 
```


### Version information
*Version* : 3.0.0-RC1


### Contact information
*Contact* : Onedata support  
*Contact Email* : info@onedata.org


### License information
*License* : Apache 2.0  
*License URL* : http://www.apache.org/licenses/LICENSE-2.0.html


### URI scheme
*BasePath* : /api/v3/onepanel


### Tags

* Onepanel : Common Onepanel resources and operations
* Oneprovider : Resources and operations for managing Oneprovider deployment
* Onezone : Resources and operations for managing Onezone deployment



