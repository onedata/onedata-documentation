
<a name="get_space_details"></a>
#### Get space details
```
GET /provider/spaces/{id}
```


##### Description
Returns details of space specified by space Id in the path.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*|The ID of a space which details should be returned.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The space details.|[SpaceDetails](../definitions/SpaceDetails.md#spacedetails)|
|**401**|Unauthorized request.|No Content|
|**403**|Forbidden request.|No Content|
|**404**|Space does not exist or is not supported by the provider.|No Content|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


##### Produces

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/provider/spaces/string"
```


##### Example HTTP response

###### Response 200
```
json :
{
  "id" : "string",
  "name" : "string",
  "storageId" : "string",
  "localStorages" : [ "string" ],
  "supportingProviders" : {
    "string" : 0
  },
  "mountInRoot" : true,
  "storageImport" : {
    "strategy" : "string",
    "maxDepth" : 0
  },
  "storageUpdate" : {
    "strategy" : "string",
    "maxDepth" : 0,
    "scanInterval" : 0,
    "writeOnce" : true,
    "deleteEnable" : true
  }
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



