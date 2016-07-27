
<a name="get_provider_storages"></a>
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
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|No Content|
|**500**|Internal server error.|No Content|


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


###### Response 400
```
json :
{
  "error" : "Authentication Error",
  "description" : "Invalid username or password."
}
```



