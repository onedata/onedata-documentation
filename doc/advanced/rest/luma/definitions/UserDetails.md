
<a name="userdetails"></a>
### UserDetails
User details needed for user mapping.


|Name|Description|Schema|
|---|---|---|
|**connectedAccounts**  <br>*optional*|The list of user Open ID accounts.|< [ConnectedAccount](ConnectedAccount.md#connectedaccount) > array|
|**emailList**  <br>*optional*|The list of user email accounts.|< string > array|
|**id**  <br>*optional*|Onedata user ID.|string|
|**login**  <br>*optional*|User login.|string|
|**name**  <br>*optional*|User name.|string|

**Example**
```
{
  "id" : "9743a66f914cc249efca164485a19c5c",
  "name" : "user1",
  "connectedAccounts" : [ {
    "idp" : "github",
    "userId" : "5c28904a-124a-4035-853c-36938143dd4e",
    "login" : "user1",
    "name" : "User One",
    "emailList" : [ "user.1@example.com", "user.one@example.com", "user.i@example.com" ]
  }, {
    "idp" : "EGI",
    "userId" : "john@example.com",
    "login" : "user1",
    "name" : "User One",
    "custom" : {
      "userCertificateSubject" : "/C=PL/O=GRID/O=ACME/CN=John Doe",
      "eduPersonPrincipalName" : "john@example.com"
    },
    "emailList" : [ "user.1@example.com" ]
  } ],
  "login" : "user.one",
  "emailList" : [ "user.1@example2.com", "user.one@example2.com", "user.i@example2.com" ]
}
```



