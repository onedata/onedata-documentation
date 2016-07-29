
<a name="providerconfiguration"></a>
### ProviderConfiguration
The provider deployment configuration.


|Name|Description|Schema|
|---|---|---|
|**cluster**  <br>*required*||[ProviderClusterConfiguration](ProviderClusterConfiguration.md#providerclusterconfiguration)|
|**oneprovider**  <br>*optional*|The provider custom configuration.|[oneprovider](#providerconfiguration-oneprovider)|
|**onezone**  <br>*optional*|The zone custom configuration.|[onezone](#providerconfiguration-onezone)|

<a name="providerconfiguration-oneprovider"></a>
**oneprovider**

|Name|Description|Schema|
|---|---|---|
|**geoLatitude**  <br>*optional*|The geographical latitude of the provider.|number(float)|
|**geoLongitude**  <br>*optional*|The geographical longitude of the provider.|number(float)|
|**name**  <br>*required*|The name under which the provider will be registered in a zone.|string|
|**redirectionPoint**  <br>*required*|The address used for user redirection from a zone to the provider.|string|
|**register**  <br>*required*|Defines whether the provider should be registered in a zone.|boolean|

<a name="providerconfiguration-onezone"></a>
**onezone**

|Name|Description|Schema|
|---|---|---|
|**domainName**  <br>*required*|The domain name of a zone where provider will be registered.|string|



