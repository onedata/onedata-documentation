
<a name="space"></a>
### Space
Basic information about space.


|Name|Description|Schema|
|---|---|---|
|**name**  <br>*optional*|Name of the space.|string|
|**providers**  <br>*optional*|The list of providers who support this space.|< [Provider](Provider.md#provider) > array|
|**spaceId**  <br>*optional*|ID of the space.|string|

**Example**
```
{
  "spaceId" : "cda5d1bd-ca13-40ef-95e6-51fc1cc3b322",
  "name" : "My Space 1",
  "providers" : [ {
    "providerId" : "c40a3a39-0bbc-41cd-878f-5591f8c55014",
    "providerName" : "MyPrivateCloud"
  }, {
    "providerId" : "27d58af6-82ef-4bdd-a596-c4ff080fbde6",
    "providerName" : "PublicCloud1"
  } ]
}
```



