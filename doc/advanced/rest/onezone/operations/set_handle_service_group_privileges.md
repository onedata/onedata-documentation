
<a name="set_handle_service_group_privileges"></a>
#### Set handle service groups privileges
```
PUT /handle_services/{id}/groups/{gid}/privileges
```


##### Description
Sets group privileges for accessing a handle service instance.

This operation requires `modify_handle_service` privilege.

***Example cURL requests***

**Set handle service group privileges**
```bash
curl -k -u username:password -X PUT  -H "Content-type: application/json" \
-d '{"privileges": ["register_handle"]}' \
https://$HOST:8443/api/v3/handle_services/SADHLKJhlkASHDLAKSHDLKJHJjLH/group/hlkASHDLAKSHDLKJHJjLHSADHLKJhlk/privileges
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**gid**  <br>*required*|The ID of the group of a handle service.|string|--|
|**Path**|**id**  <br>*required*|The ID of the handle service.|string|--|
|**Body**|**privileges**  <br>*required*|The list of group privileges to specific handle service.|[HandleServicePrivileges](../definitions/HandleServicePrivileges.md#handleserviceprivileges)|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|Group privileges updated successfully.|No Content|
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
"/handle_services/string/groups/string/privileges"
```


###### Request body
```
json :
{
  "privileges" : [ "register_handle", "handle_service_remove", "handle_service_change_data", "handle_service_view_data", "handle_service_add_user", "handle_service_remove_user", "handle_service_add_group", "handle_service_remove_group" ]
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



