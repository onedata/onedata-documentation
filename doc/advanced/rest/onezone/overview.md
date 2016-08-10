# Onezone


<a name="overview"></a>
## Overview
This is the RESTful API definition of Onezone component of Onedata data management system [onedata.org](http://www.onedata.org).

> This API is defined using [Swagger](http://swagger.io/), the JSON specification can be used to automatically generate
> client libraries - [swagger.json](../../../swagger/onezone/swagger.json).

This API allows control and configuration of local Onezone service deployment, in particular management
of users, spaces, groups and providers.

## Authentication and permissions
In order to be able to use this API the REST client must be able to authenticate with the Onezone service.

REST API operations from the permissions perspective in Onezone service can be divided into 2 groups,
depending on the actor making the request:
 * **User requests** - regular end user requests are authenticated based on the `macaroon` header, which
 must include valid client access token, and authorization is made based on the privileges assigned
 to the user in the system. Each operation in this API that is available to end users, has a list of
 required privileges, except for the operations which are related to user account management, i.e.
 each user can perform any operation on his account, the `macaroon` header example:
 ```
   macaroon: IAUYCGOUASGDJHASDJKVAHSDJHASDKJHABSDKJHBASKJHDBKJHASBDKJHBASDKJHBASD...
 ```
 * **Provider requests** - when a Oneprovider service needs to request some action from the Onezone service,
 it must authenticate using the peer certificate which was assigned to this provider when registering
 in the Onezone service. In such case the `macaroon` header is not necessary.

Some special operations are completely open and require no authentication:
 * `POST /user/authorize` - authorizes user with authentication token through
 Onezone web interface.This interface is called only by providers, 
 * `POST /provider` - registers a Oneprovider in Onezone service 
 (however a valid CSR in the body is required),
 * `POST /provider/test/check_my_ports` - checks if all given ports 
 are reachable from Onezone,
 * `GET /provider/test/check_my_ip` - returns the external IP of the request peer (as seen by the Onezone).

The provider specific operations include:
 * `ALL /provider` - all provider specific endpoints (except for the public access ones above),
 * `POST /spaces` - create new space,
 * `GET /space/{id}` - get specific space details,
 * `GET /spaces/{id}/users` - list space users.
 
All other operations can be invoked by a user assuming he has valid privileges in the system,
each operation description lists required permissions, if any.

## Effective users and effective groups
Onedata supports creation of arbitrary nested group tree structures. In order to allow identification
if a given user belongs to the group directly or indirectly by belonging to a subgroup of a group,
separate API calls are provided for getting information about group users (direct group members) and 
effective users (indirect group members).

## API structure
Most operations are RESTful, i.e. paths reflect the actual resource mode and operations on them are mapped to
most appropriate HTTP methods.

**Space management**
The space management operations of this API provide means for accessing information about spaces 
and their management.

**Group management**
The group management operations allow for creation of user groups, assigning their authorization rights,
adding and removing users from groups.

**User management**
The user management methods enable for creation of users, managing their authorization
credentials as well as space and group membership.

**Provider management**
Provider specific calls enable for getting global information about the spaces managed by the provider,
and some administrative operations which can be used for monitoring or accounting.

**Privileges management**
Onezone allows any user to have selected administration privileges for the Onezone service itself,
enabling them to view and configure certain aspects of the system.

## Examples

**Generate new authentication token**
```bash
curl -k -u bkryza:PaSSwoRd -X GET \
https://beta.onedata.org:8443/api/v3/onezone/user/client_token
```

**Get user details**
```bash
curl -k https://beta.onedata.org:8443/api/v3/onezone/user \
-H 'macaroon:MDAxNWxvY2F0aW9uIG9uZXpvbmUKMDAzYmlk'
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
*BasePath* : /api/v3/onezone


### Tags

* Space : Space related operations
* Group : Group related operations
* User : User related operations
* Provider : Provider related operations
* Privileges : Operations on Onezone privileges



