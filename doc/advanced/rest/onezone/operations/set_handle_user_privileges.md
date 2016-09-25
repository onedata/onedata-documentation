
<a name="set_handle_user_privileges"></a>
#### Set handle user privileges
```
PUT /handles/{hndl}/users/{uid}/privileges
```


##### Description
Sets user privileges for accessing a handle instance.

This operation requires `modify_handle` privilege.

***Example cURL requests***

**Set handle user privileges**
```bash
curl -k -u username:password -X PUT -H "Content-type: application/json" \
-d '{"privileges": ["handle_change_data"]}' \
https://$HOST:8443/api/v3/handles/SADHLKJhlkASHDLAKSHDLKJHJjLH/users/hlkASHDLAKSHDLKJHJjLHSADHLKJhlk/privileges
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**hndl**  <br>*required*|The ID of the handle.|string|--|
|**Path**|**uid**  <br>*required*|The ID of the user of a handle.|string|--|
|**Body**|**privileges**  <br>*required*|The list of user privileges to a specific handle.|[HandlePrivileges](../definitions/HandlePrivileges.md#handleprivileges)|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|User privileges updated successfully.|No Content|
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
"/handles/string/users/string/privileges"
```


###### Request body
```
json :
{
  "privileges" : [ "unregister_handle", "handle_change_data", "handle_view_data" ]
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



