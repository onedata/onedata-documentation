
<a name="modify_share"></a>
#### Modify share details
```
PATCH /shares/{id}
```


##### Description
Updates the details about a share.

Currently this operation allows only to change the name of the share.

This operation requires privilege `space_manage_shares` in space
in which the share was created.

***Example cURL requests***

**Change share name**
```bash
curl -u username:password -H "Content-type: application/json" \
-X PATCH -d '{"name": "NewShareName"}' \
https://$HOST:8443/api/v3/onezone/shares/56ID6lRxcbz4OEbrr7vPI52UA7E6WwkqQ6bJCtW5PLE
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*|Space ID.|string|--|
|**Body**|**data**  <br>*required*|Share parameters|[data](#modify_share-data)|--|

<a name="modify_share-data"></a>
**data**

|Name|Description|Schema|
|---|---|---|
|**name**  <br>*optional*|The name of the share.|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|Share will be updated.|No Content|
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
  "name" : "string"
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



