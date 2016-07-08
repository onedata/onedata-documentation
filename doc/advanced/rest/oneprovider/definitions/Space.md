
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
  "spaceId" : "KJHJASD-798756876-ASDBKASD-6876",
  "name" : "My Space 1",
  "providers" : [ {
    "providerId" : "OIUOASD-798756876-ASDBKASD-6876",
    "providerName" : "MyPrivateCloud"
  }, {
    "providerId" : "LJKHSDA-798756876-ASDBKASD-6876",
    "providerName" : "PublicCloud1"
  } ]
}
```



