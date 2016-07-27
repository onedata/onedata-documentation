
<a name="get_zone_databases_host"></a>
#### Get zone database
```
GET /zone/databases/{host}
```


##### Description
Returns status of database service on selected host.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**host**  <br>*required*|The name of a host for which database service status should be returned.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The status of database service on selected host.|[ServiceStatusHost](../definitions/ServiceStatusHost.md#servicestatushost)|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|[Error](../definitions/Error.md#error)|
|**404**|Database service has not been deployed on selected host.|[Error](../definitions/Error.md#error)|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


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



