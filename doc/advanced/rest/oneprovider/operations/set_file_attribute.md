
<a name="set_file_attribute"></a>
#### Set file attribute
```
PUT /attributes/{path}
```


##### Description
This method allows to set a value of a regular and extended file attributes.

For regular file attributes, currently only POSIX mode can be changed by sending:
  ```
  { name: "mode", value: "0777"}
  ```
where the POSIX mode is specified in octal notation.

For extended attributes any string value can be send. The exteded attributes are 
accessed by setting `extended` flag in the request query to `true`.

***Example cURL requests***

**Set file POSIX mode**
```bash
curl --tlsv1.2 -X PUT -H "X-Auth-Token: $TOKEN" \
-d '{ "name": "mode", "value": "0777" }'
"https://$HOST:8443/attributes/MySpace1/File2.txt"
```

**Set extended file attribute**
```bash
curl --tlsv1.2 -X PUT -H "X-Auth-Token: $TOKEN" \
-d '{ "name": "license", "value": "CC-0" }' \
"https://$HOST:8443/attributes/MySpace1/File2.txt?extended=true"
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**path**  <br>*required*|File path (e.g. '/My Private Space/testfiles/file1.txt')|string|--|
|**Query**|**extended**  <br>*optional*|Whether this is an extended or regular attribute. Default is false.|boolean|`"false"`|
|**Body**|**attribute**  <br>*optional*|Attribute name and value.|[FileAttribute](../definitions/FileAttribute.md#fileattribute)|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|File attributes where update successfuly.|No Content|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|[Error](../definitions/Error.md#error)|
|**404**|Oneprovider REST API not available.|[Error](../definitions/Error.md#error)|
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
  "extended" : true
}
```


###### Request body
```
json :
{
  "name" : "mode",
  "value" : "0444"
}
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



