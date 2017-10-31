# Onezone


<a name="overview"></a>
## Overview
# Overview
This is the RESTful API definition of Onezone component of Onedata data management system [onedata.org](http://www.onedata.org).

> This API is defined using [Swagger](http://swagger.io/), the JSON specification can be used to automatically generate
> client libraries - [swagger.json](../../../swagger/onezone/swagger.json).

This API allows control and configuration of local Onezone service deployment, in particular management
of users, spaces, groups, shares and providers.

## Authentication and permissions
In order to be able to use this API the REST client must be able to authenticate with the Onezone service.

REST API operations from the permissions perspective in Onezone service can be divided into 2 groups,
depending on the actor making the request:
 * **User requests** - regular end user requests are authenticated based on the `X-Auth-Token` header, which
 must include valid client access token, and authorization is made based on the privileges assigned
 to the user in the system. Each operation in this API that is available to end users, has a list of
 required privileges, except for the operations which are related to user account management, i.e.
 each user can perform any operation on his account, the `X-Auth-Token` header example:
 ```
   X-Auth-Token: IAUYCGOUASGDJHASDJKVAHSDJHASDKJHABSDKJHBASKJHDBKJHASBDKJHBASDKJHBASD...
 ```
In case the Onezone deployment supports authentication delegation other IdP's,
the `X-Auth-Token` field can contain token from such IdP with appropriate prefix,
as configured by Onezone administrators, e.g.:
 ```
   X-Auth-Token: github:GST5aasdA7asdAASFG7asdasaAS
 ```

 * **Provider requests** - when a Oneprovider service needs to request some action from the Onezone service,
 it must authenticate using the peer certificate which was assigned to this provider when registering
 in the Onezone service. In such case the `X-Auth-Token` header is not necessary.

Some special administrative operations do not require authentication:
 * `POST /user/authorize` - authorizes user with authentication token through
 Onezone web interface.This interface is called typically by providers,
 * `POST /provider` - registers a Oneprovider in Onezone service
 (however a valid CSR in the body is required),
 * `POST /provider/test/check_my_ports` - checks if all given ports
 are reachable from Onezone,
 * `GET /provider/test/check_my_ip` - returns the external IP of the request peer (as seen by the Onezone).

All other operations can be invoked by a user assuming he has valid privileges in the system,
each operation description lists required permissions, if any.

## Effective users and effective groups and spaces
Onedata supports creation of arbitrary nested group and space membership tree structures. In order to determine
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

**Handle API**
Onezone provides extensive support for integration with Handle system registration
services, including support for DOI and PID identifier assignment services. The API
provides methods for adding new Handle services to the system, managing which users
can use which registration services and complete API for registering identifiers to
users data sets which are made public.

## Using the API
Onezone API is quite complex and thus it might be difficult to quickly figure out how
to perform specific action, however the following guidelines might be useful:
  * Operations performed by a regular users on their resources are grouped under
    `/user` path (**USER** group in the menu)
  * Operations performed by administrators of specific resources (e.g. groups,
    spaces, shares) start with specific resource (e.g. `/groups`)
  * By default the operations which list resource membership
    (e.g. `/spaces/SPACE_ID/groups/`) will list explicit resource membership.
    To get list of effective resource membership (i.e. including indirect
    membership), special paths are provided
    (e.g. `/spaces/SPACE_ID/effective_groups/`)

Furthermore, we have prepared a command-line client environment based on Docker
which gives easy access to each of Onedata services via command-line clients,
with pre-configured shell with full help on the APIs and autocomplete for
operations and attributes.

```
docker run -it onedata/rest-cli:17.06.0-beta6
```

We have also prepared tutorials which show how to use this API in practice:
  * [User oriented tutorial](https://onedata.org/docs/doc/using_onedata/using_onedata_from_cli.html)
  * [Administrator oriented tutorial](https://onedata.org/docs/doc/administering_onedata/administering_onedata_from_cli.html)


## Examples

**Generate new authentication token**
```bash
curl -u user:password -X POST -H 'Content-type: application/json' -d '{}' \
https://$ONEZONE_HOST:8443/api/v3/onezone/user/client_tokens
```

**Get user details**
```bash
curl -H 'X-Auth-Token: MDAxNWxvY2F0aW9uIG9uZXpvbmUKMDAzYmlk' -X GET \
https://$ONEZONE_HOST:8443/api/v3/onezone/user \
```


### Version information
*Version* : 17.06.0-rc6


### Contact information
*Contact* : Onedata support  
*Contact Email* : info@onedata.org


### License information
*License* : Apache 2.0  
*License URL* : http://www.apache.org/licenses/LICENSE-2.0.html


### URI scheme
*BasePath* : /api/v3/onezone


### Tags

* User : Regular user operations
* Users : User management operations
* Group : Group management operations
* Space : Space management operations
* Provider : Provider management operations
* Handle : Operations for managing Handle system service and identifier generation.



