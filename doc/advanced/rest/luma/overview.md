# LUMA


<a name="overview"></a>
## Overview
LUMA (Local User MApping) is a REST server that exposes simple REST API that can be used to map users 
(of any system/kind) to storage specific users, in the process authorizing them with the storage.
New storage types are added by means of plugin system of generators. A generator is responsible for:
mapping users to storage specific users creating a user credentials for accessing the actual storage

As of now there are four kinds of generators implemented in LUMA:
 * Posix
 * Ceph
 * Amazon S3
 * Openstack Swift

LUMA is written using [Flask](http://flask.pocoo.org/) framework and uses SQLite backend to store information about user credentials.

More information: [https://github.com/onedata/luma](https://github.com/onedata/luma)


### Version information
*Version* : 3.0.0-RC1


### Contact information
*Contact* : Onedata support  
*Contact Email* : info@onedata.org


### License information
*License* : Apache 2.0  
*License URL* : http://www.apache.org/licenses/LICENSE-2.0.html


### URI scheme
*BasePath* : /api/v3/luma


### Tags

* LUMA : LUMA API methods



