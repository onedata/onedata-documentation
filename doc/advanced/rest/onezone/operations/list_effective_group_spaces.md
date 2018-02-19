
<a name="list_effective_group_spaces"></a>
#### List effective group's spaces
```
GET /groups/{id}/effective_spaces
```


##### Description
Returns the effective list of spaces to which the group has access.

This operation requires `group_view` privilege.

***Example cURL requests***

**Get group effective spaces**
```bash
curl -u username:password -X GET \
https://$HOST/api/v3/onezone/groups/HwUpk8jrwxKOe45uzLFX2GVC8lKEasj4q253sptVqF8/effective_spaces

{
  "spaces": [
    "GVC8lKEasj4q253sptVqF8HwUpk8jrwxKOe45uzLFX2"
  ]
}
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*|Group ID.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The effective list of space ID's for which the group has access.|[Spaces](../definitions/Spaces.md#spaces)|
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
"/groups/string/effective_spaces"
```


##### Example HTTP response

###### Response 200
```
json :
{
  "spaces" : [ "Bmav38YI0Z2-dw-fvrZ3XP-J0HjCN0taT3_WungK", "ASmlkZW50aWZpZXIgOEhmSEFSSGdrbHFCa1pWSTR" ]
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



