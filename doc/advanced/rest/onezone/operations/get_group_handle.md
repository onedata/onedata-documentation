
<a name="get_group_handle"></a>
#### Get group handle details
```
GET /groups/{id}/handles/{hid}
```


##### Description
Returns the details of a specific handle.

***Example cURL requests***

**Get handle details**
```bash
curl -u username:password -X GET \
https://$HOST:8443/api/v3/onezone/groups/KLAJSHDjhkahsdkasjdKLHSALD/handles/oOVF-KrO1P6rpA0LFgNVI8NxuhxyQMUnrYzjAnKiyAY

{

}
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**hid**  <br>*required*|Handle ID.|string|--|
|**Path**|**id**  <br>*required*|Group ID.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|Returns the details of a specific handle.|[Handle](../definitions/Handle.md#handle)|
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
"/groups/string/handles/string"
```


##### Example HTTP response

###### Response 200
```
json :
{
  "handleId" : "2MTQwMTQ0CjAwMmZzaWduYXR1cmUg88",
  "handleType" : "DOI",
  "handle" : "10.572/test-handle-G9uZXpvbmUKMDAzYmlkZW50aWZpZXIgOEh/123",
  "resourceId" : "RsNk1CVHZTU3Z0OThwcHAhRN1NPawowMDFhY2lkIHRpbWUgPC",
  "handleServiceId" : "JKAxNWxvY2F0aW9uImSEFSSGdrbHFCa1pWST2OTQ4cz"
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



