
<a name="get_provider_space"></a>
#### Get space supported by provider
```
GET /providers/{pid}/spaces/{sid}
```


##### Description
Returns the details of space supported by a specific provider.

This operation requires `list_spaces_of_provider` privilege.

***Example cURL requests***

**Get space supported by provider**
```bash
curl -u username:password -X GET  \
https://$HOST:8443/api/v3/onezone/providers/ASDJKHASDASD5465asdvASDasd/spaces/KJHAGSDJKHGASJKHDGAKJHSDGKHJASD

{
  "spaceId": "KJHAGSDJKHGASJKHDGAKJHSDGKHJASD",
  "name": "new_space1",
  "canonicalName": "new_space1",
  "providersSupports": []
}
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**pid**  <br>*required*|Provider ID.|string|--|
|**Path**|**sid**  <br>*required*|Space ID.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The space details.|[Space](../definitions/Space.md#space)|
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
"/providers/string/spaces/string"
```


##### Example HTTP response

###### Response 200
```
json :
{
  "name" : "My Private space",
  "token" : "JKAxNWxvY2F0aW9uIG9uZXpvbmUKMDAzYmlkZW50aWZpZXIgOEhmSEFSSGdrbHFCa1pWSTRsNk1CVHZTU3Z0OThwcHA2OTQ4czhRN1NPawowMDFhY2lkIHRpbWUgPCAxNDk2MTQwMTQ0CjAwMmZzaWduYXR1cmUg88OIBmav38YI0Z2-dw-fvrZ3XP-J0HjCN0taT3_WungK",
  "size" : 150
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



