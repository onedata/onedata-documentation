
<a name="patch_zone_databases_host"></a>
#### Start/stop zone database
```
PATCH /zone/databases/{host}
```


##### Description
Starts or stops database service on selected hosts in the local deployment.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**host**  <br>*required*|The name of a host for which database service status should be changed.|string|--|
|**Query**|**started**  <br>*optional*|Defines the intended state of the database service. The service will be<br>started or stopped in order to match the requested state.|boolean|`"true"`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|Databases service state changed successfully.|No Content|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|[Error](../definitions/Error.md#error)|
|**404**|Database service has not been deployed on selected host.|[Error](../definitions/Error.md#error)|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


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

###### Response 400
```
json :
{
  "error" : "Authentication Error",
  "description" : "Invalid username or password."
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



