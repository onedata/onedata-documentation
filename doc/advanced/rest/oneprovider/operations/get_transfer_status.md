
<a name="get_transfer_status"></a>
#### Get transfer status
```
GET /transfers/{tid}
```


##### Description
Returns status of specific transfer. In case the transfer has been scheduled for entire folder, the result is a list of transfer statuses for each item in the folder.

***Example cURL requests***

**Get status of specific transfer**
```bash
curl --tlsv1.2 -X GET -H "X-Auth-Token: $TOKEN" \
"https://$HOST:8443/transfers/3b6a31fb-ca87-4ea6-8526-fbf5a0773d69

{
  "path": "/My Space 1/Folder2/file3.txt",
  "status": "scheduled",
  "targetProviderId": "b3c85b99-44db-4277-8c66-2ccd50888565"
}
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**tid**  <br>*required*|Transfer ID.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The list of transfer statuses.|< [FileTransferStatus](../definitions/FileTransferStatus.md#filetransferstatus) > array|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|[Error](../definitions/Error.md#error)|
|**404**|Transfer with provided ID was not found.|[Error](../definitions/Error.md#error)|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


##### Produces

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/transfers/string"
```


##### Example HTTP response

###### Response 200
```
json :
"array"
```


###### Response 400
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



