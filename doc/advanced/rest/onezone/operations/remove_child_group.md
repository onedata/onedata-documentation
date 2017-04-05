
<a name="remove_child_group"></a>
#### Remove subgroup
```
DELETE /groups/{id}/children/{cid}
```


##### Description
Removes a specific child with {cid} from parent group with {id}.

This operation requires `group_remove_group` privilege.

***Example cURL requests***

**Remove child group**
```bash
curl -u username:password -X DELETE \
https://$HOST:8443/api/v3/onezone/groups/KoiO-QKqmYZRjPVdtR30FrdIEA1JF9f3TznAr9BDjA4/children/Qi4QT2oalnfQu0SzTK1HgXxKuUrlRppb68rr_UhwC50
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**cid**  <br>*required*|Child group ID.|string|--|
|**Path**|**id**  <br>*required*|Group ID.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**202**|A subgroup will be removed.|No Content|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**401**|Authentication error.|[Error](../definitions/Error.md#error)|
|**403**|Authorization error.|[Error](../definitions/Error.md#error)|
|**404**|Resource not found.|[Error](../definitions/Error.md#error)|
|**500**|Internal server Error.|[Error](../definitions/Error.md#error)|


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



