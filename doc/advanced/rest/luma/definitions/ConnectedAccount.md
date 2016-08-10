
<a name="connectedaccount"></a>
### ConnectedAccount
User connected account.


|Name|Description|Schema|
|---|---|---|
|**emailList**  <br>*required*|The list of user email accounts.|< string > array|
|**login**  <br>*required*|User login name.|string|
|**name**  <br>*required*|User full name.|string|
|**providerId**  <br>*required*|ID of the storage provider.|string|
|**userId**  <br>*required*|User ID assigned in Onezone.|string|

**Example**
```
{
  "providerId" : "ASDKLJH859876ASD87687ASDU",
  "userId" : "ASDJH65675ASD765ASD890ASD6",
  "login" : "user1",
  "name" : "User One",
  "emailList" : [ "user.1@example.com", "user.one@example.com", "user.i@example.com" ]
}
```



