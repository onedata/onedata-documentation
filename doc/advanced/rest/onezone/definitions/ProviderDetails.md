
<a name="providerdetails"></a>
### ProviderDetails
Provider properties.


|Name|Description|Schema|
|---|---|---|
|**latitude**  <br>*optional*|The geographical latitude of the provider data center location.|number|
|**longitude**  <br>*optional*|The geographical longitude of the provider data center location.|number|
|**providerId**  <br>*optional*|The provider ID.|string|
|**redirectionPoint**  <br>*optional*|The redirection URL for the provider.|string|
|**urls**  <br>*optional*|The list of urls where the provider can be reached.|< string > array|

**Example**
```
{
  "providerId" : "LASDASJDBH89869ASD79869asd",
  "urls" : [ "http://beta.onedata.org/provider1", "http://beta.onedata.org/provider2" ],
  "redirectionPoint" : "http://beta.onedata.org/provider2",
  "latitude" : 50.0647,
  "longitude" : 19.945
}
```



