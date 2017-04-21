
<a name="list_child_groups"></a>
#### Get subgroups
```
GET /groups/{id}/children
```


##### Description
Returns the list of subgroups of a specific group.

This operation requires `group_view_data` privilege.
For administrator who do not need to be members of this group
`oz_groups_list_groups` privilege is required.

***Example cURL requests***

**Get subgroups**
```bash
curl -u admin:password -X GET \
https://$HOST:8443/api/v3/onezone/groups/HwUpk8jrwxKOe45uzLFX2GVC8lKEasj4q253sptVqF8/children

{
  "nested_groups": []
}
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*|Group ID.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The list of subgroup ID's.|[ChildGroups](../definitions/ChildGroups.md#childgroups)|
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
"/groups/string/children"
```


##### Example HTTP response

###### Response 200
```
json :
{
  "groups" : [ "JKLHASGDFJLHGASDHJGLAHJSD", "ASDkjasdaksdKASDkajsdKAJS" ]
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



