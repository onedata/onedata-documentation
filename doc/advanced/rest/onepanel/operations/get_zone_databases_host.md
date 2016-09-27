
<a name="get_zone_databases_host"></a>
#### Get zone database status
```
GET /zone/databases/{host}
```


##### Description
Returns status of database service on the selected host.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**host**  <br>*required*|The name of a host for which database service status should be returned.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The status of database service on the selected host.|[ServiceStatusHost](../definitions/ServiceStatusHost.md#servicestatushost)|
|**401**|Unauthorized request.|No Content|
|**403**|Forbidden request.|No Content|
|**404**|Database service has not been deployed on the selected host.|No Content|
|**500**|Internal server error.|[ServiceError](../definitions/ServiceError.md#serviceerror)|


##### Produces

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/zone/databases/string"
```


##### Example HTTP response

###### Response 200
```
json :
{
  "status" : "string"
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



