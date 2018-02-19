
<a name="list_effective_group_handles"></a>
#### List effective group handles
```
GET /groups/{id}/effective_handles
```


##### Description
Returns the list of effective groups' handles.

This operation requires `group_view` privilege.

***Example cURL requests***

**List effective group handles**
```bash
curl -u username:password -X GET \
https://$HOST/api/v3/onezone/groups/LKJAHGSDLKJHALSDkjashdasdk/effective_handles

{
  "handles": [
    "IkHB2CCoAFm5FCswhAJynbFU4fj26yiE1lhpK3p-0Y8"
  ]
}
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*|Group ID.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|Returns the list of group effective handles.|[Handles](../definitions/Handles.md#handles)|
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
"/groups/string/effective_handles"
```


##### Example HTTP response

###### Response 200
```
json :
{
  "handles" : [ "Bmav38YI0Z2-dw-fvrZ3XP-J0HjCN0taT3_WungK", "ASmlkZW50aWZpZXIgOEhmSEFSSGdrbHFCa1pWSTR" ]
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



