
<a name="providermodifyrequest"></a>
### ProviderModifyRequest
The provider configuration details that can be modified.


|Name|Description|Schema|
|---|---|---|
|**geoLatitude**  <br>*optional*|The geographical latitude of the provider.|number(float)|
|**geoLongitude**  <br>*optional*|The geographical longitude of the provider.|number(float)|
|**name**  <br>*optional*|The name under which the provider has been registered in a zone.|string|
|**redirectionPoint**  <br>*optional*|The address used for user redirection from a zone to the provider.|string|

**Example**
```
{
  "name" : "Provider1",
  "redirectionPoint" : "https://192.168.11.23",
  "geoLongitude" : -24.3776025,
  "geoLatitude" : -128.3519364
}
```



