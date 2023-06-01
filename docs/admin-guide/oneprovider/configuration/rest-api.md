# REST API

Every administering operation regarding Oneprovider configuration can be done
using Onepanel REST API. It helps to automate tasks like storage creation, space
support, etc. without the need to interact with a web browser.

## API endpoints location

API endpoints are available in two locations. The first one is attached directly
to the domain of Oneprovider at a standard port. It is useful for the majority
of use-cases:
```
https://my.provider.domain.org/api/v3/onepanel/{...}
```
This works, because Onepanel API endpoints are internally proxied by the
Oneprovider to the underlying Onepanel.


The second one becomes handy when the Oneprovider itself is malfunctioning (so
it cannot proxy our API calls) and/or we want to connect from within the
cluster's local network.
```
https://my.provider.domain.org:9443/api/v3/onepanel/{...}
```
Port `9443` indicates, that we want to connect directly to the Onepanel service
without proxying via Oneprovider.

## Authentication

Access tokens are used universally to authorize API requests in all services.
Follow this [quickstart guide](../../../user-guide/tokens.md#access-token-quickstart)
to acquire an access token.

In emergency cases, it is also possible to authenticate using the *emergency
passphrase* — a secrect password, which is not assigned to any user and gives
the full control over the cluster.

How to use both of these methods is described in detail in
[this](https://onedata.org/#/home/api/latest/onepanel?anchor=section/Overview/Authentication)
section of our API documentation.

## Available operations

All possible operations and how to use them are described in our
[API documentation](https://onedata.org/#/home/api/latest/onepanel). The most
popular ones include:

| Request                     | Link to API                                                                                |
|---------------------------- |--------------------------------------------------------------------------------------------|
| Get public configuration    | [API](https://onedata.org/#/home/api/latest/onepanel?anchor=operation/get_configuration)   |
| Check cluster health        | [API](https://onedata.org/#/home/api/latest/onepanel?anchor=operation/health)              |
| Add storage                 | [API](https://onedata.org/#/home/api/latest/onepanel?anchor=operation/add_storage)         |
| List storages               | [API](https://onedata.org/#/home/api/latest/onepanel?anchor=operation/get_storages)        |
| Get storage details         | [API](https://onedata.org/#/home/api/latest/onepanel?anchor=operation/get_storage_details) |
| Support space               | [API](https://onedata.org/#/home/api/latest/onepanel?anchor=operation/support_space)       |
| List supported spaces       | [API](https://onedata.org/#/home/api/latest/onepanel?anchor=operation/get_provider_spaces) |
| Get space support details   | [API](https://onedata.org/#/home/api/latest/onepanel?anchor=operation/get_space_details)   |


## Example request

Lets assume, that your provider is located at `my.provider.domain.org` and your
access token is available under `TOKEN` environment variable. You can get the
list of provider storages using cURL command:
```
curl -X GET -H "X-Auth-Token: $TOKEN" https://my.provider.domain.org/api/v3/onepanel/provider/storages
```
The result of the above request will contain a list of storage IDs:
```
{
    "ids": [
        "18a42a43b1b2d92455ffa09e9a15df7fch4f82",
        "0a26877440f6ce457106c6958dfe7ecbch0ac6",
        "b3d7d10504393556d9b1631a74c34520ch8359"
    ]
}
```
