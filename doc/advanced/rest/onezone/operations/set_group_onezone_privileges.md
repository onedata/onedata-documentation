
<a name="set_group_onezone_privileges"></a>
#### Set group's Onezone privileges
```
PUT /privileges/group/{id}
```


##### Description
Sets privileges for a user {id} for Onezone.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*|Group ID.|string|--|
|**Body**|**data**  <br>*optional*|User Onezone privileges.|[OnezonePrivileges](../definitions/OnezonePrivileges.md#onezoneprivileges)|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The group privileges have been added.|No Content|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**401**|Authentication error.|[Error](../definitions/Error.md#error)|
|**403**|Authorization error.|[Error](../definitions/Error.md#error)|
|**404**|Resource not found.|[Error](../definitions/Error.md#error)|
|**500**|Internal server Error.|[Error](../definitions/Error.md#error)|


##### Example HTTP request

###### Request path
```
json :
"/privileges/group/string"
```


###### Request body
```
json :
{
  "privileges" : [ "view_privileges", "set_privileges", "list_spaces", "list_providers", "list_providers_of_space" ]
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



