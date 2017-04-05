
<a name="create_share"></a>
#### Create share
```
POST /shares
```


##### Description
Creates a new share.

***Example cURL requests***

**Create share**
```bash
curl -u username:password -H "Content-type: application/json" \
-X POST -d '{"name": "new_share_name"}' \
https://$HOST:8443/api/v3/onezone/shares/56ID6lRxcbz4OEbrr7vPI52UA7E6WwkqQ6bJCtW5PLE
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
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
"/shares"
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



