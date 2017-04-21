
<a name="list_space_user_privileges"></a>
#### List user privileges to space
```
GET /spaces/{id}/users/{uid}/privileges
```


##### Description
Returns privileges of a user to a specific space.

This operation requires `space_view_data` privilege.

***Example cURL requests***

**Get user privileges to space**
```bash
curl -u username:password -X GET \
https://$HOST:8443/api/v3/onezone/spaces/9ueUeoZA6KXxNgzlvqmmrbzqE_BQiaHEEDC21sY1Kuc/users/lb0NvUXIVguzjQ3dBOXAyd1c61fWKB5dKJDQ6YvB7a0/privileges

{
  "privileges": [
    "space_add_provider",
    "space_change_data",
    "space_invite_group"
    ]
}
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*|Space ID.|string|--|
|**Path**|**uid**  <br>*required*|User ID.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The list of user privileges in a space.|[SpacePrivileges](../definitions/SpacePrivileges.md#spaceprivileges)|
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
"/spaces/string/users/string/privileges"
```


##### Example HTTP response

###### Response 200
```
json :
{
  "operation" : [ "set" ],
  "privileges" : [ "space_add_provider", "space_change_data", "space_invite_group", "space_invite_user", "space_manage_shares", "space_remove", "space_remove_group", "space_remove_provider", "space_remove_user", "space_set_privileges", "space_view_data", "space_write_files" ]
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



