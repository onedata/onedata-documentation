
<a name="authenticate_user"></a>
#### Authenticate user
```
POST /user/authorize
```


##### Description
Authorizes user with authentication token through Onezone web interface. This interface is called only by providers.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Body**|**data**  <br>*required*|User authentication token.|[AuthenticationToken](../definitions/AuthenticationToken.md#authenticationtoken)|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|User authorized successfully - the body contains a discharge macaroon.|string|
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
"/user/authorize"
```


###### Request body
```
json :
{
  "identifier" : "JKAxNWxvY2F0aW9uIG9uZXpvbmUKMDAzYmlkZW50aWZpZXIgOEhmSEFSSGdrbHFCa1pWSTRsNk1CVHZTU3Z0OThwcHA2OTQ4czhRN1NPawowMDFhY2lkIHRpbWUgPCAxNDk2MTQwMTQ0CjAwMmZzaWduYXR1cmUg88OIBmav38YI0Z2-dw-fvrZ3XP-J0HjCN0taT3_WungK"
}
```


##### Example HTTP response

###### Response 200
```
json :
"string"
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



