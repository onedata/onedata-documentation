
<a name="clusterstorageslist"></a>
### ClusterStoragesList
The list of supported storage types.

*Type* : < string, [ClusterStorages](ClusterStorages.md#clusterstorages) > map

**Example**
```
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



