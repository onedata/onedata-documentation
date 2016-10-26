
<a name="start_stop_zone_databases_host"></a>
#### Start/stop zone database
```
PATCH /zone/databases/{host}
```


##### Description
Starts or stops database service on the selected hosts in the local  deployment.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**host**  <br>*required*|The name of a host for which database service status should be changed.|string|--|
|**Query**|**started**  <br>*optional*|Defines the intended state of the database service. The service will be started or stopped in order to match the requested state.|boolean|`"true"`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|Database service state changed successfully.|No Content|
|**401**|Unauthorized request.|No Content|
|**403**|Forbidden request.|No Content|
|**404**|Database service has not been deployed on the selected host.|No Content|
|**500**|Internal server error.|[ServiceError](../definitions/ServiceError.md#serviceerror)|


##### Example HTTP request

###### Request path
```
json :
"/zone/databases/string"
```


###### Request query
```
json :
{
  "started" : true
}
```


##### Example HTTP response

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


