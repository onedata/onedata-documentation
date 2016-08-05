
<a name="userdetails"></a>
### UserDetails
User details needed for user mapping.


|Name|Description|Schema|
|---|---|---|
|**alias**  <br>*optional*|User alias.|string|
|**connectedAccounts**  <br>*optional*|The list of user Open ID accounts.|< [ConnectedAccount](ConnectedAccount.md#connectedaccount) > array|
|**emailList**  <br>*optional*|The list of user email accounts.|< string > array|
|**id**  <br>*optional*|Onedata user ID.|string|
|**name**  <br>*optional*|User name.|string|

**Example**
```
{
  "id" : "ASDJH65675ASD765ASD890ASD6",
  "name" : "user1",
  "connectedAccounts" : [ {
    "providerId" : "ASDKLJH859876ASD87687ASDU",
    "userId" : "ASDJH65675ASD765ASD890ASD6",
    "login" : "user1",
    "name" : "User One",
    "emailList" : [ "user.1@example.com", "user.one@example.com", "user.i@example.com" ]
  } ],
  "alias" : "user.one",
  "emailList" : [ "user.1@example2.com", "user.one@example2.com", "user.i@example2.com" ]
}
```



