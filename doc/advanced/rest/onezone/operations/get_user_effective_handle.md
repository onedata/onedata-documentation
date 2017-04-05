
<a name="get_user_effective_handle"></a>
#### Get effective handle details
```
GET /user/effective_handles/{hid}
```


##### Description
Returns information about a specific effective handle to which the user belongs.

This operation can be invoked on behalf of current user only.

***Example cURL requests***

**Get user effective space**
```bash
curl -u username:password -X GET \
https://$HOST:8443/api/v3/onezone/user/effective_handles/oOVF-KrO1P6rpA0LFgNVI8NxuhxyQMUnrYzjAnKiyAY

{
  "handleId": "SADHLKJhlkASHDLAKSHDLKJHJjLH",
  "handleType": "DOI",
  "handleServiceId": "ASKDGHKAJSHDukjhasdlkjalksjd76876asdkb",
  "handle": "10.572/ABCD-asdakjsdak87587asdk-1234/8",
  "resourceId": "dlkjalkADKDGHKAJSHDukjhassjd76876asdkb",
  "metadata": "...",
  "timestamp": "1997-07-16T19:20"
}
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**hid**  <br>*required*|Handle ID.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|Returns the information about a specific effective handle.|[Handle](../definitions/Handle.md#handle)|
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
"/user/effective_handles/string"
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



