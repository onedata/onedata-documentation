
<a name="usercredentialsrequest"></a>
### UserCredentialsRequest
User credentials request - provides all necessary information to perform the account mapping.


|Name|Description|Schema|
|---|---|---|
|**spaceName**  <br>*required*|Name of user space for which storage mapping is requested.|string|
|**storageId**  <br>*optional*|Storage ID (site specific), can be used interchangeably with `spaceType`.|string|
|**storageType**  <br>*optional*|Storage ID (site specific), can be used interchangeably with `spaceId`.|string|
|**userDetails**  <br>*required*||[UserDetails](UserDetails.md#userdetails)|

**Example**
```
{
  "storageId" : "AKSDHKAJSHD898798ASDKJHA89878ASD",
  "storageType" : "POSIX",
  "spaceName" : "Space1",
  "userDetails" : {
    "name" : "User One",
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
}
```



