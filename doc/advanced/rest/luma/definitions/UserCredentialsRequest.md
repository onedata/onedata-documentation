
<a name="usercredentialsrequest"></a>
### UserCredentialsRequest
User credentials request - provides all necessary information to perform the mapping from federated user to storage credentials.


|Name|Description|Schema|
|---|---|---|
|**storageId**  <br>*optional*|Storage ID.|string|
|**storageName**  <br>*optional*|Administrator defined storage name.|string|
|**userDetails**  <br>*required*||[UserDetails](UserDetails.md#userdetails)|

**Example**
```
{
  "storageId" : "AKSDHKAJSHD898798ASDKJHA89878ASD",
  "storageName" : "NFS",
  "userDetails" : {
    "id" : "ASDJASDNNALSDNALSDNALSDLASD",
    "name" : "User One",
    "connectedAccounts" : [ {
      "idp" : "github",
      "userId" : "ASDJH65675ASD765ASD890ASD6",
      "login" : "user1",
      "name" : "User One",
      "emailList" : [ "user.1@example.com", "user.one@example.com", "user.i@example.com" ],
      "groups" : [ "vo:example-org.eu/tm:members/member", "vo:example-org.eu/rl:administration/admin" ]
    } ],
    "login" : "user.one",
    "emailList" : [ "user.1@example2.com", "user.one@example2.com", "user.i@example2.com" ]
  }
}
```



