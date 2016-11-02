
<a name="get_provider_spaces"></a>
#### Get provider spaces
```
GET /provider/spaces
```


##### Description
Returns the list of spaces supported by the provider.


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The provider spaces details.|[ProviderSpaces](../definitions/ProviderSpaces.md#providerspaces)|
|**401**|Unauthorized request.|No Content|
|**403**|Forbidden request.|No Content|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


##### Produces

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/provider/spaces"
```


##### Example HTTP response

###### Response 200
```
json :
{
  "ids" : [ "x7It3cpgNgLZ8RwOrOoW", "Q1boCClpCS5mUNhM7YCy" ]
}
```


###### Response 500
```
json :
{
  "error" : "Invalid Request",
  "description" : "User role must be one of 'admin' or 'regular'."
}
```



