
<a name="get_storage_details"></a>
#### Get storage details
```
GET /provider/storages/{id}
```


##### Description
Returns the details of the selected storage.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*|The ID of a storage resource, which details should be returned.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The details of a selected storage.|[StorageDetails](../definitions/StorageDetails.md#storagedetails)|
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
  "id" : "string",
  "name" : "string",
  "insecure" : true,
  "readonly" : true,
  "type" : "string",
  "lumaEnabled" : true,
  "lumaUrl" : "string",
  "lumaCacheTimeout" : 0,
  "lumaApiKey" : "string"
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



