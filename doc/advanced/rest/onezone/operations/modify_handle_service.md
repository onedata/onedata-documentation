
<a name="modify_handle_service"></a>
#### Modify handle service
```
PATCH /handle_services/{id}
```


##### Description
Allows to update a registered handle service.

This operation requires `modify_handle_service` privilege.

***Example cURL requests***

**Modify handle service password**
```bash
curl -u username:password -X PATCH  -H "Content-type: application/json" \
-d '{"name": "New handle service name"}' \
https://$HOST:8443/api/v3/handle_services/LKHASDkkjhASDLHU70ASDn
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*||string|--|
|**Body**|**handleService**  <br>*required*||[HandleServiceUpdate](../definitions/HandleServiceUpdate.md#handleserviceupdate)|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|Update was successful.|No Content|
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
"/handle_services/string"
```


###### Request body
```
json :
{
  "proxyEndpoint" : "https://newendpointdomain.com:17000/handle_proxy"
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



