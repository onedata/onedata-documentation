
<a name="get_group_space_alias"></a>
#### Get groups space alias
```
GET /groups/{id}/spaces/{sid}/alias
```


##### Description
Returns the alias of a specific space.

This operation can be invoked on behalf of current user only.

***Example cURL requests***

**Get space alias**
```bash
curl -u username:password -X GET \
https://$HOST:8443/api/v3/onezone/groups/KLJASDFJKHASDASER3ewdas/spaces/oOVF-KrO1P6rpA0LFgNVI8NxuhxyQMUnrYzjAnKiyAY/alias

{
  "alias": "Test space 2"
}
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*|Group ID.|string|--|
|**Path**|**sid**  <br>*required*|Space ID.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|Returns the alias of a specific space.|[SpaceAlias](../definitions/SpaceAlias.md#spacealias)|
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
"/groups/string/spaces/string/alias"
```


##### Example HTTP response

###### Response 200
```
json :
{
  "alias" : "Another name."
}
```


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


