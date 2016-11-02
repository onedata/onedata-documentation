
<a name="get_user"></a>
#### Get Onepanel user details
```
GET /users/{username}
```


##### Description
Returns the configuration information of the Onepanel user.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**username**  <br>*required*|The name of the user whose details should be returned.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The configuration information of the user.|[UserDetails](../definitions/UserDetails.md#userdetails)|
|**401**|Unauthorized request.|No Content|
|**403**|Forbidden request.|No Content|
|**404**|The user does not exist.|No Content|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


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


###### Response 500
```
json :
{
  "error" : "Invalid Request",
  "description" : "User role must be one of 'admin' or 'regular'."
}
```



