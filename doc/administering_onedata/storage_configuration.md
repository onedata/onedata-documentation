# Storage Configuration

Onedata supports several storage backends which can be used by storage providers to support users spaces. 

The currently supported storage backends include:
* **POSIX** - any POSIX based storage, typically attached over high-throughput local network, such as Lustre,
* **S3** - [Amazon S3](http://docs.aws.amazon.com/AmazonS3/latest/API/Welcome.html) compatible storage,
* **Ceph** - storage backend allowing to support user spaces on storage resources managed by [Ceph](http://ceph.com/ceph-storage/) object storage,
<!-- * **SWIFT** - storage backend compatible with [OpenStack SWIFT](http://docs.openstack.org/developer/swift/) protocol. -->

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
          * "n1"
      worker:
        nodes:
          * "n1"
      database:
        nodes:
          * "n1"
      storage:
        NFS:
          type: "POSIX"
          mount_point: "/volumes/storage"
        my_s3_storage:
          type: "S3"
          S3Hostname: s3.example.com
          IAMHostname: iam.example.com
          bucketName: bucket1.iam.example.com
          accessKey: LKJHLAKJSHD887678678ASDKNJKASD9898789ASD
          secretKey: ASASDLLASD89798&LKJHLAKJSHD887678678ASDKNJK
        ceph:
          type: Ceph
          username: user1
          key: LKJASHD6876ASDBJHV65765ASD
          monitorHostname: test.example.com
          clusterName: CephCluster1
    oneprovider:
      register: true
      name: "example"
      redirection_point: "https://node1.oneprovider.onedata.example.com"
      geo_latitude: 50.068968
      geo_longitude: 19.909444
    onezone:
      domain_name: "onedata.example.com"
```


## POSIX

POSIX attributes necessary for configuration are:

|  Attribute | Type | Description |
|------------|------|-------------|
| type       | **string** | Must be equal to POSIX |
| mount_point | **string** | The local path at which Oneprovider worker threads can access this storage |

Please note that Oneprovider will not automatically mount or unmount this storage from the nodes, this must be ensured by administrators.

## S3

S3 attributes necessary for configuration are:

|  Attribute | Type | Description |
|------------|------|-------------|
| type       | **string** | Must be equal to S3 |
| s3Hostname | **string** | The name of the host exposing the S3 REST API |
| IAMHostname | **string** | The name of the host where the Amazon IAM authentication service is deployed |
| bucketName | **string** | The name of S3 bucket which will be used as the storage resource |
| accessKey | **string** | The access key for the S3 storage |
| secretKey | **string** | The secret key for the S3 storage |

All the above fields are mandatory.

## Ceph

Ceph required attributes are:


|  Attribute | Type | Description |
|------------|------|-------------|
| type       | **string** | Must be equal to Ceph |
| name | **string** | The name of the Ceph storage |
| username | **string** | The username on behalf of which the Ceph storage will be accessed |
| key | **string** | The key for the selected username |
| monitorHostname | **string** | The host where the Ceph monitoring deamon `ceph-mon` is running |
| clusterName | **string** | The name of the Ceph cluster |

More information about these attributes can be found in the official Ceph [documentation](http://docs.ceph.com/docs/hammer/rados/configuration/ceph-conf/).


