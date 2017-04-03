
<a name="set_group_space_alias"></a>
#### Get space alias
```
PUT /groups/{id}/spaces/{sid}/alias
```


##### Description
Sets the alias of a specific space.

This operation can be invoked on behalf of current user only.

***Example cURL requests***

**Set space alias**
```bash
curl -u username:password -X POST -d '{"alias": "Space alias"}' \
-H 'Content-type: application/json' \
https://$HOST:8443/api/v3/onezone/groups/ASDLJASDOASDBAMNSBVD89as/spaces/oOVF-KrO1P6rpA0LFgNVI8NxuhxyQMUnrYzjAnKiyAY/alias
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*|Group ID.|string|--|
|**Path**|**sid**  <br>*required*|Space ID.|string|--|
|**Body**|**data**  <br>*required*|New space alias.|[SpaceAlias](../definitions/SpaceAlias.md#spacealias)|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|Space alias has been successfully set.|No Content|
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
"/groups/string/spaces/string/alias"
```


###### Request body
```
json :
{
  "alias" : "Another name."
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



