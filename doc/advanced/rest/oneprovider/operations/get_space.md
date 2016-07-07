
<a name="get_space"></a>
#### Get basic space information
```
GET /spaces/{sid}
```


##### Description
Returns the basic information about space with given ID.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**sid**  <br>*required*|Space ID.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The space information.|[Space](../definitions/Space.md#space)|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|[Error](../definitions/Error.md#error)|
|**404**|Oneprovider REST API not available.|[Error](../definitions/Error.md#error)|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


##### Produces

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/spaces/string"
```


##### Example HTTP response

###### Response 200
```
json :
{
  "spaceId" : "KJHJASD-798756876-ASDBKASD-6876",
  "name" : "My Space 1",
  "providers" : [ {
    "providerId" : "OIUOASD-798756876-ASDBKASD-6876",
    "providerName" : "MyPrivateCloud"
  }, {
    "providerId" : "LJKHSDA-798756876-ASDBKASD-6876",
    "providerName" : "PublicCloud1"
  } ]
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



