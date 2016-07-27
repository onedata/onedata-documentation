
<a name="get_provider_workers"></a>
#### Get provider workers
```
GET /provider/workers
```


##### Description
Returns status of cluster worker service on each host where it has been
deployed.


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The status of cluster worker service on each host where it has been<br>deployed.|[ServiceStatus](../definitions/ServiceStatus.md#servicestatus)|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|[Error](../definitions/Error.md#error)|
|**404**|Cluster worker service has not been deployed.|[Error](../definitions/Error.md#error)|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


##### Produces

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/provider/workers"
```


##### Example HTTP response

###### Response 200
```
json :
{
  "services" : {
    "string" : "object"
  }
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


