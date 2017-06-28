
<a name="add_handle_service_user"></a>
#### Add handle service user
```
PUT /handle_services/{id}/users/{uid}
```


##### Description
Allows to add a user to a handle service.

This operation requires `handle_service_update` privilege.

***Example cURL requests***

**Add handle service user**
```bash
curl -u username:password -X PUT \
https://$HOST:8443/api/v3/handle_services/SADHLKJhlkASHDLAKSHDLKJHJjLH/users/DLAKSHDLKJHJjLHADHLKJh
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*|The ID of the handle service.|string|--|
|**Path**|**uid**  <br>*required*|The ID of the user to add to handle service.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|User added successfully.|No Content|
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
"/handle_services/string/users/string"
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



