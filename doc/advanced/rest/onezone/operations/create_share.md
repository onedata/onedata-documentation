
<a name="create_share"></a>
#### Create share
```
POST /shares
```


##### Description
Creates a new share.

This operation requires privilege `space_manage_shares` in space
in which the share is created.

***Example cURL requests***

**Create share**
```bash
curl -u username:password -H "Content-type: application/json" -X POST -d \
'{"shareId": "LKJASD2123saa3", "name": "NewShare", "spaceId": "LKJASHDKLJHASDKJHASD876asd", "rootFileId": "LKAHSDJHuuasDASDasdjjasdAS"}' \
https://$HOST:8443/api/v3/onezone/shares
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
  "name" : "MyNewShare"
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



