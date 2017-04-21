
<a name="list_user_effective_handle_services"></a>
#### List user effective handle services
```
GET /user/effective_handle_services
```


##### Description
Returns the list of user's effective handle services.

This operation can be invoked on behalf of current user only.

***Example cURL requests***

**Get user effective handle services**
```bash
curl -u admin:password -X GET \
https://$HOST:8443/api/v3/onezone/user/effective_handle_services

{
  "handle_services": [
    "LKJASHGDFKLJHASKLJDH"
  ]
}
```


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The list of handle services.|[HandleServices](../definitions/HandleServices.md#handleservices)|
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
"/user/effective_handle_services"
```


##### Example HTTP response

###### Response 200
```
json :
{
  "tokens" : [ "Bmav38YI0Z2-dw-fvrZ3XP-J0HjCN0taT3_WungK", "ASmlkZW50aWZpZXIgOEhmSEFSSGdrbHFCa1pWSTR" ]
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



