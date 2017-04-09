
<a name="remove_user_space_alias"></a>
#### Remove space alias
```
DELETE /user/spaces/{sid}/alias
```


##### Description
Removes the space alias.

This operation can be invoked on behalf of current user only.

***Example cURL requests***

**Remove user space alias**
```bash
curl -u username:password -X DELETE \
https://$HOST:8443/api/v3/onezone/user/spaces/oOVF-KrO1P6rpA0LFgNVI8NxuhxyQMUnrYzjAnKiyAY/alias
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**sid**  <br>*required*|Space Id.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The space was deleted successfuly.|No Content|
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
"/user/spaces/string/alias"
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



