
<a name="remove_client_token"></a>
#### Delete access token
```
DELETE /user/client_tokens/{tid}
```


##### Description
Removes a specific access token.

This operation can be invoked on behalf of current user only.

***Example cURL requests***

**Delete user space**
```bash
curl -u username:password -X DELETE \
https://$HOST:8443/api/v3/onezone/user/client_tokens/PMPs42mROSS7Rg7z7BwU9JYpSof4SvIW5v14uQY8X08
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**tid**  <br>*required*|Token.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**202**|The token will be deleted.|No Content|
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
"/user/client_tokens/string"
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



