# LUMA


<a name="overview"></a>
## Overview
LUMA (Local User MApping) is a REST server that exposes simple REST API that
can be used to map users (of any system/kind) to storage specific user
credentials (e.g. UID/GID, usernames and passwords or certificates), in the
process authorizing them with the storage.

This is a specification of LUMA interface, which is understood by
Oneprovider, and for each storage it is best to implement a specific LUMA
implementation.

A stub implementation can be generated automatically from this specification
using [Swagger Codegen](https://github.com/swagger-api/swagger-codegen)
tool in mulitple programming frameworks.

LUMA provides a 2-way mapping interface allowing to:
 * Get user credentials for specific storage based on user federated Id
 * Get user federated Id (in specific IdP) based on storage credentials

Additionally, LUMA allows for mapping between user groups on a federated (IdP)
level and storage, independently of any specific user.

LUMA supports the same storage systems which are supported by Oneprovider,
and for each of them a specific must be implemented as typically different
storage systems require different types of credentials.

As of now there are the following supported storage systems, each with it's
own type of credentials:
 * Posix
 * Ceph
 * Amazon S3
 * Openstack Swift
 * GlusterFS

More information: [https://github.com/onedata/luma](https://github.com/onedata/luma)


### Version information
*Version* : 17.06.0-rc8


### Contact information
*Contact* : Onedata support  
*Contact Email* : info@onedata.org


### License information
*License* : Apache 2.0  
*License URL* : http://www.apache.org/licenses/LICENSE-2.0.html


### URI scheme
*BasePath* : /api/v3/luma


### Tags

* Mapping : User and group mapping
* Admin : LUMA management endpoint



