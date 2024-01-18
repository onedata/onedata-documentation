# REST API

This chapter provides a brief introduction to the usage of the Onedata REST API.

## Available APIs (services)

Onedata consists of three main types of services that form its [architecture][].
Each service has its corresponding API, which is documented using OpenAPI (also known as Swagger):

* Onezone — API for managing high-level resources such as users, groups, spaces,
  etc, realized by the **Onezone Worker** server — see the [docs][Onezone REST API].

* Oneprovider — API for data management, complemented by [CDMI API][], realized
  by the **Oneprovider Worker** server — see the [docs][Oneprovider REST API].

* Onepanel — admin API for managing service clusters, realized by the **Onezone
  Panel** or **Oneprovider Panel** server — see the [docs][Onepanel REST API].

![image-rest-api-services][]

## Endpoints

The REST API endpoint location depends on the service type and domain.

Assume the following domains:

* Onezone: `onezone.plgrid.pl`
* Oneprovider: `oneprovider.cyfronet.pl`

Then, the APIs can be accessed using the following endpoints:

| Service                         | API endpoint                                                                                                                        |
| :------------------------------ | :---------------------------------------------------------------------------------------------------------------------------------- |
| Onezone Worker                  | `https://onezone.plgrid.pl/api/v3/onezone/{...}`                                                                                    |
| Oneprovider Worker              | `https://oneprovider.cyfronet.pl/api/v3/oneprovider/{...}`                                                                          |
| Onezone Panel (admins only)     | `https://onezone.plgrid.pl/api/v3/onepanel/{...}` <br />or<br /> `https://onezone.plgrid.pl:9443/api/v3/onepanel/{...}`             |
| Oneprovider Panel (admins only) | `https://oneprovider.cyfronet.pl/api/v3/onepanel/{...}` <br />or<br /> `https://oneprovider.cyfronet.pl:9443/api/v3/onepanel/{...}` |

::: tip NOTE
The Onepanel API endpoints are exposed by Onezone and Oneprovider Worker
servers and proxied to Onepanel servers. Port `9443` can be used to
directly access the Onepanel server from within the cluster's local network.
:::

Users should be aware of the Onezone domain as it serves as their entry point to
the system, providing them with a login page — see the [user quickstart
guide][]. Instructions on how to determine the domain of a Oneprovider service can
be found [here][provider domain].

### Access tokens

Access tokens are universally used to authorize API requests in all services.
Follow this [guide][token quickstart guide] to acquire an access token.

### Oneprovider ID

Some endpoints (e.g. in Oneprovider's Data Transfers API) require the provider
ID. You can find it with the following REST query (you will need the provider
[domain][provider domain]):

```bash
curl "https://${PROVIDER_DOMAIN}/api/v3/oneprovider/configuration" | jq .providerId
     
"2ee1df8b32302fee25042a538b26473ech7ae7"
```

Alternatively, the ID can be retrieved from the GUI:

![screen-copy-provider-id][]

<!-- references -->

[architecture]: ../intro.md#architecture

[Onezone REST API]: https://onedata.org/#/home/api/stable/onezone

[Oneprovider REST API]: https://onedata.org/#/home/api/stable/oneprovider

[CDMI API]: cdmi.md

[Onepanel REST API]: https://onedata.org/#/home/api/stable/onepanel

[user quickstart guide]: quickstart.md

[provider domain]: data.md#provider-domain

[token quickstart guide]: ./tokens.md#access-token-quickstart

[image-rest-api-services]: ../../images/user-guide/rest-api/rest-api-services.svg

[screen-copy-provider-id]: ../../images/user-guide/rest-api/copy-provider-id.png
