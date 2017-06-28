
<a name="add_group_to_space"></a>
#### Add group to space
```
PUT /spaces/{id}/groups/{gid}
```


##### Description
Allows to add a group to any space. Optional privileges
can be passed in the request body, otherwise default
privileges will be set for group in this space.

This operation can be invoked by system administrators only
and requires `oz_spaces_add_members` privilege.

***Example cURL requests***

**Add group to space**
```bash
curl -u username:password  -H "Content-type: application/json" -X PUT \
 https://$HOST:8443/api/v3/onezone/spaces/9ueUeoZA6KXxNgzlvqmmrbzqE_BQiaHEEDC21sY1Kuc/groups/qE_BQiaHEEDC21sY1Kuc9ueUeoZA6KXxNgzlvqmmrbz
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**gid**  <br>*required*|Group ID.|string|--|
|**Path**|**id**  <br>*required*|Space ID.|string|--|
|**Body**|**privileges**  <br>*optional*||[SpacePrivileges](../definitions/SpacePrivileges.md#spaceprivileges)|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|The group was added to the space.|No Content|
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
"/spaces/string/groups/string"
```


###### Request body
```
json :
{
  "operation" : [ "set" ],
  "privileges" : [ "space_invite_provider", "space_update", "space_invite_group", "space_invite_user", "space_manage_shares", "space_delete", "space_remove_group", "space_remove_provider", "space_remove_user", "space_set_privileges", "space_view", "space_write_data" ]
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



