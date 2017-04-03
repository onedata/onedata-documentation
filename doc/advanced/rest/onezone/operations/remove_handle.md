
<a name="remove_handle"></a>
#### Unregister handle
```
DELETE /handles/{hndl}
```


##### Description
Allows to unregister a registered handle.

This operation requires `delete_handle` privilege.

***Example cURL requests***

**Unregister handle**
```bash
curl -u username:password -X DELETE \
https://$HOST:8443/api/v3/handles/SDLLKHASDkSDLHU70ASDnHU70ASDnkjhA
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**hndl**  <br>*required*||string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**202**|Unregistration was successful.|No Content|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**401**|Authentication error.|[Error](../definitions/Error.md#error)|
|**403**|Authorization error.|[Error](../definitions/Error.md#error)|
|**404**|Resource not found.|[Error](../definitions/Error.md#error)|
|**500**|Internal server Error.|[Error](../definitions/Error.md#error)|


##### Example HTTP request

###### Request path
```
json :
"/handles/string"
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



