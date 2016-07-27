
<a name="get_user_default_space"></a>
#### Get default space
```
GET /user/spaces/default
```


##### Description
Returns the ID of the default users space.

This operation can be invoked on behalf of current user only.


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
"/user/spaces/default"
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



