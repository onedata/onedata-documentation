
<a name="get_handle_service_group_privileges"></a>
#### Get handle service group privileges
```
GET /handle_services/{id}/groups/{gid}/privileges
```


##### Description
Returns group privileges for accessing a handle service instance.

This operation requires `view_handle_service` privilege.

***Example cURL requests***

**Get handle service group privileges**
```bash
curl -k -u username:password -X GET \
https://$HOST:8443/api/v3/handle_services/SADHLKJhlkASHDLAKSHDLKJHJjLH/group/hlkASHDLAKSHDLKJHJjLHSADHLKJhlk/privileges

[
  "register_doi",
  "view_handle_service"
]
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**gid**  <br>*required*|The ID of the group of a handle service.|string|--|
|**Path**|**id**  <br>*required*|The ID of the handle service.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The list of privileges of a group to a specific handle service.|[HandleServicePrivileges](../definitions/HandleServicePrivileges.md#handleserviceprivileges)|
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
"/handle_services/string/groups/string/privileges"
```


##### Example HTTP response

###### Response 200
```
json :
{
  "privileges" : [ "register_handle", "handle_service_remove", "handle_service_change_data", "handle_service_view_data", "handle_service_add_user", "handle_service_remove_user", "handle_service_add_group", "handle_service_remove_group" ]
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



