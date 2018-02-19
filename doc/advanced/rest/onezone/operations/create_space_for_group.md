
<a name="create_space_for_group"></a>
#### Create new space for group
```
POST /groups/{id}/spaces
```


##### Description
Creates a new space for a specific group.

This operation requires `group_create_space` privilege.

***Example cURL requests***

**Create new space for group**
```bash
curl -u admin:password  -H "Content-type: application/json" \
-X POST -d '{"name": "new_space"}' \
https://$HOST/api/v3/onezone/groups/HwUpk8jrwxKOe45uzLFX2GVC8lKEasj4q253sptVqF8/spaces
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*|Group ID.|string|--|
|**Body**|**spaceName**  <br>*optional*||[spaceName](#create_space_for_group-spacename)|--|

<a name="create_space_for_group-spacename"></a>
**spaceName**

|Name|Description|Schema|
|---|---|---|
|**name**  <br>*required*|Name of the new space.|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|ID of the created space in the form /groups/{id}/spaces/{sid} is returned in the response `Location` header.  <br>**Headers** :   <br>`Location` (string) : ID of the created space.|No Content|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|[Error](../definitions/Error.md#error)|
|**404**|Resource not found..|[Error](../definitions/Error.md#error)|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


##### Produces

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/groups/string/spaces"
```


###### Request body
```
json :
{
  "name" : "string"
}
```


##### Example HTTP response

###### Response 400
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



