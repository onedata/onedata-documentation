
<a name="set_user_space_alias"></a>
#### Get space alias
```
PUT /user/spaces/{sid}/alias
```


##### Description
Sets the alias of a specific space.

This operation can be invoked on behalf of current user only.

***Example cURL requests***

**Set space alias**
```bash
curl -u username:password -X POST -d '{"alias": "Space alias"}' \
-H 'Content-type: application/json' \
https://$HOST:8443/api/v3/onezone/user/spaces/oOVF-KrO1P6rpA0LFgNVI8NxuhxyQMUnrYzjAnKiyAY/alias
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**sid**  <br>*required*|Space ID.|string|--|
|**Body**|**data**  <br>*required*|New space alias.|[SpaceAlias](../definitions/SpaceAlias.md#spacealias)|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|Space alias has been successfully set.|[SpaceAlias](../definitions/SpaceAlias.md#spacealias)|
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
"/user/spaces/string/alias"
```


###### Request body
```
json :
{
  "alias" : "Another name."
}
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



