
<a name="update_user_details"></a>
#### Update user details
```
PUT /admin/users/{lid}
```


##### Description
Allows to update user details, based on which credential mapping will be performed. Typically this operation can be left unimplemented, as the mapping logic can should use external, however for simple scenarios this interface can be used to configure the user storage credential mapping.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**lid**  <br>*required*|LUMA user Id.|integer|--|
|**Body**|**userDetails**  <br>*required*|Add user details for mapping.|[UserDetails](../definitions/UserDetails.md#userdetails)|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|User details added successfully.|No Content|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|[Error](../definitions/Error.md#error)|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


##### Consumes

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/admin/users/0"
```


###### Request body
```
json :
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


##### Example HTTP response

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


###### Response 500
```
json :
{
  "error" : "invalid_user",
  "errorDescription" : "Invalid user ID."
}
```



