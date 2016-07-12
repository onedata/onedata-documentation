# Managing User Accounts

While for most cases, user should create their Onedata accounts using OpenID Connect services using their social or institute logins, it is also possible to create user accounts allowing them to login using HTTP basic authentication, i.e. `username` and `password`.

This functionality can be achieved by creating manually user accounts using Onepanel service [REST interface](../advanced/rest/onepanel/overview.md).

## Manging manual user accounts

Onepanel provides a simple REST API for management of user accounts in the Onezone service.

### Creating new users
The user can be added by invoking a `POST` request to the Onepanel `/user` REST endpoint and providing user credentials, which include:
* _username_ - the user login name
* _password_ - user password
* _userRole_ - currently only 2 roles are supported: **admin** and **regular**

```bash
curl -X POST -H "macaroon: $ACCESS_TOKEN" -H "Content-Type: application/json" \
-d '{"username": "$USERNAME", "password": "$PASSWORD", "userRole": "regular"}' \
https://$(ONEPANEL_HOST):8443/api/v3/onepanel/user
```

In order to modify the user details the same operation should be invoked with `PUT` HTTP method.

```bash
curl -X PUT -H "macaroon: $ACCESS_TOKEN" -H "Content-Type: application/json" \
-d '{"username":"$USERNAME", "password":"$PASSWORD", "userRole":"regular"}' \
https://$(ONEPANEL_HOST):8443/api/v3/onepanel/user
```

In order for these users to login to Onezone, basic authentication module has to be enabled in the Onezone config as described [here](./openid_configuration.md).

### Removing users
In order to remove an existing user account, simply execute `DELETE` method on the user path and provide user name, i.e.:

```bash
curl -X DELETE -H "macaroon: $ACCESS_TOKEN" \
https://$ONEPANEL_HOST:8443/api/v3/onepanel/user/$USERNAME
```



