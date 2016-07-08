
<a name="list_files"></a>
#### List files and folders
```
GET /files/{path}
```


##### Description
Returns the list of folders and files directly under specified path. If the path points to a file, the result array will consist only of the single item with the path to the file requested, confirming it exists.


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



