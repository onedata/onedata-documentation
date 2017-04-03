
<a name="remove_user_handle_service"></a>
#### Remove user handle service
```
DELETE /user/handle_services/{hsid}
```


##### Description
Removes the users ownership or membership in a specific handle service.

This operation can be invoked on behalf of current user only.

***Example cURL requests***

**Delete user handle service**
```bash
curl -u username:password -X DELETE \
https://$HOST:8443/api/v3/onezone/user/handle_services/oOVF-KrO1P6rpA0LFgNVI8NxuhxyQMUnrYzjAnKiyAY
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**hsid**  <br>*required*|Handle service Id.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The handle service was deleted successfuly.|No Content|
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
"/user/handle_services/string"
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



