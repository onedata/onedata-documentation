
<a name="add_user_to_space"></a>
#### Add user to space
```
PUT /spaces/{id}/users/{uid}
```


##### Description
Allows to add a user to any space. Optional privileges
can be passed in the request body, otherwise default
privileges will be set for user in this space.

This operation can be invoked by system administrators only
and requires `oz_spaces_add_members` privilege.

***Example cURL requests***

**Add user to space**
```bash
curl -u username:password  -H "Content-type: application/json" -X PUT \
https://$HOST:8443/api/v3/onezone/spaces/9ueUeoZA6KXxNgzlvqmmrbzqE_BQiaHEEDC21sY1Kuc/users/lb0NvUXIVguzjQ3dBOXAyd1c61fWKB5dKJDQ6YvB7a0
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*|Space ID.|string|--|
|**Path**|**uid**  <br>*required*|User ID.|string|--|
|**Body**|**privileges**  <br>*optional*||[SpacePrivileges](../definitions/SpacePrivileges.md#spaceprivileges)|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|The user was added to the space.|No Content|
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
"/spaces/string/users/string"
```


###### Request body
```
json :
{
  "operation" : [ "set" ],
  "privileges" : [ "space_delete", "space_invite_group", "space_invite_provider", "space_invite_user", "space_manage_shares", "space_remove_group", "space_remove_provider", "space_remove_user", "space_set_privileges", "space_update", "space_view", "space_write_data" ]
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



