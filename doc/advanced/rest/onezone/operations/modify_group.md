
<a name="modify_group"></a>
#### Modify group details
```
PATCH /groups/{id}
```


##### Description
Updates the details about a group.

This operation requires `group_change_data` privilege.

***Example cURL requests***

**Modify group name**
```bash
curl -i -k -u admin:password  -H "Content-type: application/json" \
-X PATCH -d '{"name": "new_group_name"}' \
https://$HOST:8443/api/v3/onezone/groups/HwUpk8jrwxKOe45uzLFX2GVC8lKEqsj4q253sptVqF8   
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*|Group ID.|string|--|
|**Body**|**data**  <br>*required*|Group parameters|[Group](../definitions/Group.md#group)|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|Group details modified.|No Content|
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
"/groups/string"
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



