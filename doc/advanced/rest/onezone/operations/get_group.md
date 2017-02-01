
<a name="get_group"></a>
#### Get group details
```
GET /groups/{id}
```


##### Description
Returns the information about a specific group.

This operation requires `group_view_data` privilege.

***Example cURL requests***

**Get group details**
```bash
curl -k -u username:password -X GET \
https://$HOST:8443/api/v3/onezone/user/groups/HwUpk8jrwxKOe45uzLFX2GVa8lKEasj4q253sptVqF8

{
  "groupId":"HwUpk8jrwxKOe45uzLFX2GVa8lKEasj4q253sptVqF8",
  "name":"new_group",
  "type":"role"
}
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*|Group ID.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|Information about a group.|[Group](../definitions/Group.md#group)|
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
"/groups/string"
```


##### Example HTTP response

###### Response 200
```
json :
{
  "name" : "Test group",
  "type" : "role"
}
```


###### Response 400
```
json :
{
  "error" : "invalid_token",
  "error_description" : "Provided token could not be validated."
}
```


###### Response 401
```
json :
{
  "error" : "invalid_token",
  "error_description" : "Provided token could not be validated."
}
```


###### Response 403
```
json :
{
  "error" : "invalid_token",
  "error_description" : "Provided token could not be validated."
}
```


###### Response 404
```
json :
{
  "error" : "invalid_token",
  "error_description" : "Provided token could not be validated."
}
```


###### Response 500
```
json :
{
  "error" : "invalid_token",
  "error_description" : "Provided token could not be validated."
}
```



