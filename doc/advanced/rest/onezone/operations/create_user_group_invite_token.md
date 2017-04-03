
<a name="create_user_group_invite_token"></a>
#### Create user invite token for group
```
POST /groups/{id}/users/token
```


##### Description
Creates a token allowing new user to join the group.

This operation requires `group_invite_user` privilege.

***Example cURL requests***

**Generate user group invite token**
```bash
curl -u username:password -X POST \
https://$HOST:8443/api/v3/onezone/groups/HwUpk8jrwxKOe45uzLFX2GVC8lKEasj4q253sptVqF8/users/token

{
  "token": "MDAxNmxvY2F00aW9uIHJlZlFTUbnZpdGVthHo8xmai4RqqBO2MZM00mrYGgo"
}
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*|Group ID.|string|--|
|**Body**|**data**  <br>*optional*|Group invite token attributes.|[GroupInviteTokenRequest](../definitions/GroupInviteTokenRequest.md#groupinvitetokenrequest)|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The token for joining a specific group.|[GroupInviteToken](../definitions/GroupInviteToken.md#groupinvitetoken)|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**401**|Authentication error.|[Error](../definitions/Error.md#error)|
|**403**|Authorization error.|[Error](../definitions/Error.md#error)|
|**404**|Resource not found.|[Error](../definitions/Error.md#error)|
|**500**|Internal server Error.|[Error](../definitions/Error.md#error)|


##### Consumes

* `application/json`


##### Produces

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/groups/string/users/token"
```


###### Request body
```
json :
{ }
```


##### Example HTTP response

###### Response 200
```
json :
{
  "token" : "JKAxNWxvY2F0aW9uIG9uZXpvbmUKMDAzYmlkZW50aWZpZXIgOEhmSEFSSGdrbHFCa1pWSTRsNk1CVHZTU3Z0OThwcHA2OTQ4czhRN1NPawowMDFhY2lkIHRpbWUgPCAxNDk2MTQwMTQ0CjAwMmZzaWduYXR1cmUg88OIBmav38YI0Z2-dw-fvrZ3XP-J0HjCN0taT3_WungK"
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



