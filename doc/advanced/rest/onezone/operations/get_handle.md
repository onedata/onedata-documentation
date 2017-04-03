
<a name="get_handle"></a>
#### Get handle
```
GET /handles/{hndl}
```


##### Description
Returns the properties of a specific handle.

This operation requires `view_handle` privilege.

***Example cURL requests***

**Get handle**
```bash
curl -u username:password -X GET \
https://$HOST:8443/api/v3/handles/SADHLKJhlkASHDLAKSHDLKJHJjLH

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
|**Path**|**hndl**  <br>*required*|The handle ID (internal Onedata GUID) of the identifier.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The properties of a specific handle.|[Handle](../definitions/Handle.md#handle)|
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
"/handles/string"
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



