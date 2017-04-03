
<a name="get_user_effective_group"></a>
#### Get effective group details
```
GET /user/effective_groups/{gid}
```


##### Description
Returns information about a specific effective group to which the user belongs.

This operation can be invoked on behalf of current user only.

***Example cURL requests***

**Get user effective group**
```bash
curl -u username:password -X GET \
https://$HOST:8443/api/v3/onezone/user/effective_groups/LKJGHASDJHAJKLSHDLJKASD

{
  "groupId": "LKJGHASDJHAJKLSHDLJKASD",
  "name": "admins",
  "type": "role"
}
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**gid**  <br>*required*|Group ID.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|Returns the information about a specific effective group.|[Group](../definitions/Group.md#group)|
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
"/user/effective_groups/string"
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



