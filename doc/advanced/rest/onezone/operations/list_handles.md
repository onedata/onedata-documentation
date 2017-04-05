
<a name="list_handles"></a>
#### List handles
```
GET /handles
```


##### Description
Returns the list of ID's of all handles accessible by the current user.

***Example cURL requests***

**Get handles**
```bash
curl -u username:password -X GET https://$HOST:8443/api/v3/handles

{
  "handles": [
    "SADHLKJhlkASHDLAKSHDLKJHJjLH",
    "LAKSHDLKJHJjLHSADHLKJhlkASHD"
  ]
}
```


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The list of handle identifiers (Onedata internal GUID's).|[Handles](../definitions/Handles.md#handles)|
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
{
  "handles" : [ "Bmav38YI0Z2-dw-fvrZ3XP-J0HjCN0taT3_WungK", "ASmlkZW50aWZpZXIgOEhmSEFSSGdrbHFCa1pWSTR" ]
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



