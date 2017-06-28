
<a name="get_effective_parent_group"></a>
#### Get effective parent group details
```
GET /groups/{id}/effective_parents/{pid}
```


##### Description
Returns details about a specific effective parent group.

This operation requires `group_view` privilege.

***Example cURL requests***

**Get effective parent group details**
```bash
curl -u admin:password -X GET \
https://$HOST:8443/api/v3/onezone/groups/T5x_HhFYOnILOCUf9OqgExw00RwaU2MXT5122oWk_sM/effective_parents/9OqgExw00RwaU2MXT51

{
  "name": "Group1",
  "type": "organization"
}
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*|Group ID.|string|--|
|**Path**|**pid**  <br>*required*|Effective parent group ID.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|Information about a specific effective parent group.|[Group](../definitions/Group.md#group)|
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
"/groups/string/effective_parents/string"
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



