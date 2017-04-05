
<a name="list_providers"></a>
#### List providers
```
GET /providers
```


##### Description
Returns the list of providers registered in the Onezone service.

This operation requires `list_providers` privilege.

***Example cURL requests***

**Get list of providers**
```bash
curl -Ssk -u username:password -X GET  \
https://$HOST:8443/api/v3/onezone/providers

{
  "providers": [
    "WEavnRE7c49EU2sjF0Rz7l_kpiA1IBrwbDxNfH87Plc"
  ]
}
```


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|List of providers Id's.|[Providers](../definitions/Providers.md#providers)|
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
"/providers"
```


##### Example HTTP response

###### Response 200
```
json :
{
  "providers" : [ "Bmav38YI0Z2-dw-fvrZ3XP-J0HjCN0taT3_WungK", "ASmlkZW50aWZpZXIgOEhmSEFSSGdrbHFCa1pWSTR" ]
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



