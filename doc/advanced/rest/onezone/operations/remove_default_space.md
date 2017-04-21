
<a name="remove_default_space"></a>
#### Unset default space
```
DELETE /user/default_space
```


##### Description
Removes default space setting for current user.

This operation can be invoked on behalf of current user only.

***Example cURL requests***

**Set user default space**
```bash
curl -u username:password  -X DELETE \
https://$HOST:8443/api/v3/onezone/user/default_space
```


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**202**|Default space will be removed.|No Content|
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
"/user/default_space"
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



