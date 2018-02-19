
<a name="get_group_space"></a>
#### Get group's space details
```
GET /groups/{id}/spaces/{sid}
```


##### Description
Returns information about a specific space to which the group belongs.

This operation requires `group_view` privilege.

***Example cURL requests***

**Get group's space details**
```bash
curl -u username:password -X GET \
https://$HOST/api/v3/onezone/groups/HwUpk8jrwxKOe45uzLFX2GVC8lKEasj4q253sptVqF8/spaces/HUUPOMNGzikwiLXHaFYcE8-qxDtKmt1Gb3v5OnF9UNE

{
  "spaceId": "HUUPOMNGzikwiLXHaFYcE8-qxDtKmt1Gb3v5OnF9UNE",
  "name": "a",
  "providers": {
    "hxfMCWmquqAIjG1GeG2eZY8qvs8iRIn09HzjCJilnSE" : 5368709120
  }
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
|**200**|Information about a specific space in a group.|[Space](../definitions/Space.md#space)|
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
"/groups/string/spaces/string"
```


##### Example HTTP response

###### Response 200
```
json :
{
  "spaceId" : "Xnp1JVpWfL8_stHJgct76AFALjRsI0W3rNs1nfMwqnY",
  "name" : "My Private space",
  "providers" : {
    "hxfMCWmquqAIjG1GeG2eZY8qvs8iRIn09HzjCJilnSE" : 5368709120
  }
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



