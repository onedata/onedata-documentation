
<a name="delete_host"></a>
#### Remove cluster node
```
DELETE /hosts/{host}
```


##### Description
Removes a node from the administrative cluster.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**host**  <br>*required*|Hostname of a node to be removed from the cluster.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|Node has been successfully removed from the cluster.|No Content|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|No Content|
|**404**|Host not found.|No Content|
|**500**|Internal server error.|No Content|


##### Consumes

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/hosts/string"
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



