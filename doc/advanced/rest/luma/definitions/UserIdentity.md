
<a name="useridentity"></a>
### UserIdentity
User identity.


|Name|Description|Schema|
|---|---|---|
|**idp**  <br>*optional*|Id of identity provider that was (or will be) used by subject user to log in<br>into onezone, identical to id specified in auth.config / saml.config.<br>If the user was created via onepanel, use the value "onezone".|string|
|**userId**  <br>*optional*|Id of user as recognized by the identity provider. If the user was created<br>via onepanel, use the userId from onepanel (can be checked using REST).|string|

**Example**
```
{
  "idp" : "google",
  "userId" : "5484af38-8b5d-464f-bdd1-da9ef801090f"
}
```



