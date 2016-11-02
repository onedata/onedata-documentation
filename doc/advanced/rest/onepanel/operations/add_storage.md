
<a name="add_storage"></a>
#### Add storage.
```
POST /provider/storages
```


##### Description
Adds additional storage resource to the storage provider.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Body**|**clusterStoragesList**  <br>*required*|The list of configuration details of storages to be added to the provider deployment.|[ClusterStoragesList](../definitions/ClusterStoragesList.md#clusterstorageslist)|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|The storage has been successfully added to the provider deployment.|No Content|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**401**|Unauthorized request.|No Content|
|**403**|Forbidden request.|No Content|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


##### Consumes

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/provider/storages"
```


###### Request body
```
json :
{
  "s3" : {
    "type" : "S3",
    "s3Hostname" : "s3.example.com",
    "iamHostname" : "iam.example.com",
    "bucketName" : "bucket1.iam.example.com",
    "accessKey" : "LKJHLAKJSHD887678678ASDKNJKASD9898789ASD",
    "secretKey" : "ASASDLLASD89798&LKJHLAKJSHD887678678ASDK"
  },
  "swift" : {
    "type" : "SWIFT",
    "authUrl" : "http://keystone2.example.com",
    "tenantName" : "Project1",
    "containerName" : "Container1",
    "username" : "user",
    "password" : "p@$$w0rd"
  }
}
```


##### Example HTTP response

###### Response 400
```
json :
{
  "error" : "Invalid Request",
  "description" : "User role must be one of 'admin' or 'regular'."
}
```


###### Response 500
```
json :
{
  "error" : "Invalid Request",
  "description" : "User role must be one of 'admin' or 'regular'."
}
```



