# Managing User Accounts

While for most cases, user should create their Onedata accounts using OpenID Connect services using their social or institute logins, it is also possible to create user accounts allowing them to login using `username` and `password`.

This functionality can be achieved using Onepanel service [REST interface](../advanced/rest/onepanel/overview.md).

## Creating manual user accounts

Onepanel provides a simple REST API for management of user accounts in the Onezone service.

The user can be adding by invoking a `POST` request to the Onepanel `/user` REST operation and providing user credentials, which includes:
* _username_ - the user login name
* _password_ - user password
* _userRole_ - currently only 2 roles are supported: **admin** and **regular**

```bash
curl -X POST -H "macaroon: $(ACCESS_TOKEN)" -H "Content-Type: application/json" \
-d '{"username":"$USERNAME", "password":"$PASSWORD", "userRole":"regular"}' \
https://$(ONEPANEL_HOST):8443/api/v3/onepanel/user
```

In order to modify the user details the same operation should be invoked with `PUT` HTTP method.