
<a name="list_effective_handle_user_privileges"></a>
#### List effective handle user privileges
```
GET /handles/{hndl}/effective_users/{uid}/privileges
```


##### Description
Returns effective user privileges for accessing a handle instance.

This operation requires `view_handle` privilege.

***Example cURL requests***

**Get effective handle user privileges**
```bash
curl -u username:password -X GET \
https://$HOST:8443/api/v3/handles/SADHLKJhlkASHDLAKSHDLKJHJjLH/effective_users/hlkASHDLAKSHDLKJHJjLHSADHLKJhlk/privileges

{
  "privileges": [
    "modify_handle",
    "view_handle"
  ]
}
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**hndl**  <br>*required*|The ID of the handle service.|string|--|
|**Path**|**uid**  <br>*required*|The ID of the user of a handle service.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The effective list of privileges of a user to a specific handle.|[HandlePrivileges](../definitions/HandlePrivileges.md#handleprivileges)|
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
"/handles/string/effective_users/string/privileges"
```


##### Example HTTP response

###### Response 200
```
json :
{
  "privileges" : [ "delete_handle", "modify_handle", "view_handle" ]
}
```


###### Response 400
```
json :
{
  "error" : "Provided data could not be understood by the server"
}
```


###### Response 401
```
json :
{
  "error" : "Provided data could not be understood by the server"
}
```


###### Response 403
```
json :
{
  "error" : "Provided data could not be understood by the server"
}
```


###### Response 404
```
json :
{
  "error" : "Provided data could not be understood by the server"
}
```


###### Response 500
```
json :
{
  "error" : "Provided data could not be understood by the server"
}
```



