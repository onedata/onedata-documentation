
<a name="get_effective_provider_group"></a>
#### Get group of provider
```
GET /providers/{pid}/effective_groups/{gid}
```


##### Description
Returns the details of an effective group of a specific provider.

This operation requires `list_groups_of_provider` privilege.

***Example cURL requests***

**Get group of a provider**
```bash
curl -u username:password -X GET  \
https://$HOST:8443/api/v3/onezone/providers/ASDJKHASDASD5465asdvASDasd/groups/KJHAGSDJKHGASJKHDGAKJHSDGKHJASD

{
  "groupId":"KJHAGSDJKHGASJKHDGAKJHSDGKHJASD",
  "name":"new_group",
  "type":"role"
}
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**gid**  <br>*required*|Group ID.|string|--|
|**Path**|**pid**  <br>*required*|Provider ID.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The group ID.|[Group](../definitions/Group.md#group)|
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
"/providers/string/effective_groups/string"
```


##### Example HTTP response

###### Response 200
```
json :
{
  "groupId" : "ALSKDHLASD8ASDNjasd99",
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



