
<a name="groupidentity"></a>
### GroupIdentity
Group identity.


|Name|Description|Schema|
|---|---|---|
|**groupId**  <br>*optional*|Id of a group as recognized by a specific identity provider. If this is provided as NULL, the map_group endpoint will return the default GID for current space.|string|
|**idp**  <br>*optional*|Id of identity provider that was (or will be) used by subject user to log in into onezone, identical to id specified in auth.config / saml.config.|string|
|**spaceId**  <br>*optional*|Space ID to provide default group context for space.|string|

**Example**
```
{
  "idp" : "github",
  "groupId" : "5484af38-8b5d-464f-bdd1-da9ef801090f"
}
```



