
<a name="list_effective_space_groups"></a>
#### List effective space groups
```
GET /spaces/{id}/effective_groups
```


##### Description
Returns the effective list of groups belonging to a specific space.

If called by user who is not member of the space, requires `space_view`
privilege.

***Example cURL requests***

**Get space effective groups**
```bash
curl -u username:password -X GET \
https://$HOST:8443/api/v3/onezone/spaces/56ID6lRxcbz4OEbrr7vPI52UA7E6WwkqQ6bJCtW5PLE/effective_groups

{
  "groups": [
    "T5x_HhFYOnILOCUf9OqgExw00RwaU2MXT5122oWk_sM",
    "e3piG9yg9877lagR7aHayk73te9gAMXxQvjBycwvnaow"
  ]
}
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*|Space ID.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The list of effective group ID's that belong to a specific space.|[Groups](../definitions/Groups.md#groups)|
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
"/spaces/string/effective_groups"
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



