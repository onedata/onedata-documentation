
<a name="modify_handle"></a>
#### Modify handle
```
PATCH /handles/{hndl}
```


##### Description
Allows to update a registeed handle, for instance change the Onedata resource
to which it points to.

This operation requires `modify_handle` privilege.

***Example cURL requests***

**Modify handle resource**
```bash
curl -k -u username:password -X PATCH  -H "Content-type: application/json" \
-d '{"resourceId": "jalkADKDGHKAJSdlkHDukjhassjd76876asdkb"}' \
https://$HOST:8443/api/v3/handles/LKHASDkkjhASDLHU70ASDn
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**hndl**  <br>*required*||string|--|
|**Body**|**handle**  <br>*required*||[Handle](../definitions/Handle.md#handle)|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|Update was successful.|No Content|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**401**|Authentication error.|[Error](../definitions/Error.md#error)|
|**403**|Authorization error.|[Error](../definitions/Error.md#error)|
|**404**|Resource not found.|[Error](../definitions/Error.md#error)|
|**500**|Internal server Error.|[Error](../definitions/Error.md#error)|


##### Consumes

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/handles/string"
```


###### Request body
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


##### Example HTTP response

###### Response 400
```
json :
{
  "error" : "invalid_token",
  "error_description" : "Provided token could not be validated."
}
```


###### Response 401
```
json :
{
  "error" : "invalid_token",
  "error_description" : "Provided token could not be validated."
}
```


###### Response 403
```
json :
{
  "error" : "invalid_token",
  "error_description" : "Provided token could not be validated."
}
```


###### Response 404
```
json :
{
  "error" : "invalid_token",
  "error_description" : "Provided token could not be validated."
}
```


###### Response 500
```
json :
{
  "error" : "invalid_token",
  "error_description" : "Provided token could not be validated."
}
```



