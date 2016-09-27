
<a name="delete_hosts_host"></a>
#### Remove cluster node
```
DELETE /hosts/{host}
```


##### Description
Removes a node from the administrative cluster. This operation removes all user and configuration data from the host. It also removes the host from each service cluster it belonged to.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**host**  <br>*required*|Hostname of a node to be removed from the cluster.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|Node has been successfully removed from the cluster.|No Content|
|**403**|Forbidden request.|No Content|
|**404**|Host not found.|No Content|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


##### Consumes

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/hosts/string"
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



