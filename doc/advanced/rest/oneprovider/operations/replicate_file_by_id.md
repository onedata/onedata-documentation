
<a name="replicate_file_by_id"></a>
#### Replicate file or folder by ID
```
POST /replicas-id/{fid}
```


##### Description
Replicates a file with ID to a specified provider. This operation is asynchronous as it can  take a long time depending on the size of the data to move. 
If the `path` parameter specifies a folder, entire folder is replicated to  requested provider.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**fid**  <br>*required*|ID of the file.|string|--|
|**Query**|**provider_id**  <br>*optional*|The ID of the provider to which the file should be replicated. By default the file will be replicated to the provided handling this REST call.|string|--|
|**Body**|**callback**  <br>*optional*|This parameter allows the user to specify a REST callback URL, which will be called when the transfer is complete|[Callback](../definitions/Callback.md#callback)|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The replication request was accepted and the result is the transfer ID, which can be used for monitoring of the transfer status.|[Response 200](#replicate_file_by_id-response-200)|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|[Error](../definitions/Error.md#error)|
|**404**|Oneprovider REST API not available.|[Error](../definitions/Error.md#error)|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|

<a name="replicate_file_by_id-response-200"></a>
**Response 200**

|Name|Description|Schema|
|---|---|---|
|**transferId**  <br>*optional*|Transfer ID.|string|


##### Produces

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/replicas-id/string"
```


###### Request query
```
json :
{
  "provider_id" : "string"
}
```


###### Request body
```
json :
{
  "url" : "http://monitoring.example.com:8080/notifications"
}
```


##### Example HTTP response

###### Response 200
```
json :
"object"
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



