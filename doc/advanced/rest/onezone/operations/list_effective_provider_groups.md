
<a name="list_effective_provider_groups"></a>
#### List effective groups of provider
```
GET /providers/{pid}/effective_groups
```


##### Description
Returns the effective list of groups of a specific provider.

This operation requires `list_groups_of_provider` privilege.

***Example cURL requests***

**List groups of a provider**
```bash
curl -u username:password -X GET  \
https://$HOST:8443/api/v3/onezone/providers/ASDJKHASDASD5465asdvASDasd/groups

{
  "groups": [
    "ASDKJHKLAJSDHKjhAsdkjh68asdASDlk",
    "JKLAHSDLKHASJKLDH76786ASDHBKJHMa"
  ]
}
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**pid**  <br>*required*|Provider ID.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The list of group ID's.|[Groups](../definitions/Groups.md#groups)|
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
"/providers/string/effective_groups"
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



