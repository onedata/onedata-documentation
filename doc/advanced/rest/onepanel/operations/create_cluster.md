
<a name="create_cluster"></a>
#### Create or join cluster
```
POST /hosts
```


##### Description
Initializes administrative cluster or if `clusterHost` parameter has been provided in the query string adds this host to an existing cluster.
In both cases the host handling this request has to be newly started or removed from previous cluster. It cannot contain any configuration data.
This request can be executed by unauthorized users as long as there are no admin users.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Query**|**clusterHost**  <br>*optional*|Hostname of an existing cluster node.|string|--|
|**Body**|**cookie**  <br>*optional*|The cookie used for cluster authentication.|[Cookie](../definitions/Cookie.md#cookie)|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|Cluster has been successfully initialized or extended.|No Content|
|**403**|Forbidden request.|No Content|
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


###### Request body
```
json :
{
  "cookie" : "AS2KLJH1231AJSHDKJBC12KS578A3SDA"
}
```


##### Example HTTP response

###### Response 500
```
json :
{
  "error" : "Invalid Request",
  "description" : "User role must be one of 'admin' or 'regular'."
}
```



