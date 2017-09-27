
<a name="get_transfer_status"></a>
#### Get transfer status
```
GET /transfers/{tid}
```


##### Description
Returns status of specific transfer.

***Example cURL requests***

**Get status of specific transfer**
```bash
curl --tlsv1.2 -X GET -H "X-Auth-Token: $TOKEN" \
"https://$HOST:8443/api/v3/oneprovider/transfers/3b6a31fb-ca87-4ea6-8526-fbf5a0773d69"

{
  "transferStatus":"completed",
  "targetProviderId":"HICATChd8wzbFmB6qfGby9VN7MfdXgI1qC4pULGVm8Q",
  "startTime":1504688814,
  "path":"/space/tmp",
  "minHist":[419430400,1153433600,1258291200,1468006400,1048576000,1048576000,1048576000,1153433600,629145600,1258291200,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
  "lastUpdate":1504689377,
  "invalidationStatus":"skipped",
  "hrHist":[10485760000,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
  "filesTransferred":1,
  "filesToTransfer":1,
  "fileId":"00000000005CF4706775696423745F772D67686431633765446F4D76546D6F2D67575F3361737A7670486B477A7936587734507265584A7723394A4F355F5F396E4C31623031594576776E667431723230677767776C6B497031394E445F6E3868677873",
  "dyHist":[10485760000,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
  "callback":null,
  "bytesTransferred":10485760000,
  "bytesToTransfer":10485760000
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



