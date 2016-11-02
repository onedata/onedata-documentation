
<a name="add_user"></a>
#### Create Onepanel user
```
POST /users
```


##### Description
Creates a new Onepanel user account.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Body**|**userCreateRequest**  <br>*required*|The user configuration details.|[UserCreateRequest](../definitions/UserCreateRequest.md#usercreaterequest)|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|The user account has been successfully created.|No Content|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|No Content|
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



