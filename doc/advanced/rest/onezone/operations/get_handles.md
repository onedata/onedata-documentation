
<a name="get_handles"></a>
#### Get handles
```
GET /handles
```


##### Description
Returns the list of ID's of all handles accessible by the current user.

***Example cURL requests***

**Get handles**
```bash
curl -k -u username:password -X GET https://$HOST:8443/api/v3/handles

[
  "SADHLKJhlkASHDLAKSHDLKJHJjLH", 
  "LAKSHDLKJHJjLHSADHLKJhlkASHD"
]
```


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The list of handle identifiers (Onedata internal GUID's).|< string > array|
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
"/handles"
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



