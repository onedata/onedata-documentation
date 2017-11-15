
<a name="add_user_details"></a>
#### Add user details
```
POST /admin/users
```


##### Description
Add user details and return user LUMA ID. This operation returns the ID which represents the user in LUMA. It is necessary as not every user mapping requires user Id, thus this ID represents uniquely a certain user account for associated user accounts with storage credentials.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Body**|**userDetails**  <br>*required*|User details for mapping.|[UserDetails](../definitions/UserDetails.md#userdetails)|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**201**|ID of the created LUMA user in the form /admin/users/{lid} is returned in the response `Location` header.  <br>**Headers** :   <br>`Location` (string) : ID of the LUMA user.|No Content|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|[Error](../definitions/Error.md#error)|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


##### Consumes

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/admin/users"
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



