
<a name="delete_provider"></a>
#### Unregisters provider
```
DELETE /provider
```


##### Description
Unregisters a Oneprovider from the nezone service.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Body**|**data**  <br>*required*|Provider ID.|[data](#delete_provider-data)|--|

<a name="delete_provider-data"></a>
**data**

|Name|Description|Schema|
|---|---|---|
|**providerId**  <br>*optional*|The ID of the provider to unregister.|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**202**|Provider will be unregistered.|No Content|
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
"/provider"
```


###### Request body
```
json :
{
  "providerId" : "string"
}
```


##### Example HTTP response

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



