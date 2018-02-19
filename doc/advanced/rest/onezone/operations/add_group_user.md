
<a name="add_group_user"></a>
#### Add user to group
```
PUT /groups/{id}/users/{uid}
```


##### Description
Returns the public information about a user {uid} in group {id}.

Optionally, user privileges in this group can be specified
in the request body.

This operation requires `oz_groups_add_members` administrator privilege.

***Example cURL requests***

**Generate user group invite token**
```bash
curl -u admin:password -X PUT \
https://$HOST/api/v3/onezone/groups/HwUpk8jrwxKOe45uzLFX2GVC8lKEasj4q253sptVqF8/users/lb0NvUXIVguzjQ3dBOXAyd1c61fWKB5dKJDQ6YvB7a0
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*|Group ID.|string|--|
|**Path**|**uid**  <br>*required*|User ID.|string|--|
|**Body**|**privileges**  <br>*optional*|The list of privileges for the|[GroupPrivileges](../definitions/GroupPrivileges.md#groupprivileges)|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**201**|URI of the added user in form https://onezone.domain/api/onezone/v3/groups/{id}/users/{uid} is returned in the response `Location` header.  <br>**Headers** :   <br>`Location` (string) : URI of the added user.|No Content|
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
"/groups/string/users/string"
```


###### Request body
```
json :
{
  "privileges" : [ "group_create_space", "group_delete", "group_invite_group", "group_invite_user", "group_join_group", "group_join_space", "group_leave_space", "group_remove_group", "group_remove_user", "group_set_privileges", "group_update", "group_view" ]
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



