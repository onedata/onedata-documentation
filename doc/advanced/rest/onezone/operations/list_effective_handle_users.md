
<a name="list_effective_handle_users"></a>
#### List effective handle users
```
GET /handles/{hndl}/effective_users
```


##### Description
Returns effective list of users with access to a handle instance.

This operation requires `view_handle` privilege.

***Example cURL requests***

**Get handle users**
```bash
curl -u username:password -X GET \
https://$HOST:8443/api/v3/handles/SADHLKJhlkASHDLAKSHDLKJHJjLH/effective_users

{
  "users": [
    "LAKSHDLKLKJhlkASHDJHJjL",
    "HDLKJHJjLLKLAKSJhlkASHD"
  ]
}
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**hndl**  <br>*required*|The ID of the handle service.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The effective list of identifiers of users with access to specific handle.|[Users](../definitions/Users.md#users)|
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
"/handles/string/effective_users"
```


##### Example HTTP response

###### Response 200
```
json :
{
  "users" : [ "Bmav38YI0Z2-dw-fvrZ3XP-J0HjCN0taT3_WungK", "ASmlkZW50aWZpZXIgOEhmSEFSSGdrbHFCa1pWSTR" ]
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



