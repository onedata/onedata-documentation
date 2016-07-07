
<a name="get_cluster_manager"></a>
#### Get manager status
```
GET /cluster/managers/{host}
```


##### Description
Returns the status of specific cluster manager instance.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**host**  <br>*required*|The host name from which the information about the specific Oneprovider cluster manager instance should be returned.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The status of a specific Oneprovider cluster manager node.|[ServiceStatus](../definitions/ServiceStatus.md#servicestatus)|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|[Error](../definitions/Error.md#error)|
|**404**|There is no Oneprovider cluster manager instance on this node.|[Error](../definitions/Error.md#error)|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


##### Produces

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/cluster/managers/string"
```


##### Example HTTP response

###### Response 200
```
json :
{
  "service" : "op_worker",
  "result" : "ok"
}
```


###### Response 400
```
json :
{
  "error" : "invalid_token",
  "error_description" : "Provided token could not be validated."
}
```


###### Response 403
```
json :
{
  "error" : "invalid_token",
  "error_description" : "Provided token could not be validated."
}
```


###### Response 404
```
json :
{
  "error" : "invalid_token",
  "error_description" : "Provided token could not be validated."
}
```


###### Response 500
```
json :
{
  "error" : "invalid_token",
  "error_description" : "Provided token could not be validated."
}
```



