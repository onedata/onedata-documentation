
<a name="add_provider_workers"></a>
#### Add provider cluster workers
```
POST /provider/workers
```


##### Description
Deploys cluster worker services on provided hosts.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Body**|**serviceHosts**  <br>*required*|The service hosts configuration where workers should be deployed.|[ServiceHosts](../definitions/ServiceHosts.md#servicehosts)|--|


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


