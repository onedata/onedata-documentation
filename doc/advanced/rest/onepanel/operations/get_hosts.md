
<a name="get_hosts"></a>
#### Get cluster/discovered hosts
```
GET /hosts
```


##### Description
Returns the list of administrative cluster hosts. It is also possible to
return the list of hosts that have been discovered using multicast 
advertisment.
In order to retrive discovered hosts set the `discovered` query string to
`true`. This request can be executed unauthorized as long as there are
no admin users.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Query**|**discovered**  <br>*optional*|Defines whether return cluster or discovered hosts.|boolean|`"false"`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The list of administrative cluster hosts.|< string > array|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|[Error](../definitions/Error.md#error)|
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



