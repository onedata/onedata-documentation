
<a name="delete_provider_spaces_id"></a>
#### Revoke space support
```
DELETE /provider/spaces/{id}
```


##### Description
Revokes support for a space.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*|The ID of a space to be removed.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|The space support has been successfully revoked.|No Content|
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

###### Response 500
```
json :
{
  "error" : "Invalid Request",
  "description" : "User role must be one of 'admin' or 'regular'."
}
```



