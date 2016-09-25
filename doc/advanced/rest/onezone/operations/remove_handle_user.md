
<a name="remove_handle_user"></a>
#### Remove handle user
```
DELETE /handles/{hndl}/users/{uid}
```


##### Description
Allows to remove a user from access to a handle.

This operation requires `modify_handle` privilege.

***Example cURL requests***

**Remove handle service user**
```bash
curl -k -u username:password -X DELETE \
https://$HOST:8443/api/v3/handles/AKSHDLKJHJjLHSADHLKJhlkASHDL/users/JHJjLHADHLKJhDLAKSHDLK
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**hndl**  <br>*required*|The ID of the handle.|string|--|
|**Path**|**uid**  <br>*required*|The ID of the user to remove from handle.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**202**|User removed successfully.|No Content|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**401**|Authentication error.|[Error](../definitions/Error.md#error)|
|**403**|Authorization error.|[Error](../definitions/Error.md#error)|
|**404**|Resource not found.|[Error](../definitions/Error.md#error)|
|**500**|Internal server Error.|[Error](../definitions/Error.md#error)|


##### Example HTTP request

###### Request path
```
json :
"/handles/string/users/string"
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



