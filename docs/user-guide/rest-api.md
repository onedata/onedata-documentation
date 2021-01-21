# REST API
<!-- This file is referenced at least one time as "rest-api.md" -->

This chapter contains basics about Onedata REST API usage.


## Available APIs (services)
There are essentially three types of services in Onedata that make up its [architecture](../intro.md#architecture). 
Each of them has its corresponding API, documented using OpenAPI (a.k.a. Swagger):

* Onezone - API for managing high level objects such as users, groups, spaces etc. - 
  [REST API](https://onedata.org/#/home/api/stable/onezone).

* Oneprovider - API for data management - [REST API](https://onedata.org/#/home/api/stable/oneprovider), 
  complemented by [CDMI API](cdmi.md) (recommended only for advanced use-cases 
  that explicitly require the CDMI protocol, due to its worse efficiency)

* Onepanel - admin API for managing service clusters (Onezone or Oneprovider) - 
  [REST API](https://onedata.org/#/home/api/stable/onepanel).


## Endpoints
The REST APIs are available under endpoints depending on the service type and domain.
Assume the following domains in the environment:
* Onezone: `onezone.plgrid.pl`
* Oneprovider: `oneprovider.cyfronet.pl`

In such case, the APIs are available under the following endpoints:
* Onezone: `https://onezone.plgrid.pl/api/v3/onezone/{...}`
* Oneprovider: `https://oneprovider.cyfronet.pl/api/v3/oneprovider/{...}`
* Onezone panel (admins only): `https://onezone.plgrid.pl/api/v3/onepanel/{...}`
* Oneprovider panel (admins only): `https://oneprovider.cyfronet.pl/api/v3/onepanel/{...}`

The Onezone domain should be known to the users as this is their entry point
to the system, presenting them with a login page. Instructions on how to find 
the domain of a Oneprovider service can be found [here](data.md#oneprovider-domain).


### Access tokens
Access tokens are used universally to authorize API requests in all services. 
Please follow this [quickstart guide](./tokens.md#quickstart) to acquire an access token.


### Oneprovider ID
Some endpoints (e.g. in Oneprovider's Data Transfers API) require the provider 
ID. You can find it with the following REST query:
```bash 
curl "https://${ONEPROVIDER_DOMAIN}/api/v3/oneprovider/configuration" | jq .providerId
     
"2ee1df8b32302fee25042a538b26473ech7ae7"
```


### REST CLI
<!-- TODO VFS-7217 -->


