
<a name="get_effective_child_group"></a>
#### Get effective child group details
```
GET /groups/{id}/effective_children/{cid}
```


##### Description
Returns information about a specific effective child group.

This operation requires `group_view_data` privilege.

***Example cURL requests***

**Get effective child details**
```bash
curl -u username:password -X GET \
https://$HOST:8443/api/v3/onezone/groups/HwUpk8jrwxKOe45uzLFX2GVC8lKEasj4q253sptVqF8/effective_children/T5x_HhFYOnILOCUf9OqgExw00RwaU2MXT5122oWk_sM

{
  "groupId": "T5x_HhFYOnILOCUf9OqgExw00RwaU2MXT5122oWk_sM",
  "name": "new_group1",
  "type": "role"
}
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**cid**  <br>*required*|Effective child group ID.|string|--|
|**Path**|**id**  <br>*required*|Group ID.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|Information about a specific effective child group.|[Group](../definitions/Group.md#group)|
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
"/groups/string/effective_children/string"
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



