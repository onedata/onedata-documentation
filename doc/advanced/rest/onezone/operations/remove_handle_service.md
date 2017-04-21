
<a name="remove_handle_service"></a>
#### Unregister handle service
```
DELETE /handle_services/{id}
```


##### Description
Allows to unregister a registeed handle service.

This operation requires `delete_handle_service` privilege.

***Example cURL requests***

**Unregister handle service**
```bash
curl -u username:password -X DELETE \
https://$HOST:8443/api/v3/handle_services/LKHASDkkjhASDLHU70ASDn
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*||string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**202**|Handle service will be unregistered.|No Content|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**401**|Authentication error.|[Error](../definitions/Error.md#error)|
|**403**|Authorization error.|[Error](../definitions/Error.md#error)|
|**404**|Resource not found.|[Error](../definitions/Error.md#error)|
|**500**|Internal server Error.|[Error](../definitions/Error.md#error)|


##### Example HTTP request

###### Request path
```
json :
"/handle_services/string"
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



