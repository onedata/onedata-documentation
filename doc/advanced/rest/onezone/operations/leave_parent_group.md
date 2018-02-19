
<a name="leave_parent_group"></a>
#### Leave parent group
```
DELETE /groups/{id}/parents/{pid}
```


##### Description
Removes the group membership in a specific parent group.

This operation requires `group_update` privilege.

***Example cURL requests***

**Delete user handle service**
```bash
curl -u username:password -X DELETE \
https://$HOST/api/v3/onezone/groups/AJKLASHJKDHKAJSHD/parents/oOVF-KrO1P6rpA0LFgNVI8NxuhxyQMUnrYzjAnKiyAY
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*|Group ID.|string|--|
|**Path**|**pid**  <br>*required*|Parent group ID.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|The group membership will be revoked.|No Content|
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
"/groups/string/parents/string"
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



