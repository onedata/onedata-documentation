
<a name="get_handle_services"></a>
#### Get handle services
```
GET /handle_services
```


##### Description
Returns the list of registered handle services.

***Example cURL requests***

**Get handle services**
```bash
curl -k -u username:password -X GET https://$HOST:8443/api/v3/handle_services

[
  "SADHLKJhlkASHDLAKSHDLKJHJjLH", 
  "LAKSHDLKJHJjLHSADHLKJhlkASHD"
]
```


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The list of identifiers of registered handle services.|< string > array|
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
"/handle_services"
```


##### Example HTTP response

###### Response 200
```
json :
"array"
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



