
<a name="cluster_worker_start_stop"></a>
#### Start/stop worker node
```
PATCH /cluster/workers/{host}
```


##### Description
Starts or stops specific Oneprovider worker in the local site.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**host**  <br>*required*|The host name where the worker is running.|string|--|
|**Query**|**started**  <br>*optional*|This flag changes the intended state of the worker instance. <br><br>If the state is changed, the service will be stopped or started in order to match the requested state.|boolean|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|Worker state changed successfully.|No Content|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|[Error](../definitions/Error.md#error)|
|**404**|Oneprovider service configuration is not available.|[Error](../definitions/Error.md#error)|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


##### Example HTTP request

###### Request path
```
json :
"/cluster/workers/string"
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



