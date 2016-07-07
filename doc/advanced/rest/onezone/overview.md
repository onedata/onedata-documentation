# Onezone


<a name="overview"></a>
## Overview
This is the RESTful API definition of Onezone component of Onedata data management system [http://www.onedata.org].

This API allows control and configuration of local Onezone service deployment, in particular management
of users, spaces, groups and providers.

## Authentication
In order to be able to use this API the REST client must be able to authenticate with the Onezone service.

Currently this is supported through access token which can be generate using the Onedata user interface. 
The token must be added to the request header:
 ```
 macaroon: IAUYCGOUASGDJHASDJKVAHSDJHASDKJHABSDKJHBASKJHDBKJHASBDKJHBASDKJHBASD...
 ```

In addition please take into account, that depending on your account authorization rights, not all operations
may be possible. In particular, some operations depend on whether a particular request is initiated by a regular
user or by another storage provider within a zone.

In case of Oneprovider API calls, the provider identification and authorization are based on
the SSL Peer Certificate that has been signed by this Onezone service during registration.

## Effective users and effective groups
Onedata supports creation of arbitrary nested group tree structures. In order to allow identification
if a given user belongs to the group directly or indirectly by belonging to a subgroup of a group,
separate API calls are provided for getting information about group users (direct group members) and 
effective users (indirect group members).

## API structure
Most operations are RESTful, i.e. paths reflect the actual resource mode and operations on them are mapped to
most appropriate HTTP methods.


### Space management
The space management operations of this API provide means for accessing information about spaces 
and their management.

### Group management
The group management operations allow for creation of user groups, assigning their authorization rights,
adding and removing users from groups.

### User management
The user management methods enable for creation of users, managing their authorization
credentials as well as space and group membership.

### Provider management
Provider specific calls enable for getting global information about the spaces managed by the provider,
and some administrative operations which can be used for monitoring or accounting.

### Privileges management
Onezone allows any user to have selected administration privileges for the Onezone service itself,
enabling them to view and configure certain aspects of the system.


### Version information
*Version* : 3.0.0-beta7


### Contact information
*Contact* : Onedata support  
*Contact Email* : info@onedata.org


### License information
*License* : Apache 2.0  
*License URL* : http://www.apache.org/licenses/LICENSE-2.0.html


### URI scheme
*BasePath* : /api/v3/onezone


### Tags

* Space : Space related operations
* Group : Group related operations
* User : User related operations
* Provider : Provider related operations
* Privileges : Operations on Onezone privileges



