
<a name="start_stop_zone_managers"></a>
#### Start/stop zone cluster managers
```
PATCH /zone/managers
```


##### Description
Starts or stops cluster manager service on all hosts in the local deployment.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Query**|**started**  <br>*optional*|Defines the intended state of the cluster manager service. The service will be started or stopped in order to match the requested state.|boolean|`"true"`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|Cluster manager service state changed successfully.|No Content|
|**401**|Unauthorized request.|No Content|
|**403**|Forbidden request.|No Content|
|**404**|Cluster manager service has not been deployed.|No Content|
|**500**|Internal server error.|[ServiceError](../definitions/ServiceError.md#serviceerror)|


##### Example HTTP request

###### Request path
```
json :
"/zone/managers"
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



