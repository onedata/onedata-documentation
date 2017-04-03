
<a name="get_default_provider"></a>
#### Get default provider
```
GET /user/default_provider
```


##### Description
Returns the ID of the default provider.

This operation can be invoked on behalf of current user only.

***Example cURL requests***

**Get user default provider**
```bash
curl -u username:password -X GET \
https://$HOST:8443/api/v3/onezone/user/default_provider

{
  "providerId": "oOVF-KrO1P6rpA0LFgNVI8NxuhxyQMUnrYzjAnKiyAY"
}
```


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|Returns the Id of the default user provider or '404'.|[DefaultProvider](../definitions/DefaultProvider.md#defaultprovider)|
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
"/user/default_provider"
```


##### Example HTTP response

###### Response 200
```
json :
{
  "providerId" : "oOVF-KrO1P6rpA0LFgNVI8NxuhxyQMUnrYzjAnKiyAY"
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



