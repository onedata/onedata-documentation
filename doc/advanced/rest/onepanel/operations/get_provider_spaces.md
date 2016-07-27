
<a name="get_provider_spaces"></a>
#### Get provider spaces
```
GET /provider/spaces
```


##### Description
Returns the list of spaces supported by a provider.


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The list of IDs of spaces supported by a provider.|< string > array|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|[Error](../definitions/Error.md#error)|
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
"array"
```


###### Response 400
```
json :
{
  "error" : "Authentication Error",
  "description" : "Invalid username or password."
}
```


###### Response 403
```
json :
{
  "error" : "Authentication Error",
  "description" : "Invalid username or password."
}
```


###### Response 500
```
json :
{
  "error" : "Authentication Error",
  "description" : "Invalid username or password."
}
```



