# REST API

Every administering operation regarding Oneprovider configuration can be done
using Onepanel REST API. It helps to automate tasks like storage creation, space
support, etc. without the need to interact with a web browser.

## API endpoints location

API endpoints are available in two locations. The first one is attached directly
to the domain of Oneprovider at a standard port. It is useful for the majority
of use cases:

```
https://my.provider.domain.org/api/v3/onepanel/{...}
```

All incoming calls to such Onepanel API endpoints are internally proxied by the
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
Follow this [quickstart guide][] to acquire an access token.

In emergency cases, it is also possible to authenticate using the *emergency
passphrase* — a secret password, which is not assigned to any user and gives
full control over the cluster.

How to use both of these methods is described in detail in [this][api-authentication]
section of our API documentation.

## Available operations

All possible operations and how to use them are described in our [API documentation][].
The most popular ones include:

| Request                     | Link to API                    |
| --------------------------- | ------------------------------ |
| Get public configuration    | [API][api-get-configuration]   |
| Check cluster health        | [API][api-health]              |
| Add storage backend         | [API][api-add-storage]         |
| List storage backends       | [API][api-get-storages]        |
| Get storage backend details | [API][api-get-storage-details] |
| Support space               | [API][api-support-space]       |
| List supported spaces       | [API][api-get-provider-spaces] |
| Get space support details   | [API][api-get-space-details]   |

## Example request

Let's assume, that your provider is located at `my.provider.domain.org` and your
access token is available under `TOKEN` environment variable. You can get the
list of provider storage backends using cURL command:

```
curl -X GET -H "X-Auth-Token: $TOKEN" https://my.provider.domain.org/api/v3/onepanel/provider/storages
```

The result of the above request will contain a list of storage backend IDs:

```
{
    "ids": [
        "18a42a43b1b2d92455ffa09e9a15df7fch4f82",
        "0a26877440f6ce457106c6958dfe7ecbch0ac6",
        "b3d7d10504393556d9b1631a74c34520ch8359"
    ]
}
```

<!-- references -->

[quickstart guide]: ../../../user-guide/tokens.md#access-token-quickstart

[api-authentication]: https://onedata.org/#/home/api/latest/onepanel?anchor=section/Overview/Authentication

[API documentation]: https://onedata.org/#/home/api/latest/onepanel

[api-get-configuration]: https://onedata.org/#/home/api/latest/onepanel?anchor=operation/get_configuration

[api-health]: https://onedata.org/#/home/api/latest/onepanel?anchor=operation/health

[api-add-storage]: https://onedata.org/#/home/api/latest/onepanel?anchor=operation/add_storage

[api-get-storages]: https://onedata.org/#/home/api/latest/onepanel?anchor=operation/get_storages

[api-get-storage-details]: https://onedata.org/#/home/api/latest/onepanel?anchor=operation/get_storage_details

[api-support-space]: https://onedata.org/#/home/api/latest/onepanel?anchor=operation/support_space

[api-get-provider-spaces]: https://onedata.org/#/home/api/latest/onepanel?anchor=operation/get_provider_spaces

[api-get-space-details]: https://onedata.org/#/home/api/latest/onepanel?anchor=operation/get_space_details
