
<a name="get_zone_databases"></a>
#### Get zone databases status
```
GET /zone/databases
```


##### Description
Returns status of database service on each host where it has been deployed.


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The status of database service on each host where it has been deployed.|[ServiceStatus](../definitions/ServiceStatus.md#servicestatus)|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|No Content|
|**404**|Database service has not been deployed.|No Content|
|**500**|Internal server error.|No Content|


##### Produces

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/zone/databases"
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



