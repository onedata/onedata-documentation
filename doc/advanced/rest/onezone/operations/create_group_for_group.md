
<a name="create_group_for_group"></a>
#### Create new group for the current group
```
POST /groups/{id}/parents
```


##### Description
Creates a new group for the current group.
The group automatically becomes a member of this group.

***Example cURL requests***

**Create new group**
```bash
curl -u username:password  -H "Content-type: application/json" \
-X POST -d '{ "name" : "test_group" , "type" : "role" }' \
https://$HOST/api/v3/onezone/groups/HwUpk8jrwxKOe45uzLFX2GVC8lKEasj4q253sptVqF8/parents
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*|Group ID.|string|--|
|**Body**|**group**  <br>*required*|New group parameters.|[Group](../definitions/Group.md#group)|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**201**|URI of the created group in form https://onezone.domain/api/onezone/v3/groups/{gid}/parents/{pid} is returned in the response `Location` header.  <br>**Headers** :   <br>`Location` (string) : URI of the created group.|No Content|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**401**|Authentication error.|[Error](../definitions/Error.md#error)|
|**403**|Authorization error.|[Error](../definitions/Error.md#error)|
|**404**|Resource not found.|[Error](../definitions/Error.md#error)|
|**500**|Internal server Error.|[Error](../definitions/Error.md#error)|


##### Consumes

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/groups/string/parents"
```


###### Request body
```
json :
{
  "groupId" : "ALSKDHLASD8ASDNjasd99",
  "name" : "Test group",
  "type" : "role"
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



