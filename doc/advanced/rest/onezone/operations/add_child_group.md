
<a name="add_child_group"></a>
#### Add child group
```
PUT /groups/{id}/children/{cid}
```


##### Description
Adds group {cid} as child group of {id}.

For administrator who does not belong to this group
'oz_groups_add_members' privilege is required.

***Example cURL requests***

**Add child group**
```bash
curl -u username:password -X PUT \
https://$HOST/api/v3/onezone/groups/HwUpk8jrwxKOe45uzLFX2GVC8lKEasj4q253sptVqF8/children/T5x_HhFYOnILOCUf9OqgExw00RwaU2MXT5122oWk_sM
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**cid**  <br>*required*|Child group ID.|string|--|
|**Path**|**id**  <br>*required*|Group ID.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**201**|URI of the added group in form https://onezone.domain/api/onezone/v3/groups/{id}/children/{cid} is returned in the response `Location` header.  <br>**Headers** :   <br>`Location` (string) : URI of the created group.|No Content|
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
"/groups/string/children/string"
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



