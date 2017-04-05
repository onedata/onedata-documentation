
<a name="add_provider_managers"></a>
#### Add provider cluster managers
```
POST /provider/managers
```


##### Description
Deploys a cluster manager service on provided hosts.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Body**|**managerHosts**  <br>*required*|The cluster manager service hosts configuration.|[ManagerHosts](../definitions/ManagerHosts.md#managerhosts)|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|Deployment process successfully started.  <br>**Headers** :   <br>`Location` (string) : The path to the task resource, which can be queried to check  operation status.|No Content|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**401**|Unauthorized request.|No Content|
|**403**|Forbidden request.|No Content|
|**500**|Internal server error.|[ServiceError](../definitions/ServiceError.md#serviceerror)|


##### Consumes

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/provider/managers"
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
  "error" : "Invalid Request",
  "description" : "User role must be one of 'admin' or 'regular'."
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



