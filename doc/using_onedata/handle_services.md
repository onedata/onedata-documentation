# Handle services

<!-- toc -->

Onedata supports Open Access identifier registration services based on [Handle system](http://handle.net) such as DOI or PID.

## Registering a handle service
In order to allow users to register identifiers for their shares it is first necessary to register a Handle registrar and give proper permissions to appropriate users.

Currently this functionality is available only using the REST API.

### Registering new Handle service

The command below adds a new Handle service (in this case DataCite) for assigning DOI identifiers via Onezone service.

```bash
curl -k -u username:password -X POST  -H "Content-type: application/json" \
    -d @datacite.json https://$ONEZONE_HOST:8443/api/v3/handle_services
```

where `datacite.json` in the current folder contains the following content:

```json
{
    "name": "MyCommunity Handle service",
    "proxyEndpoint": "localhost:17000/handle_proxy",
    "serviceProperties": {
        "allowTemplateOverride": false,
        "doiEndpoint": "/doi",
        "host": "https://mds.test.datacite.org",
        "identifierTemplate": "{{space.name}}-{{space.guid}}",
        "mediaEndpoint": "/media",
        "metadataEndpoint": "/metadata",
        "password": "PASSWORD",
        "prefix": "10.5072",
        "type": "DOI",
        "username": "USERNAME"
    }
}         
```

The identifier of the Handle service will be returned in the `Location:` header of the response if successful.


### Adding users to Handle service
In order to allow other users in the community to register their shares using Handle service.

In order to add a user to specific Handle service invoke the following request:
```bash
curl -k -u username:password -X PUT \
https://$ONEZONE_HOST:8443/api/v3/handle_services/${HANDLE_SERVICE_ID}/users/#{USER_ID}
```

where `HANDLE_SERVICE_ID` is the ID of the Handle service returned during registration and `USER_ID` is the ID of the user who should have permission to register identifiers for shares using this service.

More operations on the Handle service are possible using the [REST API](../advanced/rest/onezone/overview.md).

