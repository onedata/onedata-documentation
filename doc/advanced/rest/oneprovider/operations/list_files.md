
<a name="list_files"></a>
#### List files and folders
```
GET /files/{path}
```


##### Description
Returns the list of folders and files directly under specified path.

If the path points to a file, the result array will consist only of the single item with the path to the file requested, confirming it exists.

***Example cURL requests***

**Get files in space subfolder**
```bash
curl --tlsv1.2 -X GET -H "X-Auth-Token: $TOKEN" \
"https://$HOST:8443/api/v3/oneprovider/files/MySpace1/MyFolder2"

[
  { 
    "id": "c4798eb2-dbd2-486f-ae94-0e6fa0a5071d", 
    "path": "/MySpace1/MyFolder2/File1.txt"
  },
  { 
    "id": "620e1642-4f2d-45f2-b4eb-37f8a958b46f", 
    "path": "/MySpace1/MyFolder2/Folder3"
  },
  { 
    "id": "55ac4ed3-a723-47ab-a892-638578b9cad7", 
    "path": "/MySpace1/MyFolder2/File3.txt"
  }
]
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**path**  <br>*required*|Directory path (e.g. '/My Private Space/testfiles')|string|--|
|**Query**|**limit**  <br>*optional*|Allows to specify maximum number of files that should be returned. If there are more files, they can be retrieved using `offset` query parameter.|integer|--|
|**Query**|**offset**  <br>*optional*|Index of the partial result, can be used to get subset of the result,  when the number of files and folders under given path exceeds 1000.|integer|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The list of files and folders under specified path.|< [Response 200](#list_files-response-200) > array|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|[Error](../definitions/Error.md#error)|
|**404**|Invalid path - file or directory not found.|[Error](../definitions/Error.md#error)|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|

<a name="list_files-response-200"></a>
**Response 200**

|Name|Description|Schema|
|---|---|---|
|**id**  <br>*optional*|Id of the file or folder.|string|
|**path**  <br>*optional*|Path to the file or folder.|string|


##### Produces

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/files/string"
```


###### Request query
```
json :
{
  "limit" : 0,
  "offset" : 0
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



