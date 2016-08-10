
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
|**Body**|**cookie**  <br>*optional*||[cookie](#put_hosts-cookie)|--|

<a name="put_hosts-cookie"></a>
**cookie**

|Name|Description|Schema|
|---|---|---|
|**cookie**  <br>*optional*|The cluster cookie.|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|Cluster has been successfully initialized or extended.|No Content|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|No Content|
|**500**|Internal server error.|No Content|


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


###### Request body
```
json :
{
  "cookie" : "string"
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



