
<a name="list_user_handle_services"></a>
#### List user handle services
```
GET /user/handle_services
```


##### Description
Returns the list of registered user handle services.

***Example cURL requests***

**Get user handle services**
```bash
curl -u username:password -X GET https://$HOST:8443/api/v3/user/handle_services

{
  "handle_services": [
    "SADHLKJhlkASHDLAKSHDLKJHJjLH",
    "LAKSHDLKJHJjLHSADHLKJhlkASHD"
  ]
}
```


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The list of identifiers of registered handle services.|[HandleServices](../definitions/HandleServices.md#handleservices)|
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
"/user/handle_services"
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



