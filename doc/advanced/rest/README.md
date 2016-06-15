# REST API

Onedata provides comprehensive REST API for all of it's main components:
* [Onezone](rest/onezone-rest.md)
* [Oneprovider](oneprovider/overview.md)

The API's are defined using [Open API](https://openapis.org/) specification standard, based on [Swagger](http://swagger.io/). Each Onedata service has a separate Swagger REST specification in JSON:
* [Onezone swagger.json](../swagger/onezone/swagger.json)
* [Oneprovider swagger.json](../swagger/oneprovider/swagger.json)

Some examples of typical use cases that can be achieved using this API
is presented [here](rest/examples.md).


Please note that all Onedata services use solely TLS v1.2 protocol.
