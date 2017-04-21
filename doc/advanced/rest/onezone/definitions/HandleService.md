
<a name="handleservice"></a>
### HandleService
Handle service instance.


|Name|Description|Schema|
|---|---|---|
|**handleServiceId**  <br>*optional*|Handle service Id.|string|
|**name**  <br>*required*|The user defined name of the service.|string|
|**proxyEndpoint**  <br>*required*|The endpoint of the Handle service proxy, i.e. a service which implements logic specific for particular Handle service.|string|
|**serviceProperties**  <br>*required*||[HandleServiceProperties](HandleServiceProperties.md#handleserviceproperties)|

**Example**
```
{
  "handleServiceId" : "SADHLKJhlkASHDLAKSHDLKJHJjLH",
  "name" : "MyCommunity Handle service",
  "proxyEndpoint" : "https://localhost:17000/handle_proxy",
  "serviceProperties" : {
    "type" : "DOI",
    "host" : "https://mds.test.datacite.org",
    "doiEndpoint" : "/doi",
    "metadataEndpoint" : "/metadata",
    "mediaEndpoint" : "/media",
    "prefix" : 10.5072,
    "username" : "alice",
    "password" : "pa$$word",
    "identifierTemplate" : "{{space.name}}-{{space.guid}}",
    "allowTemplateOverride" : false
  }
}
```



