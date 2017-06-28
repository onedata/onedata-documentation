
<a name="set_effective_child_group_privileges"></a>
#### Set effective child group privileges
```
PATCH /groups/{id}/effective_children/{cid}/privileges
```


##### Description
Sets new child group privileges within a group.

This operation requires `group_set_privileges` privilege.

***Example cURL requests***

**Set child group privileges in a group**
```bash
curl -u username:password -X PATCH -H 'Content-type: application/json' \
-d '{"privileges": "group_view"}'
https://$HOST:8443/api/v3/onezone/groups/HwUpk8jrwxKOe45uzLFX2GVC8lKEasj4q253sptVqF8/effective_children/T5x_HhFYOnILOCUf9OqgExw00RwaU2MXT5122oWk_sM/privileges
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**cid**  <br>*required*|Effective child group ID.|string|--|
|**Path**|**id**  <br>*required*|Group ID.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|The child group privileges have been updated successfully.|No Content|
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
"/groups/string/effective_children/string/privileges"
```


##### Example HTTP response

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



