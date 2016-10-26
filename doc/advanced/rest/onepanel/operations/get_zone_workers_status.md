
<a name="get_zone_workers_status"></a>
#### Get zone cluster workers status
```
GET /zone/workers
```


##### Description
Returns status of cluster worker service on each host where it has been deployed.


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The status of cluster worker service on each host where it has been  deployed.|[ServiceStatus](../definitions/ServiceStatus.md#servicestatus)|
|**401**|Unauthorized request.|No Content|
|**403**|Forbidden request.|No Content|
|**404**|Cluster worker service has not been deployed.|No Content|
|**500**|Internal server error.|[ServiceError](../definitions/ServiceError.md#serviceerror)|


##### Produces

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/zone/workers"
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


