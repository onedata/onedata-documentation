
<a name="set_default_space"></a>
#### Set default space
```
PUT /user/default_space
```


##### Description
Sets default space for current user.

This operation can be invoked on behalf of current user only.

***Example cURL requests***

**Set user default space**
```bash
curl -u username:password  -H "Content-type: application/json" -X PUT \
-d '{ "spaceId" : "S0Y9FSeSrVTXCTmCpgqfH4-_Dw3Uc9TFJFFzzLtBEs8" }' \
https://$HOST:8443/api/v3/onezone/user/default_space
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Body**|**defaultspace**  <br>*required*|Default Space ID.|[DefaultSpace](../definitions/DefaultSpace.md#defaultspace)|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|Default space set successfully.|No Content|
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


###### Request body
```
json :
{
  "spaceId" : "7YASBFLJ-123ASD870-ASDASD"
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



