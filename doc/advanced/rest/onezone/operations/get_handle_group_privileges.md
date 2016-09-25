
<a name="get_handle_group_privileges"></a>
#### Get handle group privileges
```
GET /handles/{hndl}/groups/{gid}/privileges
```


##### Description
Returns group privileges for accessing a handle instance.

This operation requires `view_handle` privilege.

***Example cURL requests***

**Get handle group privileges**
```bash
curl -k -u username:password -X GET \
https://$HOST:8443/api/v3/handles/DLAKSHDLKJHJjSADHLKJhlkASHLH/group/HJjLHSADHhlkASHDLAKSHDLKJLKJhlk/privileges

[
  "view_handle
]
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**gid**  <br>*required*|The ID of the group of a handle.|string|--|
|**Path**|**hndl**  <br>*required*|The ID of the handle.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The list of privileges of a group to a specific handle.|[HandlePrivileges](../definitions/HandlePrivileges.md#handleprivileges)|
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
"/handles/string/groups/string/privileges"
```


##### Example HTTP response

###### Response 200
```
json :
{
  "privileges" : [ "unregister_handle", "handle_change_data", "handle_view_data" ]
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



