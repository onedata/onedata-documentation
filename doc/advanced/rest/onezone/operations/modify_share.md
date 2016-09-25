
<a name="modify_share"></a>
#### Modify share details
```
PATCH /shares/{id}
```


##### Description
Updates the details about a share.

***Example cURL requests***

**Change share name**
```bash
curl -k -u username:password -H "Content-type: application/json" \
-X PATCH -d '{"name": "new_share_name"}' \
https://$HOST:8443/api/v3/onezone/shares/56ID6lRxcbz4OEbrr7vPI52UA7E6WwkqQ6bJCtW5PLE
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*|Space ID.|string|--|
|**Body**|**data**  <br>*required*|Share parameters|[ShareUpdateRequest](../definitions/ShareUpdateRequest.md#shareupdaterequest)|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|Share has been updated successfully.|No Content|
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
"/shares/string"
```


###### Request body
```
json :
{
  "shareId" : null,
  "name" : "MyNewShare",
  "publicUrl" : "https://onedata.org/shares/ASDLKJH8asdkjasd89898asd89asdlbKJSBDikjab89-asdmASD",
  "rootFileId" : "ASDkjlkkasdjoiwnafldnacbaasd8879a8sdkjb",
  "parentSpace" : "LKJH8asdkjasd89898asd89asdlbKJSBD79a8sdk"
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



