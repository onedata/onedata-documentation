# REST API

Every administering operation regarding **@insert serviceUpper** configuration can be done
using Onepanel REST API. It helps to automate tasks like **@insert introTasks**, etc.
without the need to interact with a web browser.

## API endpoints location

API endpoints are available in two locations. The first one is attached directly to the
domain of **@insert serviceUpper** at a standard port. It is useful for the majority of
use cases:

```
https://my.**@insert serviceLower**.domain.org/api/v3/onepanel/{...}
```

All incoming calls to such Onepanel API endpoints are internally proxied by the
**@insert serviceUpper** to the underlying Onepanel.

The second one becomes handy when the **@insert serviceUpper** itself is malfunctioning
(so it cannot proxy our API calls) and/or we want to connect from within the cluster's
local network.

```
https://my.**@insert serviceUpper**.domain.org:9443/api/v3/onepanel/{...}
```

Port `9443` indicates, that we want to connect directly to the Onepanel service
without proxying via **@insert serviceUpper**.

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