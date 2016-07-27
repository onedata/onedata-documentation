
<a name="get_users_username"></a>
#### Get user details
```
GET /users/{username}
```


##### Description
Returns the configuration information of the Onepanel user.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**username**  <br>*required*|The name of a user whose details should be returned.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The configuration information of the user.|[UserDetails](../definitions/UserDetails.md#userdetails)|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|No Content|
|**404**|The user has not been found.|No Content|
|**500**|Internal server error.|No Content|


##### Produces

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/users/string"
```


##### Example HTTP response

###### Response 200
```
json :
{
  "userId" : "i3h2bp4TjPVuOyvXulbW",
  "userRole" : "admin"
}
```


###### Response 400
```
json :
{
  "error" : "Authentication Error",
  "description" : "Invalid username or password."
}
```



