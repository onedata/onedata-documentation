
<a name="get_all_transfers"></a>
#### Get all transfers
```
GET /transfers
```


##### Description
Returns the list of all transfer IDs.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Query**|**limit**  <br>*optional*|Allows to limit the number of returned transfers only to the last N transfers.|integer|--|
|**Query**|**status**  <br>*optional*|Allows to limit the returned transfers only to transfers with specific status.|< enum (scheduled, active, completed, cancelled, failed) > array|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The list of transfer IDs.|< string > array|
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
"/transfers"
```


###### Request query
```
json :
{
  "limit" : 0,
  "status" : "string"
}
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



