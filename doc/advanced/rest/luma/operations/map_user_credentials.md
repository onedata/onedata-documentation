
<a name="map_user_credentials"></a>
#### Map user credentials
```
POST /map_user_credentials
```


##### Description
Returns user credentials to storage based on user federated identity. In general, proper storage credentials can be chosen based on any property from the user model, including Onedata user Id or user Id from other IdP's, as well as any other property such as email.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Body**|**userCredentialsRequest**  <br>*required*|User credentials mapping request.|[UserCredentialsRequest](../definitions/UserCredentialsRequest.md#usercredentialsrequest)|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|User details returned successfully.|[UserStorageCredentials](../definitions/UserStorageCredentials.md#userstoragecredentials)|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|[Error](../definitions/Error.md#error)|
|**404**|User credentials not found.|[Error](../definitions/Error.md#error)|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


##### Consumes

* `application/json`


##### Produces

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/map_user_credentials"
```


###### Request body
```
json :
{
  "storageId" : "AKSDHKAJSHD898798ASDKJHA89878ASD",
  "storageName" : "NFS",
  "spaceId" : "98ASDKJHA89878ASDAKSDHKAJSHD898798",
  "userDetails" : {
    "id" : "ASDJASDNNALSDNALSDNALSDLASD",
    "name" : "User One",
    "linkedAccounts" : [ {
      "idp" : "github",
      "subjectId" : "ASDJH65675ASD765ASD890ASD6",
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


##### Example HTTP response

###### Response 200
```
json :
{
  "type" : "string",
  "storageId" : "string",
  "storageName" : "string",
  "aclName" : "string"
}
```


###### Response 400
```
json :
{
  "error" : "invalid_user",
  "errorDescription" : "Invalid user ID."
}
```


###### Response 403
```
json :
{
  "error" : "invalid_user",
  "errorDescription" : "Invalid user ID."
}
```


###### Response 404
```
json :
{
  "error" : "invalid_user",
  "errorDescription" : "Invalid user ID."
}
```


###### Response 500
```
json :
{
  "error" : "invalid_user",
  "errorDescription" : "Invalid user ID."
}
```



