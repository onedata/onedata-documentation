
<a name="set_handle_service_user_privileges"></a>
#### Set handle service user privileges
```
PATCH /handle_services/{id}/users/{uid}/privileges
```


##### Description
Sets user privileges for accessing a handle service instance.

This operation requires `modify_handle_service` privilege.

***Example cURL requests***

**Set handle service user privileges**
```bash
curl -u username:password -X PATCH  -H "Content-type: application/json" \
-d '{"privileges": ["register_handle"]}' \
https://$HOST:8443/api/v3/handle_services/SADHLKJhlkASHDLAKSHDLKJHJjLH/users/hlkASHDLAKSHDLKJHJjLHSADHLKJhlk/privileges
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*|The ID of the handle service.|string|--|
|**Path**|**uid**  <br>*required*|The ID of the user of a handle service.|string|--|
|**Body**|**privileges**  <br>*required*|The list of user privileges to specific handle service.|[HandleServicePrivileges](../definitions/HandleServicePrivileges.md#handleserviceprivileges)|--|


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
"/handle_services/string/users/string/privileges"
```


###### Request body
```
json :
{
  "operation" : [ "grant" ],
  "privileges" : [ "view_handle_service", "modify_handle_service", "delete_handle_service", "register_handle", "handle_service_list_handles" ]
}
```


##### Example HTTP response

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



