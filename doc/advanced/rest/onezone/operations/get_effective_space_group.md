
<a name="get_effective_space_group"></a>
#### Get effective space group details
```
GET /spaces/{id}/effective_groups/{gid}
```


##### Description
Returns details about a specific effective group in a space.

This operation requires `space_view` privilege.

***Example cURL requests***

**Get effective space group details**
```bash
curl -u username:password -X GET \
https://$HOST:8443/api/v3/onezone/spaces/9ueUeoZA6KXxNgzlvqmmrbzqE_BQiaHEEDC21sY1Kuc/effective_groups/T5x_HhFYOnILOCUf9OqgExw00RwaU2MXT5122oWk_sM

{
  "groupId": "T5x_HhFYOnILOCUf9OqgExw00RwaU2MXT5122oWk_sM",
  "name": "new_groupX",
  "type": "role"
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
|**200**|Details of a specific group in a space.|[Group](../definitions/Group.md#group)|
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
"/spaces/string/effective_groups/string"
```


##### Example HTTP response

###### Response 200
```
json :
{
  "groupId" : "ALSKDHLASD8ASDNjasd99",
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



