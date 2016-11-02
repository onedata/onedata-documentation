
<a name="modify_user"></a>
#### Modify Onepanel user details
```
PATCH /users/{username}
```


##### Description
Modifies the Onepanel user password.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**username**  <br>*required*|The user name.|string|--|
|**Body**|**userModifyRequest**  <br>*required*||[UserModifyRequest](../definitions/UserModifyRequest.md#usermodifyrequest)|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|The user password has been successfully changed.|No Content|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**401**|Unauthorized request.|No Content|
|**403**|Forbidden request.|No Content|
|**404**|The user does not exist.|No Content|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


##### Consumes

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/users/string"
```


###### Request body
```
json :
{
  "password" : "P@@$$W0RD"
}
```


##### Example HTTP response

###### Response 400
```
json :
{
  "error" : "Invalid Request",
  "description" : "User role must be one of 'admin' or 'regular'."
}
```


###### Response 500
```
json :
{
  "error" : "Invalid Request",
  "description" : "User role must be one of 'admin' or 'regular'."
}
```



