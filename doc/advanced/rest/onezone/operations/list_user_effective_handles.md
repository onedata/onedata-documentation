
<a name="list_user_effective_handles"></a>
#### Get user effective handles
```
GET /user/effective_handles
```


##### Description
Returns the list of user's effective handles.

This operation can be invoked on behalf of current user only.

***Example cURL requests***

**Get user effective handles**
```bash
curl -u admin:password -X GET \
https://$HOST:8443/api/v3/onezone/user/effective_handles

{
  "handles": [
    "ASKJDKLJASBDJHGA75ASDK"
  ]
}
```


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The list of handles.|[Handles](../definitions/Handles.md#handles)|
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
"/user/effective_handles"
```


##### Example HTTP response

###### Response 200
```
json :
{
  "handles" : [ "Bmav38YI0Z2-dw-fvrZ3XP-J0HjCN0taT3_WungK", "ASmlkZW50aWZpZXIgOEhmSEFSSGdrbHFCa1pWSTR" ]
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



