
<a name="get_space_provider"></a>
#### Get space provider details
```
GET /spaces/{id}/providers/{pid}
```


##### Description
Returns details about a specific provider supporting the space.

This operation requires `list_providers_of_space` privilege.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*|Space ID.|string|--|
|**Path**|**pid**  <br>*required*|Provider ID.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|Details about a specific provider supporting a space.|[ProviderDetails](../definitions/ProviderDetails.md#providerdetails)|
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
"/spaces/string/providers/string"
```


##### Example HTTP response

###### Response 200
```
json :
{
  "providerId" : "LASDASJDBH89869ASD79869asd",
  "urls" : [ "http://beta.onedata.org/provider1", "http://beta.onedata.org/provider2" ],
  "redirectionPoint" : "http://beta.onedata.org/provider2",
  "latitude" : 50.0647,
  "longitude" : 19.945
}
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



