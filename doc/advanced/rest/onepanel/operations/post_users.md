
<a name="post_users"></a>
#### Create user
```
POST /users
```


##### Description
Creates a Onepanel user account.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Body**|**userCreateRequest**  <br>*required*||[UserCreateRequest](../definitions/UserCreateRequest.md#usercreaterequest)|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|The user account has been successfully created.|No Content|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|[Error](../definitions/Error.md#error)|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


##### Consumes

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/users"
```


###### Request body
```
json :
{
  "username" : "john",
  "password" : "P@@$$W0RD",
  "userRole" : "admin"
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


###### Response 500
```
json :
{
  "error" : "Authentication Error",
  "description" : "Invalid username or password."
}
```



