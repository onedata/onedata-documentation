# Managing User Accounts

<!-- toc -->

In general, accounts for users in Onedata are created using social/community login - [OpenID or SAML](openid_saml_configuration.md). 
It is also possible to create user accounts manually in Onepanel, allowing users to log in 
using HTTP basic authentication, i.e. with `username` and `password`. However, such accounts have
administrative character and should be limited. This type of user accounts can be created using the Onepanel service [REST interface](../advanced/rest/onepanel/overview.md).

## Managing manual user accounts

Onepanel provides a simple REST API for management of user accounts in the Onezone service.

### Authentication
Onepanel service supports basic authentication using usernames and passwords. 
After the installation of Onepanel service, the first user can be created without providing authentication credentials 
and this user will be the admin. All consecutive account creation requests will create new users with either 
`regular` or `admin` role depending on the parameters specified in the body of request.

### Creating new users
The user can be added by invoking a `POST` request to the Onepanel `/user` REST endpoint and providing user credentials, which include:
* _username_ - the user login name
* _password_ - user password
* _userRole_ - currently only 2 roles are supported: **admin** and **regular**

The following examples assume that the following environment variables had been exported:
* `ONEZONE_HOST` - The IP or FQDN of the Onezone service
* `ADMIN_USERNAME` - Onezone service administrator username
* `ADMIN_PASSWORD` - Onezone service administrator password
* `USERNAME` - The new user username
* `PASSWORD` - The new user password

Now, a new user can be created using the following command line request:

```bash
curl -X POST -u ${ADMIN_USERNAME}:${ADMIN_PASSWORD} -H "Content-Type: application/json" \
-d '{"username": "$USERNAME", "password": "$PASSWORD", "userRole": "regular"}' \
https://${ONEZONE_HOST}:9443/api/v3/onepanel/users
```

In order to modify the user details (currently only password can be changed) the same operation should be invoked with `PUT` HTTP method.

```bash
curl -X PUT -u ${ADMIN_USERNAME}:${ADMIN_PASSWORD} -H "Content-Type: application/json" \
-d '{"password": "$PASSWORD"}' \
https://${ONEZONE_HOST}:9443/api/v3/onepanel/users
```

In order for these users to login to Onezone, onepanel authentication has to be enabled 
in the Onezone config as described [here](openid_saml_configuration.md).

### Removing users
In order to remove an existing user account, simply execute `DELETE` method on the user path and provide user name, i.e.:

```bash
curl -X DELETE -u ${ADMIN_USERNAME}:${ADMIN_PASSWORD} \
https://${ONEZONE_HOST}:9443/api/v3/onepanel/users/${USERNAME}
```

It is also possible to remove the current user account by invoking:
```bash
curl -X DELETE -u ${ADMIN_USERNAME}:${ADMIN_PASSWORD} \
https://${ONEZONE_HOST}:9443/api/v3/onepanel/users
```

without specifying the username in the path.
