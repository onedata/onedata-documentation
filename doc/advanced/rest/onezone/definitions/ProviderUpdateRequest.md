
<a name="providerupdaterequest"></a>
### ProviderUpdateRequest
Provider settings update request.


|Name|Description|Schema|
|---|---|---|
|**latitude**  <br>*optional*|The geographical latitude of the provider data center location.|number|
|**longitude**  <br>*optional*|The geographical longitude of the provider data center location.|number|
|**name**  <br>*optional*|Provider name.|string|
|**redirectionPoint**  <br>*optional*|The redirection URL for the provider.|string|
|**urls**  <br>*optional*|The list of urls where the provider can be reached.|< string > array|

**Example**
```
{
  "name" : "Example provider",
  "redirectionPoint" : "http://beta.onedata.org/provider2"
}
```



