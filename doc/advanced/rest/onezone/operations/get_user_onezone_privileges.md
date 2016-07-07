
<a name="get_user_onezone_privileges"></a>
#### Get user's Onezone privileges
```
GET /privileges/users/{id}
```


##### Description
Returns the list of user privileges for Onezone.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*|User ID.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The list of user privileges in Onezone.|[OnezonePrivileges](../definitions/OnezonePrivileges.md#onezoneprivileges)|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**401**|Authentication error.|[Error](../definitions/Error.md#error)|
|**403**|Authorization error.|[Error](../definitions/Error.md#error)|
|**404**|Resource not found.|[Error](../definitions/Error.md#error)|
|**500**|Internal server Error.|[Error](../definitions/Error.md#error)|


##### Produces

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/privileges/users/string"
```


##### Example HTTP response

###### Response 200
```
json :
{
  "privileges" : [ "view_privileges", "set_privileges", "list_spaces", "list_providers", "list_providers_of_space" ]
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


###### Response 401
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



