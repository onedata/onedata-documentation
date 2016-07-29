
<a name="patch_zone_managers"></a>
#### Start/stop zone managers
```
PATCH /zone/managers
```


##### Description
Starts or stops cluster manager service on all hosts in the local deployment.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Query**|**started**  <br>*optional*|Defines the intended state of the cluster manager service. The service will be<br>started or stopped in order to match the requested state.|boolean|`"true"`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|Databases service state changed successfully.|No Content|
|**400**|An error has occurred while changing cluster manager service status.|[ServiceError](../definitions/ServiceError.md#serviceerror)|
|**403**|Forbidden request.|No Content|
|**404**|Cluster manager service has not been deployed.|No Content|
|**500**|Internal server error.|No Content|


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

###### Response 400
```
json :
{
  "hosts" : {
    "string" : "[error](#error)"
  }
}
```



