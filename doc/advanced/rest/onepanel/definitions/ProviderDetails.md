
<a name="providerdetails"></a>
### ProviderDetails
The provider configuration details.


|Name|Description|Schema|
|---|---|---|
|**geoLatitude**  <br>*required*|The geographical latitude of the provider.|number(float)|
|**geoLongitude**  <br>*required*|The geographical longitude of the provider.|number(float)|
|**id**  <br>*required*|The ID assigned by a zone.|string|
|**name**  <br>*required*|The name under which the provider has been registered in a zone.|string|
|**redirectionPoint**  <br>*required*|The address used for user redirection from a zone to the provider.|string|
|**urls**  <br>*required*|The list of IP addresses of provider cluster worker nodes.|< string > array|

**Example**
```
{
  "id" : "VAiDGZbs3k0FD8jPhyU1",
  "name" : "Provider1",
  "urls" : [ "192.168.11.23" ],
  "redirectionPoint" : "https://192.168.11.23",
  "geoLongitude" : -24.3776025,
  "geoLatitude" : -128.3519364
}
```



