
<a name="get_share"></a>
#### Get share details
```
GET /shares/{id}
```


##### Description
Returns the details about a specific share.

***Example cURL requests***

**Get space details**
```bash
curl -u admin:password -X GET \
https://$HOST:8443/api/v3/onezone/shares/bI4QaPBog_0kCdUddUIsgAxi5I803ZirkUfdiWDd4W3

{
  "shareId": "bI4QaPBog_0kCdUddUIsgAxi5I803ZirkUfdiWDd4W3",
  "name": "MyShare",
  "publicUrl": "http://onedata.org/shares/bI4QaPBog_0kCdUddUIsgAxi5I803ZirkUfdiWDd4W3",
  "rootFileId": "I4QaPBog0kCdUPBog0kCdUdd",
  "spaceId": "UIsgAxi5I803ZirkUfdiWDd4W3bI4QaPBog_0kCdUdd",
  "handleId": "doi:10.15911/MyShares.726855"
}
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*|Share ID.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|Information about a share.|[Share](../definitions/Share.md#share)|
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
"/shares/string"
```


##### Example HTTP response

###### Response 200
```
json :
{
  "shareId" : "8asd89asdlbKJSBD79a8sdkLKJH8asdkjasd8989",
  "name" : "MyNewShare",
  "publicUrl" : "https://onedata.org/shares/ASDLKJH8asdkjasd89898asd89asdlbKJSBDikjab89-asdmASD",
  "rootFileId" : "ASDkjlkkasdjoiwnafldnacbaasd8879a8sdkjb",
  "spaceId" : "LKJH8asdkjasd89898asd89asdlbKJSBD79a8sdk",
  "handleId" : "doi:10.15911/MyShares.726855"
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



