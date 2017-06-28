
<a name="modify_storage"></a>
#### Modify storage details
```
PATCH /provider/storages/{id}
```


##### Description
Modifies basic storage details, such as operation timeout.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*|The ID of a storage resource, which details should be modified.|string|--|
|**Body**|**storageModifyRequest**  <br>*required*|New values for storage configuration parameters which should be changed.|[StorageModifyRequest](../definitions/StorageModifyRequest.md#storagemodifyrequest)|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|Storage details have been successfully modified.|No Content|
|**401**|Unauthorized request.|No Content|
|**403**|Forbidden request.|No Content|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


##### Consumes

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/provider/storages/string"
```


###### Request body
```
json :
{
  "timeout" : 10000
}
```


##### Example HTTP response

###### Response 500
```
json :
{
  "error" : "Invalid Request",
  "description" : "User role must be one of 'admin' or 'regular'."
}
```



