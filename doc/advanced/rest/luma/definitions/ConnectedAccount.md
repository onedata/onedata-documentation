
<a name="connectedaccount"></a>
### ConnectedAccount
User connected account.


|Name|Description|Schema|
|---|---|---|
|**custom**  <br>*optional*|This field stores all additional properties that were provided by the IdP for this user.|< string, string > map|
|**emailList**  <br>*optional*|The list of user email accounts.|< string > array|
|**groups**  <br>*optional*|A list of strings denoting user group memberships as acquired from the<br>identity provider. Memberships are in Onedata normalized form.|< string > array|
|**idp**  <br>*required*|ID of the identity provider.|string|
|**login**  <br>*optional*|User login name.|string|
|**name**  <br>*optional*|User full name.|string|
|**userId**  <br>*optional*|User ID assigned in Onezone.|string|

**Example**
```
{
  "idp" : "github",
  "userId" : "ASDJH65675ASD765ASD890ASD6",
  "login" : "user1",
  "name" : "User One",
  "emailList" : [ "user.1@example.com", "user.one@example.com", "user.i@example.com" ],
  "groups" : [ "vo:example-org.eu/tm:members/member", "vo:example-org.eu/rl:administration/admin" ],
  "custom" : [ {
    "eduPersonPrincipalName" : "user.1@example.com"
  }, {
    "userCertificateSubject" : "\t/C=PL/O=GRID/O=ACME/CN=User One"
  } ]
}
```



