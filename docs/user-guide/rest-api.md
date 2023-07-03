# REST API

[toc][]

This chapter provides a brief introduction to the usage of the Onedata REST API.


## Available APIs (services)
Onedata consists of three main types of services that form its [architecture](../intro.md#architecture). 
Each service has its corresponding API, which is documented using OpenAPI (also known as Swagger):

* Onezone: This API is used for managing high-level objects such as users, groups, spaces, and more. You can access
the [Onezone REST API](https://onedata.org/#/home/api/stable/onezone) documentation for detailed information.

* Oneprovider: This API is focused on data management. You can access the 
[Oneprovider REST API](https://onedata.org/#/home/api/stable/oneprovider) documentation for comprehensive details.
Additionally, there is a [CDMI API](cdmi.md) available as well. However, it is recommended only for advanced
use-cases that explicitly require the CDMI protocol, as it has lower efficiency.

* Onepanel: This API is specifically designed for administrators to manage service clusters,
including Onezone or Oneprovider instances. You can refer to the
[Onepanel REST API](https://onedata.org/#/home/api/stable/onepanel) documentation for more information on its usage.


## Endpoints
The REST APIs are accessible through endpoints based on the service type and domain. 
In the environment, assume the following domains:
* Onezone: `onezone.plgrid.pl`
* Oneprovider: `oneprovider.cyfronet.pl`

Based on this, the APIs can be accessed using the following endpoints:

| Service                           | API endpoint                                                 |
|-----------------------------------|--------------------------------------------------------------|
| Onezone                           | `https://onezone.plgrid.pl/api/v3/onezone/{...}`             |
| Oneprovider                       | `https://oneprovider.cyfronet.pl/api/v3/oneprovider/{...}`   |
| Onezone panel (admins only)       | `https://onezone.plgrid.pl/api/v3/onepanel/{...}` <br /> or <br /> `https://onezone.plgrid.pl:9443/api/v3/onepanel/{...}`             |
| Oneprovider panel (admins only)   | `https://oneprovider.cyfronet.pl/api/v3/onepanel/{...}` <br /> or <br /> `https://oneprovider.cyfronet.pl:9443/api/v3/onepanel/{...}` |
  
> **NOTE:** the Onepanel API endpoints are accessible under Onezone and Oneprovider
> domains, and internally proxied to Onepanel. The port `9443` can be used to
> directly access the Onepanel API from within the cluster's local network. 

Users should be aware of the Onezone domain as it serves as their entry point to the system,
providing them with a login page. Instructions on how to determine the domain of an
Oneprovider service can be found [here](data.md#oneprovider-domain).


### Access tokens
Access tokens are universally used to authorize API requests in all services.
Follow this [quickstart guide](./tokens.md#access-token-quickstart) to acquire an access token.


### Oneprovider ID
Some endpoints (e.g. in Oneprovider's Data Transfers API) require the provider 
ID. You can find it with the following REST query:
```bash 
curl "https://${ONEPROVIDER_DOMAIN}/api/v3/oneprovider/configuration" | jq .providerId
     
"2ee1df8b32302fee25042a538b26473ech7ae7"
```
