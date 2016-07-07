# Onepanel


<a name="overview"></a>
## Overview
This is the RESTful API definition of Onepanel component of Onedata data management system [http://www.onedata.org].

This API allows control and configuration of local Onedata deployment, in particular full control over the Onezone and Oneprovider services and their distribution on the local resources. 

Onezone and Oneprovider services is composed of 3 types of processes: managers, databases and workers. 

Each of these processes can be added on specified host in the local site using this API. 

The overall configuration can be controlled by updating 'onezone/configuration' and
'oneprovider/configuration' resources.
 All paths listed below are relative to the base Onedata REST API which is `/api/v3/`, so complete URL for a request to Onepanel service is:
 
 ```
 http://HOSTNAME:PORT/api/v3/onepanel/...
 ```

 ## Authentication
 In order to be able to use this API the REST client must be able to authenticate with the Onezone service.

 Currently this is supported through access token which can be generate using the Onedata user interface. 
 The token must be added to the request header:
 ```
 macaroon: IAUYCGOUASGDJHASDJKVAHSDJHASDKJHABSDKJHBASKJHDBKJHASBDKJHBASDKJHBASD...
 ```

 ## API structure
 This API allows the management of 2 Onedata services, Onezone and Oneprovider, in terms of their distribution in the local site.
 The API allows management of all these components as well as monitoring their current status.

 Each of these services is composed of the following components:
   * **Worker processes** - `oz_worker` for Onezone and `op_worker` for Oneprovider, these are available under `/cluster/workers` paths,
   * **Databases instances** - each Onedata service stores it's metadata in a Couchbase backend which can be distributed on any number of nodes, these are available under `/cluster/databases` paths
   * **Cluster manager** - this is a process which controls other deployed processes in one site, these are availables under these are available under `/cluster/managers` paths


### Version information
*Version* : 3.0.0-beta7


### Contact information
*Contact* : Onedata support  
*Contact Email* : info@onedata.org


### License information
*License* : Apache 2.0  
*License URL* : http://www.apache.org/licenses/LICENSE-2.0.html


### URI scheme
*BasePath* : /api/v3/onepanel


### Tags

* Onepanel : Onepanel API methods



