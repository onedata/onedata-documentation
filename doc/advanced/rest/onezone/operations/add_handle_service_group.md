
<a name="add_handle_service_group"></a>
#### Add handle service group
```
PUT /handle_services/{id}/groups/{gid}
```


##### Description
Allows to add a group to a handle service.

This operation requires `modify_handle_service` privilege.

***Example cURL requests***

**Add handle service user**
```bash
curl -k -u username:password -X PUT \
https://$HOST:8443/api/v3/handle_services/SADHLKJhlkASHDLAKSHDLKJHJjLH/groups/DLAKSHDLKJHJjLHADHLKJh
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**gid**  <br>*required*|The ID of the group to add to handle service.|string|--|
|**Path**|**id**  <br>*required*|The ID of the handle service.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|Group added successfully.|No Content|
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
"/handle_services/string/groups/string"
```


##### Example HTTP response

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



