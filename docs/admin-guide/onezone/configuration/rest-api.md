# REST API

Every administering operation regarding Onezone configuration can be done using
Onepanel REST API. It helps to automate tasks like user management, health
status checks, etc. without the need to interact with a web browser.

## API endpoints location

API endpoints are available in two locations. The first one is attached directly
to the domain of Onezone at a standard port. It is useful for the majority
of use cases:

```
https://my.zone.domain.org/api/v3/onepanel/{...}
```

This works because Onepanel API endpoints are internally proxied by the
Onezone to the underlying Onepanel.

The second one becomes handy when the Onezone itself is malfunctioning (so
it cannot proxy our API calls) and/or we want to connect from within the
cluster's local network.

```
https://my.zone.domain.org:9443/api/v3/onepanel/{...}
```

Port `9443` indicates, that we want to connect directly to the Onepanel service
without proxying via Onezone.

## Authentication

Access tokens are used universally to authorize API requests in all services.
Follow this [quickstart guide](../../../user-guide/tokens.md#access-token-quickstart)
to acquire an access token.

In emergency cases, it is also possible to authenticate using the *emergency
passphrase* — a secret password, which is not assigned to any user and gives
full control over the cluster.

How to use both of these methods is described in detail in
[this](https://onedata.org/#/home/api/latest/onepanel?anchor=section/Overview/Authentication)
section of our API documentation.

## Available operations

All possible operations and how to use them are described in our
[API documentation](https://onedata.org/#/home/api/latest/onepanel). The most
popular ones include:

| Request                  | Link to API                                                                                 |
| ------------------------ | ------------------------------------------------------------------------------------------- |
| Get public configuration | [API](https://onedata.org/#/home/api/latest/onepanel?anchor=operation/get_configuration)    |
| Check cluster health     | [API](https://onedata.org/#/home/api/latest/onepanel?anchor=operation/health)               |
| Create user              | [API](https://onedata.org/#/home/api/latest/onepanel?anchor=operation/add_onezone_user)     |
| List users               | [API](https://onedata.org/#/home/api/latest/onepanel?anchor=operation/get_onezone_users)    |
| Get user details         | [API](https://onedata.org/#/home/api/latest/onepanel?anchor=operation/get_onezone_user)     |
| Set password for user    | [API](https://onedata.org/#/home/api/latest/onepanel?anchor=operation/change_user_password) |

## Example request

Let's assume, that your Onezone is located at `my.zone.domain.org` and your
access token is available under `TOKEN` environment variable. You can create a
new Onezone user account using cURL command:

```
curl -X POST -H "X-Auth-Token: $TOKEN" https://my.zone.domain.org/api/v3/onepanel/zone/users \
-H "Content-Type: application/json" -d '{
    "username": "someUser",
    "password": "somePassword"
}'
```

The result of the above request will contain an ID of the created user:

```
{
    "id": "b519b3ac46823b2b83b6cb85e1b16f4fchaa0f"
}
```
