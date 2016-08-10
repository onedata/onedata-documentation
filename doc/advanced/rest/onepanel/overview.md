# Onepanel


<a name="overview"></a>
## Overview
This is the RESTful API definition of **Onepanel** component of Onedata data management system [onedata.org](http://www.onedata.org).

> This API is defined using [Swagger](http://swagger.io/), the JSON specification can be used to automatically generate
> client libraries - [swagger.json](../../../swagger/onepanel/swagger.json).

This API allows control and configuration of local Onedata deployment, in particular full control over the **Onezone** and **Oneprovider** services and their distribution and monitoring on the local resources. 

Each of these components is composed of the following services:
  * **Worker services** - these are available under `/zone/workers` and `/provider/workers` paths,
  * **Databases services** - each Onedata component stores it's metadata in a Couchbase backend, which can be distributed on any number of nodes, these are available under `/zone/databases` and `/provider/databases` paths,
  * **Cluster manager services** - this is a service which controls other deployed processes in one site, these are availables under these are available under `/zone/managers` and `/provider/managers` paths.

**Onezone** and **Oneprovider** components are composed of 3 types of services: **managers**, **databases** and **workers**. 

Using this API each of these components can be deployed, configured, started and stopped on 
a specified host in the local site, in the context of either **Onezone** or **Oneprovider** service. 

All paths listed in this documentation are relative to the base Onepanel REST API which is `/api/v3/onepanel`, 
so complete URL for a request to Onepanel service is:

```
http://HOSTNAME:PORT/api/v3/onepanel/...
```

## Authentication
Onepanel supports only HTTP basic authentication, i.e. using `username` and `password`, which were set when creating users.

Onepanel users can have 2 roles:
  * **admin** - Onepanel administrator, there can be multiple administrators and all have equal rights in terms of Onedata deployment management,
  * **regular** - this role allows manual creation of user accounts, using which users can login to Onezone service using HTTP Basic authentication without OpenID. This role makes sense only on Onepanel which manages Onezone deployment.

The first user account which is created in Onepanel is always an `admin` account.

## API structure
The Onepanel API is structured to reflect that it can either be used to control **Onezone**
or **Oneprovider** deployment, each Onedata component deployment has a separate Onepanel 
instance. In order to make the API calls explicit, **Onezone** or **Oneprovider** specific
requests have different paths, i.e.:
  * Onezone specific operations start with `/api/v3/onepanel/zone/`
  * Oneprovider specific operations start with `/api/v3/onepanel/provider/`
  * Common operations paths include `/api/v3/onepanel/users`, `/api/v3/onepanel/hosts` and `/api/v3/onepanel/tasks`

The overall configuration of each component can be controlled by updating `/api/v3/onepanel/zone/configuration` and
`/api/v3/onepanel/provider/configuration` resources.

## Examples 
Below are some example requests to Onepanel using cURL:
  
**Create new user**
```bash
curl -X POST -k -vvv -H "content-type: application/json" \
-d '{"username": "admin", "password": "Password1", "userRole": "admin"}' \
https://172.17.0.6:9443/api/v3/onepanel/users
```

**Add storage resource to provider**
```bash
curl -X PUT -u admin:Password1 -k -vvv -H "content-type: application/json" \
-d '{"NFS": {"type": "posix", "mountPoint": "/mnt/vfs"}}' \
https://172.17.0.4:9443/api/v3/onepanel/provider/storages 
```

**Add a new Onezone worker**
```bash
curl -X PUT -u admin:Password1 -k -vvv -H "content-type: application/json" \
-d '{"hosts": ["node1.p1.1.dev"]}' \
https://172.17.0.4:9443/api/v3/onepanel/zone/workers 
```


### Version information
*Version* : 3.0.0-RC2


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



