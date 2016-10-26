
<a name="get_storages"></a>
#### Get storages
```
GET /provider/storages
```


##### Description
Returns the list of provider storage resources and their details.


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The list of provider storage and their details.|< [ClusterStorages](../definitions/ClusterStorages.md#clusterstorages) > array|
|**401**|Unauthorized request.|No Content|
|**403**|Forbidden request.|No Content|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


##### Produces

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/provider/storages"
```


##### Example HTTP response

###### Response 200
```
json :
"array"
```


###### Response 500
```
json :
{
  "error" : "Invalid Request",
  "description" : "User role must be one of 'admin' or 'regular'."
}
```



