
<a name="join_space"></a>
#### Join space
```
POST /user/spaces/join
```


##### Description
Join existing space using inivitation token.

This operation can be invoked on behalf of current user only.

***Example cURL requests***

**Join existing space**
```bash
curl -k -u admin:password  -H "Content-type: application/json" -X PUT \
-d '{ "token" : "MDAxNmxvY2F00aW9uRVM2TVo5UlZ5cGFjZV9jcmLciFsOgyUkPI3f02le6PM01IX8go" }'  \
https://$HOST:8443/api/v3/onezone/user/spaces/default
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Body**|**spaceinvitetoken**  <br>*required*|Token for joining a space.|[SpaceInviteToken](../definitions/SpaceInviteToken.md#spaceinvitetoken)|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**201**|ID of the joined space in the form /user/spaces/{id} is  returned in the response `Location` header.  <br>**Headers** :   <br>`Location` (string) : ID of the joined space.|No Content|
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
"/user/spaces/join"
```


###### Request body
```
json :
{
  "token" : "JKAxNWxvY2F0aW9uIG9uZXpvbmUKMDAzYmlkZW50aWZpZXIgOEhmSEFSSGdrbHFCa1pWSTRsNk1CVHZTU3Z0OThwcHA2OTQ4czhRN1NPawowMDFhY2lkIHRpbWUgPCAxNDk2MTQwMTQ0CjAwMmZzaWduYXR1cmUg88OIBmav38YI0Z2-dw-fvrZ3XP-J0HjCN0taT3_WungK"
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



