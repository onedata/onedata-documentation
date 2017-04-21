
<a name="remove_share"></a>
#### Remove share
```
DELETE /shares/{id}
```


##### Description
Removes a specific share.

This operation requires privilege `space_manage_shares` in space
in which the share was created.

***Example cURL requests***

**Remove space**
```bash
curl -u admin:password -X DELETE \
https://$HOST:8443/api/v3/onezone/shares/803ZirkUfdiWDd4W3bI4QaPBog_0kCdUddUIsgAxi5I
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*|Share ID.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**202**|The share will been removed.|No Content|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**401**|Authentication error.|[Error](../definitions/Error.md#error)|
|**403**|Authorization error.|[Error](../definitions/Error.md#error)|
|**404**|Resource not found.|[Error](../definitions/Error.md#error)|
|**500**|Internal server Error.|[Error](../definitions/Error.md#error)|


##### Example HTTP request

###### Request path
```
json :
"/shares/string"
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



