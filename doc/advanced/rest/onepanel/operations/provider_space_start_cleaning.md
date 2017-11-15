
<a name="provider_space_start_cleaning"></a>
#### Start space cleaning
```
POST /provider/spaces/{id}/start_cleaning
```


##### Description
Starts cleaning of space with current configuration.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*|The ID of a space|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|Cleaning of given space has started.|No Content|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**401**|Unauthorized request.|No Content|
|**403**|Forbidden request.|No Content|
|**500**|Internal server error.|[ServiceError](../definitions/ServiceError.md#serviceerror)|


##### Consumes

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/provider/spaces/string/start_cleaning"
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
  "error" : "string",
  "description" : "string",
  "module" : "string",
  "function" : "string",
  "hosts" : {
    "string" : "[error](#error)"
  }
}
```



