
<a name="get_provider_storages_name"></a>
#### Get storage details
```
GET /provider/storages/{name}
```


##### Description
Returns the details of the selected storage.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**name**  <br>*required*|The name of a storage resource, which details should be returned.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The details of a selected storage|[ClusterStorages](../definitions/ClusterStorages.md#clusterstorages)|
|**401**|Unauthorized request.|No Content|
|**403**|Forbidden request.|No Content|
|**404**|Storage does not exist.|No Content|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


##### Produces

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/provider/storages/string"
```


##### Example HTTP response

###### Response 200
```
json :
{
  "type" : "string"
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



