
<a name="cancel_transfer"></a>
#### Cancel specific transfer
```
DELETE /transfers/{tid}
```


##### Description
Cancels a scheduled or active transfer. Returns 400 in case the transfer is already completed, canceled or failed.

***Example cURL requests***

**Cancel specific transfer**
```bash
curl --tlsv1.2 -X DELETE -H "X-Auth-Token: $TOKEN" \
"https://$HOST:8443/api/v3/oneprovider/transfers/3b6a31fb-ca87-4ea6-8526-fbf5a0773d69"
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**tid**  <br>*required*|Transfer ID.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|The transfer has been canceled.|No Content|
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



