
<a name="space"></a>
### Space
User space parameters.


|Name|Description|Schema|
|---|---|---|
|**name**  <br>*required*|The name of the space.|string|
|**providersSupports**  <br>*required*|The map of providers Ids supporting this space and the size of provisioned storage in bytes.|< string, integer > map|
|**spaceId**  <br>*required*|Unique ID of the space.|string|

**Example**
```
{
  "spaceId" : "Xnp1JVpWfL8_stHJgct76AFALjRsI0W3rNs1nfMwqnY",
  "name" : "My Private space",
  "providersSupports" : {
    "hxfMCWmquqAIjG1GeG2eZY8qvs8iRIn09HzjCJilnSE" : 5368709120
  }
}
```



