
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
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|No Content|
|**500**|Internal server error.|No Content|


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


###### Response 400
```
json :
{
  "error" : "Authentication Error",
  "description" : "Invalid username or password."
}
```



