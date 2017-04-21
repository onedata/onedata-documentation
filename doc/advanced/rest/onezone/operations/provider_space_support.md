
<a name="provider_space_support"></a>
#### Add space storage support
```
POST /provider/spaces/support
```


##### Description
Adds support for specific space on behalf of the Oneprovider that
performed the request. Space support token is required.

This operation requires peer certificate authentication.

***Example cURL requests***

**Add support for specific space**
```bash
curl --key ./certs/ozp_key.pem --cert ./certs/ozp_cert.pem -X POST \
-d '{"size": 1024000, "token": "Ko1SDKLJASHDkjjkjashdkjahsdkk655a8sdkgkasdASD"}' \
https://$HOST:8443/api/v3/onezone/provider/spaces/803ZirkUfdiWDd4W3bI4QaPBog_0kCdUddUIsgAxi5I
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Body**|**token**  <br>*optional*|The space support token.|[SpaceSupportRequest](../definitions/SpaceSupportRequest.md#spacesupportrequest)|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**201**|ID of the supported space in the form /spaces/{id} is returned in the response `Location` header.  <br>**Headers** :   <br>`Location` (string) : ID of the supported space.|No Content|
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
"/provider/spaces/support"
```


###### Request body
```
json :
{
  "token" : "JKAxNWxvY2F0aW9uIG9uZXpvbmUKMDAzYmlkZW50aWZpZXIgOEhmSEFSSGdrbHFCa1pWSTRsNk1CVHZTU3Z0OThwcHA2OTQ4czhRN1NPawowMDFhY2lkIHRpbWUgPCAxNDk2MTQwMTQ0CjAwMmZzaWduYXR1cmUg88OIBmav38YI0Z2-dw-fvrZ3XP-J0HjCN0taT3_WungK",
  "size" : 1024000000
}
```


##### Example HTTP response

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



