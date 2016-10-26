
<a name="remove_user"></a>
#### Remove Onepanel user
```
DELETE /users/{username}
```


##### Description
Removes the Onepanel user account.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**username**  <br>*required*|The name of the user to be removed.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|The user account has been successfully removed.|No Content|
|**401**|Unauthorized request.|No Content|
|**403**|Forbidden request.|No Content|
|**404**|User account not found.|No Content|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


##### Example HTTP request

###### Request path
```
json :
"/users/string"
```


##### Example HTTP response

###### Response 500
```
json :
{
  "error" : "Invalid Request",
  "description" : "User role must be one of 'admin' or 'regular'."
}
```


