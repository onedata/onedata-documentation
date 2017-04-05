
<a name="add_group_user"></a>
#### Get group user details
```
PUT /groups/{id}/users/{uid}
```


##### Description
Returns the public information about a user {uid} in group {id}.

This operation requires `oz_groups_add_members` privilege.

***Example cURL requests***

**Generate user group invite token**
```bash
curl -u admin:password -X GET \
https://$HOST:8443/api/v3/onezone/groups/HwUpk8jrwxKOe45uzLFX2GVC8lKEasj4q253sptVqF8/users/lb0NvUXIVguzjQ3dBOXAyd1c61fWKB5dKJDQ6YvB7a0
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
|**200**|Information about a group user.|[User](../definitions/User.md#user)|
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
  "privileges" : [ "group_change_data", "group_create_space", "group_invite_group", "group_invite_user", "group_join_group", "group_join_space", "group_leave_space", "group_remove", "group_remove_group", "group_remove_user", "group_set_privileges", "group_view_data" ]
}
```


##### Example HTTP response

###### Response 200
```
json :
{
  "userId" : "ALKJSDH77i79ASDKJA-ASDBAS9-87",
  "name" : "Rudolf Lingens",
  "connectedAccounts" : [ {
    "accountId" : "ASD879ASD-7SADASFSsa0831",
    "providerId" : "7YASBFLJ-123ASD870-ASDASD"
  }, {
    "accountId" : "QWESsD-7SADASFSsa0831",
    "providerId" : "7QWEJ-123ASD870-ASDASD"
  } ],
  "alias" : "John Doe",
  "emailList" : [ "rudolf.linges@example.com", "john.doe@example.com" ]
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



