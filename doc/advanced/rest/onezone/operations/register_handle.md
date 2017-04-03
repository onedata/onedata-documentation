
<a name="register_handle"></a>
#### Register handle
```
POST /handles
```


##### Description
Allows to register a new handle identifier, using a specific handle service.

The handle service must be registered in Onedata separately.

This operation requires `register_handle` privilege.

***Example cURL requests***

**Register handle**
```bash
curl -u username:password -X POST -H "Content-type: application/json" \
-d '{"handleServiceId": "AFSASDARAWD32aasfASSD", "resourceType": "Share", "resourceId": "LKJGLSAKDGASGD34234JKAHSD", "metadata": "..." }' \
https://$HOST:8443/api/v3/handles
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Body**|**handleRegistrationRequest**  <br>*required*||[HandleRegistrationRequest](../definitions/HandleRegistrationRequest.md#handleregistrationrequest)|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|Request successful.  <br>**Headers** :   <br>`Location` (string) : The endpoint of the new handle resource including the generated GUID.|No Content|
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
"/handles"
```


###### Request body
```
json :
{
  "handleServiceId" : "ALKJSDH77i79ASDKJA-ASDBAS9-87",
  "resourceType" : "Share",
  "resourceId" : "LKJAHSDA796IASDKBjkhaksjdk568787asdhjbasd"
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



