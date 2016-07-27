
<a name="patch_users_username"></a>
#### Modify user details
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
|**403**|Forbidden request.|[Error](../definitions/Error.md#error)|
|**404**|The user has not been found.|[Error](../definitions/Error.md#error)|
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
  "error" : "Authentication Error",
  "description" : "Invalid username or password."
}
```


###### Response 403
```
json :
{
  "error" : "Authentication Error",
  "description" : "Invalid username or password."
}
```


###### Response 404
```
json :
{
  "error" : "Authentication Error",
  "description" : "Invalid username or password."
}
```


###### Response 500
```
json :
{
  "error" : "Authentication Error",
  "description" : "Invalid username or password."
}
```



