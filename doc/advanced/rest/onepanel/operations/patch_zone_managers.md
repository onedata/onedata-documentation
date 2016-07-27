
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
|**403**|Forbidden request.|[Error](../definitions/Error.md#error)|
|**404**|Cluster manager service has not been deployed.|[Error](../definitions/Error.md#error)|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


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



