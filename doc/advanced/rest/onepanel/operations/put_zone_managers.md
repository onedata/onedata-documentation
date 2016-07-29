
<a name="put_zone_managers"></a>
#### Deploy zone managers
```
PUT /zone/managers
```


##### Description
Deploys a cluster manager service cluster on provided hosts.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Body**|**managerHosts**  <br>*required*||[ManagerHosts](../definitions/ManagerHosts.md#managerhosts)|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|Deployment process successfully started.  <br>**Headers** :   <br>`Location` (string) : The path to the task resource, which can be queried to  check operation status.|No Content|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|No Content|
|**500**|Internal server error.|No Content|


##### Consumes

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/zone/managers"
```


###### Request body
```
json :
{
  "mainHost" : "node1.example.com",
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



