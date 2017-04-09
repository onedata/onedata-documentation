
<a name="get_default_space"></a>
#### Get default space
```
GET /user/default_space
```


##### Description
Returns the ID of the default users space.

This operation can be invoked on behalf of current user only.

***Example cURL requests***

**Get user default space**
```bash
curl -u username:password -X GET \
https://$HOST:8443/api/v3/onezone/user/default_space

{
  "spaceId": "undefined"
}
```


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|Returns the Id of the default user space or 'undefined' in case no space is selected as default.|[DefaultSpace](../definitions/DefaultSpace.md#defaultspace)|
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
"/user/default_space"
```


##### Example HTTP response

###### Response 200
```
json :
{
  "spaceId" : "7YASBFLJ-123ASD870-ASDASD"
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



