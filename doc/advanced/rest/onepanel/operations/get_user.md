
<a name="get_user"></a>
#### Get user details
```
GET /user
```


##### Description
Returns the basic information about a user.


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|User details returned successfully.|[UserDetailsResponse](../definitions/UserDetailsResponse.md#userdetailsresponse)|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|[Error](../definitions/Error.md#error)|
|**404**|Onepanel service is not available.|[Error](../definitions/Error.md#error)|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


##### Produces

* `application/x-yaml`


##### Example HTTP request

###### Request path
```
json :
"/user"
```


##### Example HTTP response

###### Response 200
```
json :
{
  "username" : "onedatauser",
  "userRole" : "admin"
}
```


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



