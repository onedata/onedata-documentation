
<a name="put_provider_databases"></a>
#### Deploy provider databases
```
PUT /provider/databases
```


##### Description
Deploys a database cluster service on provided hosts.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Body**|**serviceHosts**  <br>*required*||[ServiceHosts](../definitions/ServiceHosts.md#servicehosts)|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|Deployment process successfully started.  <br>**Headers** :   <br>`Location` (string) : The path to the task resource, which can be queried to <br>check operation status.|No Content|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|No Content|
|**500**|Internal server error.|No Content|


##### Consumes

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/provider/databases"
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



