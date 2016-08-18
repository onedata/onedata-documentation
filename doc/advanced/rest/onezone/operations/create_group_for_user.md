
<a name="create_group_for_user"></a>
#### Create new group
```
POST /user/groups
```


##### Description
Creates a new group for the current user. 
The user automatically becomes a member of this group.

This operation can be invoked on behalf of current user only.

***Example cURL requests***

**Create new group**
```bash
curl -k -u username:password  -H "Content-type: application/json" \
-X POST -d '{ "name" : "test_group" , "type" : "admin" }' \
https://$HOST:8443/api/v3/onezone/user/groups
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Body**|**group**  <br>*required*|New group parameters.|[Group](../definitions/Group.md#group)|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**201**|ID of the created group in the form /user/groups/{gid} is  returned in the response `Location` header.  <br>**Headers** :   <br>`Location` (string) : ID of the created group.|No Content|
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
"/user/groups"
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



