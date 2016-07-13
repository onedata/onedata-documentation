
<a name="get_cluster_database"></a>
#### Get database status
```
GET /cluster/databases/{host}
```


##### Description
Returns the status of a specific database instance.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**host**  <br>*required*|The host name from which the information about the specific Oneprovider database instance should be returned.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The status of a specific Oneprovider database node.|[ServiceStatus](../definitions/ServiceStatus.md#servicestatus)|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|[Error](../definitions/Error.md#error)|
|**404**|There is no Oneprovider database instance on this node.|[Error](../definitions/Error.md#error)|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


##### Produces

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/cluster/databases/string"
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



