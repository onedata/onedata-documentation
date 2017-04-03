
<a name="list_space_group_privileges"></a>
#### List group privileges to space
```
GET /spaces/{id}/groups/{gid}/privileges
```


##### Description
Returns privileges for a group to a specific space.

This operation requires `space_view_data` privilege.

***Example cURL requests***

**Get space group privileges**
```bash
curl -u admin:password -X GET \
https://$HOST:8443/api/v3/onezone/spaces/9ueUeoZA6KXxNgzlvqmmrbzqE_BQiaHEEDC21sY1Kuc/groups/T5x_HhFYOnILOCUf9OqgExw00RwaU2MXT5122oWk_sM/privileges

{
  "privileges": [
    "space_view_data"
  ]
}
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**gid**  <br>*required*|Group ID.|string|--|
|**Path**|**id**  <br>*required*|Space ID.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The list of group privileges in a space.|[SpacePrivileges](../definitions/SpacePrivileges.md#spaceprivileges)|
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
"/spaces/string/groups/string/privileges"
```


##### Example HTTP response

###### Response 200
```
json :
{
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


