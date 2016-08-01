
<a name="get_file_attributes"></a>
#### Get file attributes
```
GET /attributes/{path}
```


##### Description
This method returns selected file attributes.

By default the method returns regular file attributes.

The exteded attributes are accessed by setting `extended` flag 
in the request query to `true`.

***Example cURL requests***

**Get file POSIX mode**
```bash
curl --tlsv1.2 -X GET -H "X-Auth-Token: $TOKEN" \
"https://$HOST:8443/api/v3/oneprovider/attributes/MySpace1/File2.txt?attribute=mode"

[
  { 
    "name": "mode",
    "value": "0777" 
  }
]
```

**Get extended file attributes**
```bash
curl --tlsv1.2 -H "X-Auth-Token: $TOKEN" -X GET \
"https://$HOST:8443/api/v3/oneprovider/attributes/MySpace1/File2.txt?extended=true&attribute=license"

[
  { 
    "name": "license",
    "value": "CC-0" 
  }
]
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**path**  <br>*required*|File path (e.g. '/My Private Space/testfiles/file1.txt')|string|--|
|**Query**|**attribute**  <br>*optional*|Type of attribute to query for.|enum (mode)|--|
|**Query**|**extended**  <br>*optional*|Whether we want to access extended attributes or regular.|boolean|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|Returns the requested file attributes.|< [FileAttribute](../definitions/FileAttribute.md#fileattribute) > array|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|[Error](../definitions/Error.md#error)|
|**404**|File not found.|[Error](../definitions/Error.md#error)|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


##### Produces

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/attributes/string"
```


###### Request query
```
json :
{
  "attribute" : "string",
  "extended" : true
}
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



