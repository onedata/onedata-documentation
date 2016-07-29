
<a name="patch_zone_workers_host"></a>
#### Start/stop zone worker
```
PATCH /zone/workers/{host}
```


##### Description
Starts or stops cluster worker service on selected hosts in the local deployment.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**host**  <br>*required*|The name of a host for which cluster worker service status should be changed.|string|--|
|**Query**|**started**  <br>*optional*|Defines the intended state of the cluster worker service. The service will be started or stopped in order to match the requested state.|boolean|`"true"`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|Databases service state changed successfully.|No Content|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|No Content|
|**404**|Cluster worker service has not been deployed on selected host.|No Content|
|**500**|Internal server error.|No Content|


##### Example HTTP request

###### Request path
```
json :
"/zone/workers/string"
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
  "error" : "Authentication Error",
  "description" : "Invalid username or password."
}
```



