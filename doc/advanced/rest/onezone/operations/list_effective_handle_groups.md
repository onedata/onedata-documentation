
<a name="list_effective_handle_groups"></a>
#### Get effective handle groups
```
GET /handles/{hndl}/effective_groups
```


##### Description
Returns effective groups with access to a handle instance.

This operation requires `view_handle` privilege.

***Example cURL requests***

**Get handle groups**
```bash
curl -u username:password -X GET \
https://$HOST:8443/api/v3/handles/SADHLKJhlkASHDLAKSHDLKJHJjLH/effective_groups

{
  "groups": [
    "LKLKJhlkASHDJLAKSHDHJjL",
    "KJHJjLHDLLKLAKSJhlkASHD"
  ]
}
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**hndl**  <br>*required*|The ID of the handle service.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The effective list of identifiers of groups with access to specific handle.|[Groups](../definitions/Groups.md#groups)|
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
"/handles/string/effective_groups"
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



