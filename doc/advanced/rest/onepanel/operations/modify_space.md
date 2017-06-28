
<a name="modify_space"></a>
#### Modify space details
```
PATCH /provider/spaces/{id}
```


##### Description
Modifies the space import/update strategies.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*|The ID of a space which details should be modified.|string|--|
|**Body**|**spaceModifyRequest**  <br>*required*||[SpaceModifyRequest](../definitions/SpaceModifyRequest.md#spacemodifyrequest)|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|The space details has been successfully changed.|No Content|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**401**|Unauthorized request.|No Content|
|**403**|Forbidden request.|No Content|
|**404**|The user does not exist.|No Content|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


##### Consumes

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/provider/spaces/string"
```


###### Request body
```
json :
{
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


##### Example HTTP response

###### Response 400
```
json :
{
  "error" : "Invalid Request",
  "description" : "User role must be one of 'admin' or 'regular'."
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



