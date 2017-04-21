
<a name="list_shares"></a>
#### List all shares
```
GET /shares
```


##### Description
Returns the list of shares.

This operation requires administrator privilege `oz_shares_list`.

***Example cURL requests***

**Get shares**
```bash
curl -u admin:password -X GET https://$HOST:8443/api/v3/onezone/shares

{
  "shares: [
    "KLAJSHDKLJAHASJKDHAJKSDH",
    "LKJASHDKJASDHLKJAHSDAKLS",
  ]
}
```


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The list of shares.|[Shares](../definitions/Shares.md#shares)|
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
"/shares"
```


##### Example HTTP response

###### Response 200
```
json :
{
  "shares" : [ "Bmav38YI0Z2-dw-fvrZ3XP-J0HjCN0taT3_WungK", "ASmlkZW50aWZpZXIgOEhmSEFSSGdrbHFCa1pWSTR" ]
}
```


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



