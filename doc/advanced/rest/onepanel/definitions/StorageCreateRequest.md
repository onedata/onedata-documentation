
<a name="storagecreaterequest"></a>
### StorageCreateRequest
The configuration details required to add storage resources.

*Type* : < string, [StorageDetails](StorageDetails.md#storagedetails) > map

**Example**
```
{
  "s3" : {
    "type" : "s3",
    "s3Hostname" : "s3.example.com",
    "iamHostname" : "iam.example.com",
    "bucketName" : "bucket1.iam.example.com",
    "accessKey" : "LKJHLAKJSHD887678678ASDKNJKASD9898789ASD",
    "secretKey" : "ASASDLLASD89798&LKJHLAKJSHD887678678ASDK"
  },
  "swift" : {
    "type" : "swift",
    "authUrl" : "http://keystone2.example.com",
    "tenantName" : "Project1",
    "containerName" : "Container1",
    "username" : "user",
    "password" : "p@$$w0rd"
  }
}
```



