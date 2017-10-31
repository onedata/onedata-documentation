
<a name="groupidentity"></a>
### GroupIdentity
Group identity.


|Name|Description|Schema|
|---|---|---|
|**groupId**  <br>*optional*|Id of a group as recognized by a specific identity provider.|string|
|**idp**  <br>*optional*|Id of identity provider that was (or will be) used by subject user to log in into onezone, identical to id specified in auth.config / saml.config.|string|

**Example**
```
{
  "idp" : "github",
  "groupId" : "5484af38-8b5d-464f-bdd1-da9ef801090f"
}
```



