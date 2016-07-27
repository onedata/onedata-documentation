
<a name="patch_provider_workers"></a>
#### Start/stop cluster worker service
```
PATCH /provider/workers
```


##### Description
Starts or stops cluster worker service on all hosts in the local deployment.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Query**|**started**  <br>*optional*|Defines the intended state of the cluster worker service. The service will be<br>started or stopped in order to match the requested state.|boolean|`"true"`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|Databases service state changed successfully.|No Content|
|**400**|An error has occurred while changing cluster worker service status.|[ServiceError](../definitions/ServiceError.md#serviceerror)|
|**403**|Forbidden request.|[Error](../definitions/Error.md#error)|
|**404**|Cluster worker service has not been deployed.|[Error](../definitions/Error.md#error)|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


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

###### Response 400
```
json :
{
  "hosts" : {
    "string" : "[error](#error)"
  }
}
```


###### Response 403
```
json :
{
  "error" : "Authentication Error",
  "description" : "Invalid username or password."
}
```


###### Response 404
```
json :
{
  "error" : "Authentication Error",
  "description" : "Invalid username or password."
}
```


###### Response 500
```
json :
{
  "error" : "Authentication Error",
  "description" : "Invalid username or password."
}
```



