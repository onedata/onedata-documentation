# REST API

This chapter contains basics about Onedata REST API usage.

## Available APIs (services)

There are essentially three types of services in Onedata that make up its [architecture][1].
Each of them has its corresponding API, documented using OpenAPI (a.k.a. Swagger):

* Onezone — API for managing high level objects such as users, groups, spaces etc. —
  [REST API][2].

* Oneprovider — API for data management — [REST API][3],
  complemented by [CDMI API][4] (recommended only for advanced use-cases
  that explicitly require the CDMI protocol, due to its worse efficiency)

* Onepanel — admin API for managing service clusters (Onezone or Oneprovider) —
  [REST API][5].

## Endpoints

The REST APIs are available under endpoints depending on the service type and domain.
Assume the following domains in the environment:

* Onezone: `onezone.plgrid.pl`
* Oneprovider: `oneprovider.cyfronet.pl`

In such case, the APIs are available under the following endpoints:

| Service                         | API endpoint                                                                                                                          |
| ------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------- |
| Onezone                         | `https://onezone.plgrid.pl/api/v3/onezone/{...}`                                                                                      |
| Oneprovider                     | `https://oneprovider.cyfronet.pl/api/v3/oneprovider/{...}`                                                                            |
| Onezone panel (admins only)     | `https://onezone.plgrid.pl/api/v3/onepanel/{...}` <br /> or <br /> `https://onezone.plgrid.pl:9443/api/v3/onepanel/{...}`             |
| Oneprovider panel (admins only) | `https://oneprovider.cyfronet.pl/api/v3/onepanel/{...}` <br /> or <br /> `https://oneprovider.cyfronet.pl:9443/api/v3/onepanel/{...}` |

> **NOTE:** the Onepanel API endpoints are available under Onezone and Oneprovider
> domains and internally proxied to Onepanel. The port `9443` can be used to
> access the Onepanel API directly from within the cluster's local network.

The Onezone domain should be known to the users as this is their entry point
to the system, presenting them with a login page. Instructions on how to find
the domain of a Oneprovider service can be found [here][6].

### Access tokens

Access tokens are used universally to authorize API requests in all services.
Follow this [quickstart guide][7] to acquire an access token.

### Oneprovider ID

Some endpoints (e.g. in Oneprovider's Data Transfers API) require the provider
ID. You can find it with the following REST query:

```bash
curl "https://${ONEPROVIDER_DOMAIN}/api/v3/oneprovider/configuration" | jq .providerId
     
"2ee1df8b32302fee25042a538b26473ech7ae7"
```

[1]: ../intro.md#architecture

[2]: https://onedata.org/#/home/api/stable/onezone

[3]: https://onedata.org/#/home/api/stable/oneprovider

[4]: cdmi.md

[5]: https://onedata.org/#/home/api/stable/onepanel

[6]: data.md#oneprovider-domain

[7]: ./tokens.md#access-token-quickstart
