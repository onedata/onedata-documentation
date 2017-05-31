
<a name="create_client_token"></a>
#### Generate user access token
```
POST /user/client_tokens
```


##### Description
Creates new user token. The token is returned in the response body.

This operation can be invoked on behalf of currently authenticated user only.

***Example cURL requests***

**Generate user token**
```bash
curl -u username:password -X POST -d '' -H 'content-type: application/json' \
  https://$HOST:8443/api/v3/onezone/user/client_tokens

{
  "token": "MDAxNWxvY2F00aW9uIG9uZXpvbmUKMDAzYmlkZW500aWZpZXIgSlVxNGFLVkJSTXVFN3FLbHNQVHlNX00lLeHpYZXNWdVFSMGNfMldpOXFZNAowMDFhY2lkIHRpbWUgPCAxNTIyMzU4MzMzCjAwMmZzaWduYXR1cmUgv02ByyOA9802H02rPMB7Y9mIhDVAjYDmjAUjtrMs13znukK"
}
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Body**|**options**  <br>*optional*|Optional token parameters|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The token has been successfully created.|[ClientToken](../definitions/ClientToken.md#clienttoken)|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**401**|Authentication error.|[Error](../definitions/Error.md#error)|
|**403**|Authorization error.|[Error](../definitions/Error.md#error)|
|**404**|Resource not found.|[Error](../definitions/Error.md#error)|
|**500**|Internal server Error.|[Error](../definitions/Error.md#error)|


##### Consumes

* `application/json`


##### Produces

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/user/client_tokens"
```


###### Request body
```
json :
{ }
```


##### Example HTTP response

###### Response 200
```
json :
{
  "token" : "JKAxNWxvY2F0aW9uIG9uZXpvbmUKMDAzYmlkZW50aWZpZXIgOEhmSEFSSGdrbHFCa1pWSTRsNk1CVHZTU3Z0OThwcHA2OTQ4czhRN1NPawowMDFhY2lkIHRpbWUgPCAxNDk2MTQwMTQ0CjAwMmZzaWduYXR1cmUg88OIBmav38YI0Z2-dw-fvrZ3XP-J0HjCN0taT3_WungK"
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



