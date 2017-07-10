
<a name="list_handle_service_group_privileges"></a>
#### List handle service group privileges
```
GET /handle_services/{id}/groups/{gid}/privileges
```


##### Description
Returns group privileges for accessing a handle service instance.

This operation requires `handle_service_view` privilege.

***Example cURL requests***

**Get handle service group privileges**
```bash
curl -u username:password -X GET \
https://$HOST:8443/api/v3/handle_services/SADHLKJhlkASHDLAKSHDLKJHJjLH/group/hlkASHDLAKSHDLKJHJjLHSADHLKJhlk/privileges

{
  "privileges": [
    "handle_service_delete",
    "handle_service_view"
  ]
}
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
  "operation" : [ "grant" ],
  "privileges" : [ "handle_service_delete", "handle_service_list_handles", "handle_service_register_handle", "handle_service_update", "handle_service_view" ]
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



