# Storage backends

## 🚧 Under construction! 🚧

This section is still a work-in-progress and may have errors or missing information.

[toc][1]

## Configuration

Onepanel GUI allows creating, editing and deleting storage backends under the **Storage
backends** menu. All storage configuration options are available during storage creation
(see below picture and descriptions). After the storage is created, only some parameters
can be changed so as not to break the data integrity.

![screen-storage-config][]

### Storage type

Determines the type of corresponding storage backend.

The currently supported storage backends include:

* `POSIX` — any POSIX-compatible storage, typically attached over high-throughput local network, such as NFS.
* `S3` — [Amazon S3][3] compatible storage.
* `Ceph RADOS` — storage backend compatible with [Ceph][4] object storage.
* `Swift` — storage backend compatible with [OpenStack SWIFT][5] protocol.
* `GlusterFS` — [GlusterFS][6] volume directly attached to the provider.
* `WebDAV` — storage backend compatible with [WebDAV][7] protocol.
* `XRootD` — storage backend compatible with [XRootD][8] protocol.
* `HTTP` — any [HTTP][9] or HTTPS compatible server.
  Supported only with [`Readonly`][10] option enabled and in [manual import mode][11].
* `Null device` — POSIX-compatible storage which emulates behavior of `/dev/null` on local filesystem.
  Allows running various performance tests, which are not impacted by actual storage latency.

Please consult the [Add storage REST request][13]
for comprehensive description of type-specific configuration parameters. The parameters are visible after selecting
the specific type of storage from the dropdown in the request body specification.

### Storage name

A unique name for the storage resource.

### Storage path type

Determines how the logical file paths are mapped on the storage:

* `canonical` paths reflect the logical file names and directory structure, however each rename operation
  requires renaming the files on the storage which may result in copying the file blocks on some storage backends.
  Canonical path type is obligatory for an [imported storage][14].
* `flat` paths are based on unique file UUID's and do not require on-storage rename when logical file name is changed.

### Imported storage

Option `Imported storage` determines if the contents of this storage should be imported to the Onedata space supported
with the storage. This option should be enabled in two setups:

* There is a legacy dataset located on the storage, which should be imported into a space.
* The data on storage is to be modified directly by third party applications, bypassing
  the provider interfaces, and the changes should be reflected in the supported space.

> **NOTE**: Storage that is marked as an *imported storage* can be used to support just one space.

> **NOTE**: Only one out of supporting providers can support the space with an *imported storage*.

Supporting the space with an *imported storage* results in enabling the *storage import*, which allows
registering storage files in the space without copying any data. More information can be found [here][15].

Please make sure that the storage backend for which you intend to enable `Imported storage` option is supported.
Consult the list of supported backends and the required configuration for
[manual][16]
and [auto][17] *import modes*.

### Read-only

Option `Readonly` determines that the storage is to be treated by the Oneprovider as
read-only. In such case, Oneprovider does not attempt to create, modify or delete files on
the storage. File blocks cannot be replicated onto the storage from other providers. For
above reasons, [storage import][15] is effectively the only way to use such storage
within a space — in consequence the `Readonly` option is available only for an [imported
storage][14]. The imported data will be available in read-only mode, unless replicated to
other providers.

This option can be chosen even if the provider has write access to the storage, but the
admin decides that it should be perceived as read-only. However, if the storage is indeed
read-only (prevents making any changes), `Readonly` **must** be enabled for correct
operation of the Oneprovider service.

If you wish to use [Oneclient in Direct I/O mode][18] on a read-only storage, remember to
pass the `--force-direct-io` option to the Oneclient application. Additionally, on
**POSIX-compatible storage backends**, the mount-point must be **passed manually**.
Consult Oneclient's documentation for [`--force-direct-io`][18] and [`--override`][19]
options.

### LUMA feed

Option `LUMA feed` determines type of feed for [Local User Mapping Database][20].
There are 3 possible values:

* `auto`
* `local`
* `external`

For more information on configuration of LUMA DB feed, see [here][21].

### Timeout

Timeout for storage operations in milliseconds. This parameter is optional, the default is
120 seconds.

### QoS Parameters

<!-- TODO VFS-6815: After dividing the chapter, update below link to point to
     the QoS parameters in the admin chapter.
 -->

Quality of service parameters.
For more information on configuration of *Quality of Service* mechanism, see [here][22].

## Verification and monitoring

When adding a new storage backend or modifying an existing one, Oneprovider performs
read/write tests in order to determine whether the provided configuration is valid and the
storage backend can be accessed. Write tests are skipped for read-only storage backends.

Additionally, storage health checks are performed periodically. Upon failure, the access
to all spaces supported by the storage backend is blocked until it becomes accessible
again.

## REST API

All operations on storage resources can be performed using the REST API.
Refer to the linked API documentation for detailed information and examples.

| Request                | Link to API |
| ---------------------- | ----------- |
| Create storage         | [API][13]   |
| Get storage details    | [API][23]   |
| Update storage         | [API][24]   |
| Remove storage         | [API][25]   |
| List storage resources | [API][26]   |

<!-- references -->

[1]: <>

[3]: http://docs.aws.amazon.com/AmazonS3/latest/API/Welcome.html

[4]: http://ceph.com/ceph-storage/

[5]: http://docs.openstack.org/developer/swift/

[6]: https://www.gluster.org/

[7]: https://tools.ietf.org/html/rfc4918

[8]: http://www.xrootd.org/

[9]: https://tools.ietf.org/html/rfc7231

[10]: #read-only

[11]: storage-import.md#manual-storage-import

[13]: https://onedata.org/#/home/api/stable/onepanel?anchor=operation/add_storage

[14]: #imported-storage

[15]: storage-import.md

[16]: storage-import.md#storage-configuration-for-manual-import

[17]: storage-import.md#storage-configuration-for-auto-import

[18]: ../../../user-guide/oneclient.md#direct-io-and-proxy-io-modes

[19]: ../../../user-guide/oneclient.md#overriding-storage-helper-parameters

[20]: luma.md

[21]: luma.md#configuration

[22]: qos.md#qos-parameters

[23]: https://onedata.org/#/home/api/stable/onepanel?anchor=operation/get_storage_details

[24]: https://onedata.org/#/home/api/stable/onepanel?anchor=operation/modify_storage

[25]: https://onedata.org/#/home/api/stable/onepanel?anchor=operation/remove_storage

[26]: https://onedata.org/#/home/api/stable/onepanel?anchor=operation/get_storages

[screen-storage-config]: ../../../../images/admin-guide/oneprovider/configuration/storages/storage-config.png
