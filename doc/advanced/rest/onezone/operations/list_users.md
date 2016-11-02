
<a name="list_users"></a>
#### List all users
```
GET /users
```


##### Description
Returns the list of all users in the system.

Requires `list_users` privilege.

***Example cURL requests***

**List all users in the system**
```bash
 curl -k -u username:password -X GET https://$HOST:8443/api/v3/onezone/users
```


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The list of user ID's registered within the Onezone service.|[Response 200](#list_users-response-200)|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**401**|Authentication error.|[Error](../definitions/Error.md#error)|
|**403**|Authorization error.|[Error](../definitions/Error.md#error)|
|**404**|Resource not found.|[Error](../definitions/Error.md#error)|
|**500**|Internal server Error.|[Error](../definitions/Error.md#error)|

<a name="list_users-response-200"></a>
**Response 200**

|Name|Description|Schema|
|---|---|---|
|**users**  <br>*optional*||< string > array|


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
"object"
```


###### Response 400
```
json :
{
  "error" : "invalid_token",
  "error_description" : "Provided token could not be validated."
}
```


###### Response 401
```
json :
{
  "error" : "invalid_token",
  "error_description" : "Provided token could not be validated."
}
```


###### Response 403
```
json :
{
  "error" : "invalid_token",
  "error_description" : "Provided token could not be validated."
}
```


###### Response 404
```
json :
{
  "error" : "invalid_token",
  "error_description" : "Provided token could not be validated."
}
```


###### Response 500
```
json :
{
  "error" : "invalid_token",
  "error_description" : "Provided token could not be validated."
}
```



