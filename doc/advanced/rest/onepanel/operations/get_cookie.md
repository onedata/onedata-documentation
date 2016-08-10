
<a name="get_cookie"></a>
#### Get cluster cookie
```
GET /cookie
```


##### Description
Returns cookie of a cluster this host belongs to. The cookie is a character sequence that is common for all the cluster nodes.


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The cookie of a cluster this host belongs to.|string|
|**403**|Forbidden request.|No Content|
|**500**|Internal server error.|No Content|


##### Consumes

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



