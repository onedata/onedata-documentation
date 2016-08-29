
<a name="patch_provider_workers"></a>
#### Start/stop provider cluster workers
```
PATCH /provider/workers
```


##### Description
Starts or stops cluster worker service on all hosts in the local deployment.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Query**|**started**  <br>*optional*|Defines the intended state of the cluster worker service. The service will be started or stopped in order to match the requested state.|boolean|`"true"`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|Cluster worker service state changed successfully.|No Content|
|**401**|Unauthorized request.|No Content|
|**403**|Forbidden request.|No Content|
|**404**|Cluster worker service has not been deployed.|No Content|
|**500**|Internal server error.|[ServiceError](../definitions/ServiceError.md#serviceerror)|


##### Example HTTP request

###### Request path
```
json :
"/provider/workers"
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



