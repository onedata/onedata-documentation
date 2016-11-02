
<a name="get_cluster_cookie"></a>
#### Get cluster cookie
```
GET /cookie
```


##### Description
Returns cookie of a cluster this host belongs to. The cookie is a character sequence that is common for all the cluster nodes. The cookies are used for authentication between distributed Erlang Onedata processes.


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The cookie of a cluster this host belongs to.|string|
|**401**|Unauthorized request.|No Content|
|**403**|Forbidden request.|No Content|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


##### Produces

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/cookie"
```


##### Example HTTP response

###### Response 200
```
json :
"string"
```


###### Response 500
```
json :
{
  "error" : "Invalid Request",
  "description" : "User role must be one of 'admin' or 'regular'."
}
```



