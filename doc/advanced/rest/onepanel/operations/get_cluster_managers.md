
<a name="get_cluster_managers"></a>
#### Get manager nodes
```
GET /cluster/managers
```


##### Description
Returns the list of hostnames where Oneprovider cluster manager instances are deployed (not necessarily currently running).


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|Returns the list of Oneprovider cluster manager nodes in this deployment.|[ServicesStatus](../definitions/ServicesStatus.md#servicesstatus)|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|[Error](../definitions/Error.md#error)|
|**404**|Oneprovider service configuration is not available.|[Error](../definitions/Error.md#error)|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


##### Produces

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/cluster/managers"
```


##### Example HTTP response

###### Response 200
```
json :
{
  "service" : "op_worker",
  "results" : [ {
    "host" : "h1.example.com",
    "result" : "ok"
  }, {
    "host" : "h2.example.com",
    "result" : "error"
  }, {
    "host" : "h3.example.com",
    "result" : "ok"
  } ]
}
```


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



