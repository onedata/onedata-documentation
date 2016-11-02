
<a name="get_cluster_hosts"></a>
#### Get cluster or discovered hosts
```
GET /hosts
```


##### Description
Returns the list of administrative cluster hosts. It is also possible to return the list of hosts that have been discovered using multicast  advertisment.
In order to retrieve discovered hosts set the `discovered` query string to `true`. This request can be executed by unauthorized users only if there  are no admin users in the system.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Query**|**discovered**  <br>*optional*|Defines whether to return cluster or discovered hosts.|boolean|`"false"`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The list of administrative cluster hosts.|< string > array|
|**403**|Forbidden request.|No Content|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


##### Produces

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
  "discovered" : true
}
```


##### Example HTTP response

###### Response 200
```
json :
"array"
```


###### Response 500
```
json :
{
  "error" : "Invalid Request",
  "description" : "User role must be one of 'admin' or 'regular'."
}
```



