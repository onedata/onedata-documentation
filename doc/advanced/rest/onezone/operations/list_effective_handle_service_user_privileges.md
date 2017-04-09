
<a name="list_effective_handle_service_user_privileges"></a>
#### List effective handle service user privileges
```
GET /handle_services/{id}/effective_users/{uid}/privileges
```


##### Description
Returns user privileges for accessing a handle service instance.

This operation requires `view_handle_service` privilege.

***Example cURL requests***

**Get effective handle service user privileges**
```bash
curl -u username:password -X GET \
https://$HOST:8443/api/v3/handle_services/SADHLKJhlkASHDLAKSHDLKJHJjLH/effective_users/hlkASHDLAKSHDLKJHJjLHSADHLKJhlk/privileges

{
  "users": [
    "register_doi",
    "view_handle_service"
  ]
}
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*|The ID of the handle service.|string|--|
|**Path**|**uid**  <br>*required*|The ID of the user of a handle service.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The list of privileges of a user to a specific handle service.|[HandleServicePrivileges](../definitions/HandleServicePrivileges.md#handleserviceprivileges)|
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
"/handle_services/string/effective_users/string/privileges"
```


##### Example HTTP response

###### Response 200
```
json :
{
  "privileges" : [ "view_handle_service", "modify_handle_service", "delete_handle_service", "register_handle", "handle_service_list_handles" ]
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



