
<a name="oz_users_list"></a>
#### List all users
```
GET /users
```


##### Description
Returns the list of all users in the system.

Requires `oz_users_list` privilege.

***Example cURL requests***

**List all users in the system**
```bash
 curl -u username:password -X GET https://$HOST:8443/api/v3/onezone/users
```


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The list of user ID's registered within the Onezone service.|[Users](../definitions/Users.md#users)|
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
"/users"
```


##### Example HTTP response

###### Response 200
```
json :
{
  "users" : [ "Bmav38YI0Z2-dw-fvrZ3XP-J0HjCN0taT3_WungK", "ASmlkZW50aWZpZXIgOEhmSEFSSGdrbHFCa1pWSTR" ]
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



