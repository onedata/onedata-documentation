# Managing User Accounts

While for most cases, user should create their Onedata accounts using OpenID Connect services using their social or institute logins, it is also possible to create user accounts allowing them to login using `username` and `password`.

This functionality can be achieved using Onepanel service [REST interface](../advanced/rest/onepanel/overview.md).

## Creating new user account

Onepanel provides a simple REST API for management of user accounts in the Onezone service.

```bash
curl -X GET -H "macaroon: $(ACCESS_TOKEN)" \

```