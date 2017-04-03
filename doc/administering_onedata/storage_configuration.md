# Storage Configuration

<!-- toc -->

Onedata supports several storage backends which can be used by storage providers to support users spaces.

The currently supported storage backends include:
* **posix** - any POSIX based storage, typically attached over high-throughput local network, such as Lustre,
* **s3** - [Amazon S3](http://docs.aws.amazon.com/AmazonS3/latest/API/Welcome.html) compatible storage,
* **ceph** - storage backend allowing to support user spaces on storage resources managed by [Ceph](http://ceph.com/ceph-storage/) object storage,
* **swift** - storage backend compatible with [OpenStack SWIFT](http://docs.openstack.org/developer/swift/) protocol.

The sections below describe how to attach each of these storage types to a Onedata deployment on a local site. Storage can be attached using Oneprovider REST API, by updating the configuration. Example YAML configuration with multiple storage backends is presented below:

```yaml
    cluster:
      domain_name: "oneprovider.onedata.example.com"
      nodes:
        n1:
          hostname: "node1"
      manager:
        default_node: "n1"
        nodes:
          - "n1"
      worker:
        nodes:
          - "n1"
      database:
        serverQuota: 20972
        bucketQuota: 10486
        nodes:
          - "n1"
      storage:
        NFS:
          type: "posix"
          mountPoint: "/volumes/storage"
        my_s3_storage:
          type: "s3"
          hostname: s3.example.com
          bucketName: bucket1.iam.example.com
          accessKey: LKJHLAKJSHD887678678ASDKNJKASD9898789ASD
          secretKey: ASASDLLASD89798&LKJHLAKJSHD887678678ASDKNJK
          insecure: true
        ceph:
          type: "ceph"
          username: user1
          key: LKJASHD6876ASDBJHV65765ASD
          monitorHostname: test.example.com
          clusterName: CephCluster1
          poolName: Pool1
        swift:
          type: "swift"
          authUrl: https://keystone.example.com/v2.0/tokens
          tenantName: Tenant1
          containerName: Container1
          username: alice
          password: secret
    oneprovider:
      register: true
      name: Provider1
      redirectionPoint: "https://node1.oneprovider.onedata.example.com"
      geoLatitude: 50.068968
      geoLongitude: 19.909444
    onezone:
      domainName: onedata.example.com
```


## POSIX

POSIX attributes necessary for configuration are:

|  Attribute | Type | Description |
|------------|------|-------------|
| type       | **string** | Must be equal to POSIX |
| mountPoint | **string** | The local path at which Oneprovider worker threads can access this storage |
| timeout    | **string** | **(Optional)** Storage operation timeout in milliseconds |
| readonly   | **string** | **(Optional)** Defines whether storage is readonly |

Please note that Oneprovider will not automatically mount or unmount this storage from the nodes, this must be ensured by administrators.

## S3

S3 attributes necessary for configuration are:

|  Attribute | Type | Description |
|------------|------|-------------|
| type       | **string** | Must be equal to S3 |
| hostname | **string** | The name of the host exposing the S3 REST API |
| bucketName | **string** | The name of S3 bucket which will be used as the storage resource |
| accessKey | **string** | The access key for the S3 storage |
| secretKey | **string** | The secret key for the S3 storage |
| timeout | **string** | **(Optional)** Storage operation timeout in milliseconds |
| blockSize | **string** | **(Optional)** Storage block size in bytes |
| insecure | **string** | **(Optional)** Defines whether storage administrator credentials (accessKey and secretKey) may be used by users without storage accounts to access storage in direct IO mode. |
| readonly   | **string** | **(Optional)** Defines whether storage is readonly |



All the above fields are mandatory.

## Ceph

Ceph required attributes are:


|  Attribute | Type | Description |
|------------|------|-------------|
| type       | **string** | Must be equal to Ceph |
| username | **string** | The username on behalf of which the Ceph storage will be accessed |
| key | **string** | The key for the selected username |
| monitorHostname | **string** | The host where the Ceph monitoring deamon `ceph-mon` is running |
| clusterName | **string** | The name of the Ceph cluster |
| poolName | **string** | The Ceph pool name |
| timeout    | **string** | **(Optional)** Storage operation timeout in milliseconds |
| insecure | **string** | **(Optional)** Defines whether storage administrator credentials (accessKey and secretKey) may be used by users without storage accounts to access storage in direct IO mode. |
| readonly | **string** | **(Optional)** Defines whether storage is readonly |

More information about these attributes can be found in the official Ceph [documentation](http://docs.ceph.com/docs/hammer/rados/configuration/ceph-conf/).


## OpenStack Swift

Swift required attributes are:

|  Attribute | Type | Description |
|------------|------|-------------|
| type       | **string** | Must be equal to Swift |
| authUrl       | **string** | The URL to OpenStack Keystone identity service |
| tenantName | **string** | The name of the tenant to which the user belongs |
| containerName | **string** | The name of the Swift storage container |
| username | **string** | The Keystone authentication username |
| password | **string** | The Keystone authentication password |
| blockSize | **string** | **(Optional)** Storage block size in bytes |
| insecure | **string** | **(Optional)** Defines whether storage administrator credentials (accessKey and secretKey) may be used by users without storage accounts to access storage in direct IO mode. |
| readonly | **string** | **(Optional)** Defines whether storage is readonly |

More information about these attributes can be found in the official OpenStack Swift [documentation](http://docs.openstack.org/developer/swift/).
