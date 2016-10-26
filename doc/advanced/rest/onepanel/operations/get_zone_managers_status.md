
<a name="get_zone_managers_status"></a>
#### Get zone cluster managers status
```
GET /zone/managers
```


##### Description
Returns status of cluster manager service on each host where it has been  eployed.


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The status of cluster manager service on each host where it has been  deployed.|[ServiceStatus](../definitions/ServiceStatus.md#servicestatus)|
|**401**|Unauthorized request.|No Content|
|**403**|Forbidden request.|No Content|
|**404**|Cluster manager service has not been deployed.|No Content|
|**500**|Internal server error.|[ServiceError](../definitions/ServiceError.md#serviceerror)|


##### Produces

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/zone/managers"
```


##### Example HTTP response

###### Response 200
```
json :
{
  "hosts" : {
    "string" : "[servicestatushost](#servicestatushost)"
  }
}
```


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


