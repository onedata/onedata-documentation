
<a name="list_effective_handle_group_privileges"></a>
#### List effective handle group privileges
```
GET /handles/{hndl}/effective_groups/{gid}/privileges
```


##### Description
Returns effective group privileges for accessing a handle instance.

This operation requires `handle_view` privilege.

***Example cURL requests***

**Get handle group privileges**
```bash
curl -u username:password -X GET \
https://$HOST:8443/api/v3/handles/DLAKSHDLKJHJjSADHLKJhlkASHLH/effective_groups/HJjLHSADHhlkASHDLAKSHDLKJLKJhlk/privileges

{
  "privileges": [
    "handle_view"
  ]
}
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**gid**  <br>*required*|The ID of the group of a handle.|string|--|
|**Path**|**hndl**  <br>*required*|The ID of the handle.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The effective list of privileges of a group to a specific handle.|[HandlePrivileges](../definitions/HandlePrivileges.md#handleprivileges)|
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
"/handles/string/effective_groups/string/privileges"
```


##### Example HTTP response

###### Response 200
```
json :
{
  "operation" : [ "grant" ],
  "privileges" : [ "handle_delete", "handle_update", "handle_view" ]
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



