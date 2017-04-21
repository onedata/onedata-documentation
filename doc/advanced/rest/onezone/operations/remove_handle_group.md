
<a name="remove_handle_group"></a>
#### Remove handle group
```
DELETE /handles/{hndl}/groups/{gid}
```


##### Description
Allows to remove a group from access to a handle.

This operation requires `modify_handle` privilege.

***Example cURL requests***

**Remove handle service group**
```bash
curl -u username:password -X DELETE \
https://$HOST:8443/api/v3/handles/AKSHDLKJHJjLHSADHLKJhlkASHDL/groups/JHJjLHADHLKJhDLAKSHDLK
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**gid**  <br>*required*|The ID of the group to remove from handle.|string|--|
|**Path**|**hndl**  <br>*required*|The ID of the handle.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**202**|Group will be removed.|No Content|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**401**|Authentication error.|[Error](../definitions/Error.md#error)|
|**403**|Authorization error.|[Error](../definitions/Error.md#error)|
|**404**|Resource not found.|[Error](../definitions/Error.md#error)|
|**500**|Internal server Error.|[Error](../definitions/Error.md#error)|


##### Example HTTP request

###### Request path
```
json :
"/handles/string/groups/string"
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



