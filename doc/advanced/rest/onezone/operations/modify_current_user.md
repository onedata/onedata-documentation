
<a name="modify_current_user"></a>
#### Modify current user
```
PATCH /user
```


##### Description
Modifies user account details based on information provided in the request body.

This operation can be invoked on behalf of current user only.

***Example cURL requests***

**Change user name**
```bash
curl -u username:password  -H "Content-type: application/json" -X PATCH  \
-d '{"name": "new_name"}' \
https://$HOST:8443/api/v3/onezone/user
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Body**|**data**  <br>*required*|User data.|[UserUpdateRequest](../definitions/UserUpdateRequest.md#userupdaterequest)|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|User information updated successfully.|No Content|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**401**|Authentication error.|[Error](../definitions/Error.md#error)|
|**403**|Authorization error.|[Error](../definitions/Error.md#error)|
|**404**|Resource not found.|[Error](../definitions/Error.md#error)|
|**500**|Internal server Error.|[Error](../definitions/Error.md#error)|


##### Consumes

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/user"
```


###### Request body
```
json :
{
  "name" : "Rudolf Lingens",
  "alias" : "John Doe"
}
```


##### Example HTTP response

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



