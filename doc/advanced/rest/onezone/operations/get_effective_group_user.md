
<a name="get_effective_group_user"></a>
#### Get effective group user details
```
GET /groups/{id}/effective_users/{uid}
```


##### Description
Returns information about a specific effective group user.

This operation requires `group_view` privilege.
For administrator who does not belong to this group
'oz_groups_list_users' privilege is required.

***Example cURL requests***

**Get group user details**
```bash
curl -u username:password -X GET \
https://$HOST/api/v3/onezone/groups/HwUpk8jrwxKOe45uzLFX2GVC1lKEasj4q253sptVqF8/effective_users/lb0NvUXIVguzjQ3dBOXAyd1c61fWKB5dKJDQ6YvB7a0

{
  "userId": "lb0NvUXIVguzjQ3dBOXAyd1c61fWKB5dKJDQ6YvB7a0",
  "login": "admin",
  "name": "admin"
}
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*|Group ID.|string|--|
|**Path**|**uid**  <br>*required*|User ID.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|Returns the information about a group user.|[User](../definitions/User.md#user)|
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
"/groups/string/effective_users/string"
```


##### Example HTTP response

###### Response 200
```
json :
{
  "userId" : "ALKJSDH77i79ASDKJA-ASDBAS9-87",
  "name" : "Rudolf Lingens",
  "login" : "Rudolf Lingens"
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



