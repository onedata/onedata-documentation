
<a name="put_hosts"></a>
#### Create or join cluster
```
PUT /hosts
```


##### Description
Initializes administrative cluster or if `clusterHost` parameter has been
provided in the query string adds this host to an existing cluster.

In case of cluster initialization this request removes all user and
configuration data. This request can be executed unauthorized as long as
there are no admin users.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Query**|**clusterHost**  <br>*optional*|Hostname of an existing cluster node.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|Cluster has been successfully initialized or extended.|No Content|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|[Error](../definitions/Error.md#error)|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


##### Consumes

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/hosts"
```


###### Request query
```
json :
{
  "clusterHost" : "string"
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


