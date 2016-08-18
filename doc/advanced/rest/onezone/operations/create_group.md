
<a name="create_group"></a>
#### Create new group
```
POST /groups
```


##### Description
Creates a new group.

This operation does require any specific privileges.

***Example cURL requests***

**Create new group of type `role`**
```bash
 curl -k -u username:password  -H "Content-type: application/json" \
 -X POST -d '{ "name":"new_group" , "type":"role" }' \
 https://$HOST:8443/api/v3/onezone/groups/
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Body**|**data**  <br>*required*|Group properties.|[Group](../definitions/Group.md#group)|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**201**|ID of the group created in the form /groups/{id} is  returned in the response `Location` header.  <br>**Headers** :   <br>`Location` (string) : ID of the created group.|No Content|
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
"/groups"
```


###### Request body
```
json :
{
  "name" : "Test group",
  "type" : "role"
}
```


##### Example HTTP response

###### Response 400
```
json :
{
  "error" : "invalid_token",
  "error_description" : "Provided token could not be validated."
}
```


###### Response 401
```
json :
{
  "error" : "invalid_token",
  "error_description" : "Provided token could not be validated."
}
```


###### Response 403
```
json :
{
  "error" : "invalid_token",
  "error_description" : "Provided token could not be validated."
}
```


###### Response 404
```
json :
{
  "error" : "invalid_token",
  "error_description" : "Provided token could not be validated."
}
```


###### Response 500
```
json :
{
  "error" : "invalid_token",
  "error_description" : "Provided token could not be validated."
}
```



