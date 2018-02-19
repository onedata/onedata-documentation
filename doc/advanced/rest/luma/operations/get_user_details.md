
<a name="get_user_details"></a>
#### Get user details
```
GET /admin/users/{lid}
```


##### Description
Returns user details known by LUMA.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**lid**  <br>*required*|LUMA user Id.|integer|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|User details returned successfully.|[UserDetails](../definitions/UserDetails.md#userdetails)|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|[Error](../definitions/Error.md#error)|
|**404**|User credentials not found.|[Error](../definitions/Error.md#error)|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


##### Consumes

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/admin/users/0"
```


##### Example HTTP response

###### Response 200
```
json :
{
  "id" : "9743a66f914cc249efca164485a19c5c",
  "name" : "user1",
  "linkedAccounts" : [ {
    "idp" : "github",
    "subjectId" : "5c28904a-124a-4035-853c-36938143dd4e",
    "login" : "user1",
    "name" : "User One",
    "emailList" : [ "user.1@example.com", "user.one@example.com", "user.i@example.com" ]
  }, {
    "idp" : "EGI",
    "subjectId" : "john@example.com",
    "login" : "user1",
    "name" : "User One",
    "custom" : {
      "userCertificateSubject" : "/C=PL/O=GRID/O=ACME/CN=John Doe",
      "eduPersonPrincipalName" : "john@example.com"
    },
    "emailList" : [ "user.1@example.com" ]
  } ],
  "login" : "user_one",
  "emailList" : [ "user.1@example2.com", "user.one@example2.com", "user.i@example2.com" ]
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



