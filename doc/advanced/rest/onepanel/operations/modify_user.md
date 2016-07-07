
<a name="modify_user"></a>
#### Modify user settings
```
PUT /user
```


##### Description
Modifies user account details. Currently only password modification is allowed.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Body**|**userDetails**  <br>*required*|New user account details.|[UserDetails](../definitions/UserDetails.md#userdetails)|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|User details updated successfully.|No Content|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|[Error](../definitions/Error.md#error)|
|**404**|Onepanel service is not available.|[Error](../definitions/Error.md#error)|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


##### Consumes

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/user"
```


###### Request body
```
json :
{
  "username" : "onedatauser",
  "password" : "P@@$$W0RD",
  "userRole" : "admin"
}
```


##### Example HTTP response

###### Response 400
```
json :
{
  "error" : "invalid_token",
  "error_description" : "Provided token could not be validated."
}
```


###### Response 403
```
json :
{
  "error" : "invalid_token",
  "error_description" : "Provided token could not be validated."
}
```


###### Response 404
```
json :
{
  "error" : "invalid_token",
  "error_description" : "Provided token could not be validated."
}
```


###### Response 500
```
json :
{
  "error" : "invalid_token",
  "error_description" : "Provided token could not be validated."
}
```



