
<a name="get_handle_group"></a>
#### Get handle group
```
GET /handles/{hndl}/groups/{gid}
```


##### Description
Returns the details of a group with access to handle.

This operation requires `modify_handle` privilege.

***Example cURL requests***

**Add handle group**
```bash
curl -u username:password -X GET \
https://$HOST:8443/api/v3/handles/SADHLKJhlkASHDLAKSHDLKJHJjLH/groups/DLAKSHDLKJHJjLHADHLKJh
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**gid**  <br>*required*|The ID of the group to add to handle.|string|--|
|**Path**|**hndl**  <br>*required*|The ID of the handle.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|Group details returned successfully.|[Group](../definitions/Group.md#group)|
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
"/handles/string/groups/string"
```


##### Example HTTP response

###### Response 200
```
json :
{
  "name" : "Test group",
  "type" : "role"
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



