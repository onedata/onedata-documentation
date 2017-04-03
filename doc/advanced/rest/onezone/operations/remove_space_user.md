
<a name="remove_space_user"></a>
#### Remove user from space
```
DELETE /spaces/{id}/users/{uid}
```


##### Description
Removes user from specific space.

This operation requires `space_remove_user` or
`remove_member_from_space` privilege.

***Example cURL requests***

**Get space user data**
```bash
curl  -u admin:password -X DELETE \
https://$HOST:8443/api/v3/onezone/spaces/p-mts_OBjwXss-E9kBxzp-ux12KNW2CBSaXlkDowDEk/users/ivMnRLb2WYNApEmP-j3SF0NsqBgdHG7iel89FHY802w
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*|Space ID.|string|--|
|**Path**|**uid**  <br>*required*|User ID.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|User has been removed from space successfully.|No Content|
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
"/spaces/string/users/string"
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



