
<a name="list_groups"></a>
#### List all groups
```
GET /groups
```


##### Description
Returns the list of all groups in the system.

Requires `oz_groups_list` privilege.

***Example cURL requests***

**List all groups in the system**
```bash
 curl -u username:password -X GET https://$HOST:8443/api/v3/onezone/groups
```


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The list of group ID's created within the Onezone service.|[Groups](../definitions/Groups.md#groups)|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**401**|Authentication error.|[Error](../definitions/Error.md#error)|
|**403**|Authorization error.|[Error](../definitions/Error.md#error)|
|**404**|Resource not found.|[Error](../definitions/Error.md#error)|
|**500**|Internal server Error.|[Error](../definitions/Error.md#error)|


##### Produces

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/groups"
```


##### Example HTTP response

###### Response 200
```
json :
{
  "groups" : [ "Bmav38YI0Z2-dw-fvrZ3XP-J0HjCN0taT3_WungK", "ASmlkZW50aWZpZXIgOEhmSEFSSGdrbHFCa1pWSTR" ]
}
```


###### Response 400
```
json :
{
  "error" : "Provided data could not be understood by the server"
}
```


###### Response 401
```
json :
{
  "error" : "Provided data could not be understood by the server"
}
```


###### Response 403
```
json :
{
  "error" : "Provided data could not be understood by the server"
}
```


###### Response 404
```
json :
{
  "error" : "Provided data could not be understood by the server"
}
```


###### Response 500
```
json :
{
  "error" : "Provided data could not be understood by the server"
}
```



