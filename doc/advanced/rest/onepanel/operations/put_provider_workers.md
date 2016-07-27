
<a name="put_provider_workers"></a>
#### Deploy provider workers
```
PUT /provider/workers
```


##### Description
Deploys a cluster worker service on provided hosts.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Body**|**serviceHosts**  <br>*required*||[ServiceHosts](../definitions/ServiceHosts.md#servicehosts)|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|Deployment process successfully started.  <br>**Headers** :   <br>`Location` (string) : The path to the task resource, which can be queried to <br>check operation status.|No Content|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|[Error](../definitions/Error.md#error)|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


##### Consumes

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/provider/workers"
```


###### Request body
```
json :
{
  "hosts" : [ "node1.example.com", "node2.example.com", "node3.example.com" ]
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


###### Response 500
```
json :
{
  "error" : "Authentication Error",
  "description" : "Invalid username or password."
}
```



