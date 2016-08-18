
<a name="set_user_default_space"></a>
#### Set default space
```
PUT /user/spaces/default
```


##### Description
Sets default space for current user.

This operation can be invoked on behalf of current user only.

***Example cURL requests***

**Set user default space**
```bash
curl -k -u username:password  -H "Content-type: application/json" -X PUT \
-d '{ "spaceId" : "S0Y9FSeSrVTXCTmCpgqfH4-_Dw3Uc9TFJFFzzLtBEs8" }' \
https://$HOST:8443/api/v3/onezone/user/spaces/default
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Body**|**defaultspace**  <br>*required*|Default Space ID.|[DefaultSpace](../definitions/DefaultSpace.md#defaultspace)|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|Space created successfully.|string|
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
"/user/spaces/default"
```


###### Request body
```
json :
{
  "spaceId" : "7YASBFLJ-123ASD870-ASDASD"
}
```


##### Example HTTP response

###### Response 200
```
json :
"string"
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



