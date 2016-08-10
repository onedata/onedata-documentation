
<a name="add_user_to_space"></a>
#### Add user to space
```
PUT /spaces/{id}/users
```


##### Description
Allows to add a user to any space. 

This operation can be invoked by system administrators only
and requires `add_member_to_space` privilege.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*|Space ID.|string|--|
|**Body**|**userId**  <br>*required*||[userId](#add_user_to_space-userid)|--|

<a name="add_user_to_space-userid"></a>
**userId**

|Name|Description|Schema|
|---|---|---|
|**userId**  <br>*optional*|ID of the user to add to space.|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|The user was added to the space.|No Content|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**401**|Authentication error.|[Error](../definitions/Error.md#error)|
|**403**|Authorization error.|[Error](../definitions/Error.md#error)|
|**404**|Resource not found.|[Error](../definitions/Error.md#error)|
|**500**|Internal server Error.|[Error](../definitions/Error.md#error)|


##### Consumes

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/spaces/string/users"
```


###### Request body
```
json :
{
  "userId" : "string"
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



