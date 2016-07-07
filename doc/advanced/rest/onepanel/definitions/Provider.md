
<a name="provider"></a>
### Provider
Describes the properties of a Worker process instance.


|Name|Description|Schema|
|---|---|---|
|**geoLatitude**  <br>*optional*|Geographical latitude of the storage provider.|number|
|**geoLongitude**  <br>*optional*|Geographical longitude of the storage provider.|number|
|**name**  <br>*optional*|The name under which the provider should be registered in the zone.|string|
|**redirectionPoint**  <br>*optional*|Redirection point.|string|
|**register**  <br>*optional*|Whether the provider should be automatically registered.|boolean|

**Example**
```
{
  "register" : true,
  "name" : "Provider1",
  "redirectionPoint" : "https://192.168.11.23:8443/",
  "geoLongitude" : -24.3776025,
  "geoLatitude" : -128.3519364
}
```



