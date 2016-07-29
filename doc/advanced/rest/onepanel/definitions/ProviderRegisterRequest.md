
<a name="providerregisterrequest"></a>
### ProviderRegisterRequest
The provider configuration details required for registration process.


|Name|Description|Schema|
|---|---|---|
|**geoLatitude**  <br>*optional*|The geographical latitude of the provider.|number(float)|
|**geoLongitude**  <br>*optional*|The geographical longitude of the provider.|number(float)|
|**name**  <br>*required*|The name under which the provider should be registered in a zone.|string|
|**onezoneDomainName**  <br>*optional*|The domain name of a zone where provider will be registered.|string|
|**redirectionPoint**  <br>*required*|The address used for user redirection from a zone to the provider.|string|

**Example**
```
{
  "name" : "Provider1",
  "redirectionPoint" : "https://192.168.11.23",
  "geoLongitude" : -24.3776025,
  "geoLatitude" : -128.3519364,
  "onezoneDomainName" : "onezone2.example.com"
}
```



