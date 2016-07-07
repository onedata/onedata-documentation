
<a name="user"></a>
### User
Describes a user account.


|Name|Description|Schema|
|---|---|---|
|**alias**  <br>*optional*|User alias|string|
|**connectedAccounts**  <br>*optional*|The list of accounts connected to this user.|< [ConnectedAccount](ConnectedAccount.md#connectedaccount) > array|
|**emailList**  <br>*optional*||< string > array|
|**name**  <br>*required*|The user friendly name of storage resource.|string|
|**userId**  <br>*required*|Unique user ID.|string|

**Example**
```
{
  "userId" : "ALKJSDH77i79ASDKJA-ASDBAS9-87",
  "name" : "Rudolf Lingens",
  "connectedAccounts" : [ {
    "accountId" : "ASD879ASD-7SADASFSsa0831",
    "providerId" : "7YASBFLJ-123ASD870-ASDASD"
  }, {
    "accountId" : "QWESsD-7SADASFSsa0831",
    "providerId" : "7QWEJ-123ASD870-ASDASD"
  } ],
  "alias" : "John Doe",
  "emailList" : [ "rudolf.linges@example.com", "john.doe@example.com" ]
}
```



