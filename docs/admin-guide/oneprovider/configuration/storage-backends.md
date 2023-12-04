# Storage backends

[toc][1]

## Configuration

Onepanel GUI allows creating, editing and deleting storage backends under the *Storage backends* menu.
All storage backend configuration options are available during storage backend creation
(see below picture and descriptions).
After the storage backend is created, only some of the parameters can be changed so as not to break the data integrity.

![screen-storage-config][]

### Storage backend type

Determines the type of corresponding storage backend.

The currently supported storage backends include:

* `POSIX` — any POSIX compatible storage backend, typically attached over high-throughput local network, such as NFS.
* `S3` — [Amazon S3][] compatible storage.
* `Ceph RADOS` — storage backend compatible with [Ceph][] object storage.
* `Swift` — storage backend compatible with [OpenStack SWIFT][] protocol.
* `GlusterFS` — [GlusterFS][] volume directly attached to the provider.
* `WebDAV` — storage backend compatible with [WebDAV][] protocol.
* `XRootD` — storage backend compatible with [XRootD][] protocol.
* `HTTP` — any [HTTP][] or HTTPS compatible server.
  Supported only with [`Readonly`][] option enabled and in [manual import mode][].
* `Null device` — POSIX compatible storage which emulates behavior of `/dev/null` on local filesystem.
  Allows running various performance tests, which are not impacted by actual storage latency.
  [`Skip storage detection`][] option is obligatory for this type of storage backend.

Please consult the [Add storage REST request][]
for comprehensive description of type-specific configuration parameters. The parameters are visible after selecting
the specific type of storage backend from the dropdown in the request body specification.

### Storage backend name

A unique name for the storage resource.

### Storage path type

Determines how the logical file paths are mapped on the storage backend:

* `canonical` paths reflect the logical file names and directory structure, however each rename operation
  requires renaming the files on the storage backend which may result in copying the file blocks on some storage backends.
  Canonical path type is obligatory for *[imported storages][]*.
* `flat` paths are based on unique file UUID's and do not require on-storage rename when logical file name is changed.

### Imported storage

Option `Imported storage` determines if the contents of this storage backend should be imported to the Onedata space supported
with the storage backend. This option should be enabled in two setups:

* There is a legacy dataset located on the storage backend, which should be imported into a space.
* The data on storage backend is to be modified directly by third party applications, bypassing
  the provider interfaces, and the changes should be reflected in the supported space.

> **NOTE**: Storage backend that is marked as an *imported storage* can be used to support just one space.

> **NOTE**: Only one out of supporting providers can support the space with an *imported storage*.

Supporting the space with an *imported storage* results in enabling the *storage import*, which allows
registering storage files in the space without copying any data. More information can be found [here][storage import].

Please make sure that the storage backend for which you intend to enable `Imported storage` option is supported.
Consult the list of supported backends and the required configuration for
[*manual*][manual import]
and [*auto*][auto import] *import modes*.

### Readonly

Option `Readonly` determines that the storage is to be treated by the Oneprovider as readonly.
In such case, Oneprovider does not attempt to create, modify or delete files on the storage backend.
File blocks cannot be replicated onto the storage backend from other providers.
For above reasons, *[storage import][]* is effectively the only way to use such storage backend within a space — in consequence
the `Readonly` option is available only for an *\[imported storage]\[]*.
The imported data will be available in readonly mode, unless replicated to other providers.

This option can be chosen even if the provider has write access to the storage backend, but the admin decides that it
should be perceived as readonly. However, if the storage backend is indeed readonly (prevents making any changes),
`Readonly` **must** be enabled for correct operation of the Oneprovider service.

If you wish to use [Oneclient in direct-io mode][direct-io mode]  on
a readonly storage, you should also enable [`Skip storage detection`][] option to turn off
automatic detection of direct access to the storage backend in the Oneclient application. Remember that in such case,
`--force-direct-io` option has to be passed to Oneclient application to enable `direct-io` mode.
Additionally, on POSIX compatible storage backends mount point must be passed manually.
Please see Oneclient's documentation for [`--force-direct-io`][direct-io mode]
and [`--override`][] options.

### Skip storage detection

`Skip storage detection` option turns off automatic detection of direct access to the storage backend
in all instances of Oneclient application.
It also disables checks performed by Oneprovider when storage is added or modified. This option is relevant
only for storage backends that are **not** marked as `readonly` — for readonly storages, it is implicitly set to `true`.

### LUMA feed

Option `LUMA feed` determines type of feed for [Local User Mapping Database][].
There are 3 possible values:

* `auto`
* `local`
* `external`

For more information on configuration of LUMA DB feed, see [here][luma configuration].

### Timeout

Storage operation timeout in milliseconds. This parameter is optional, the default is 120 seconds.

### QoS Parameters

Quality of Service parameters - refer to the [QoS documentation][]. 

## REST API

All operations on storage resources can be performed using the REST API.
Refer to the linked API documentation for detailed information and examples.

| Request                | Link to API                     |
| ---------------------- | ------------------------------- |
| Create storage         | [API][Add storage REST request] |
| Get storage details    | [API][get storage details]      |
| Update storage         | [API][modify storage]           |
| Remove storage         | [API][remove storage]           |
| List storage resources | [API][get storage]              |

<!-- references -->

[1]: <>

[Amazon S3]: http://docs.aws.amazon.com/AmazonS3/latest/API/Welcome.html

[Ceph]: http://ceph.com/ceph-storage/

[OpenStack SWIFT]: http://docs.openstack.org/developer/swift/

[GlusterFS]: https://www.gluster.org/

[WebDAV]: https://tools.ietf.org/html/rfc4918

[XRootD]: http://www.xrootd.org/

[HTTP]: https://tools.ietf.org/html/rfc7231

[`Readonly`]: #readonly

[manual import mode]: storage-import.md#manual-storage-import

[`Skip storage detection`]: #skip-storage-detection

[Add storage REST request]: https://onedata.org/#/home/api/stable/onepanel?anchor=operation/add_storage

[imported storages]: #imported-storage

[storage import]: storage-import.md

[manual import]: storage-import.md#storage-configuration-for-manual-import

[auto import]: storage-import.md#storage-configuration-for-auto-import

[direct-io mode]: ../../../user-guide/oneclient.md#direct-io-and-proxy-io-modes

[`--override`]: ../../../user-guide/oneclient.md#overriding-storage-helper-parameters

[Local User Mapping Database]: luma.md

[luma configuration]: luma.md#configuration

[get storage details]: https://onedata.org/#/home/api/stable/onepanel?anchor=operation/get_storage_details

[modify storage]: https://onedata.org/#/home/api/stable/onepanel?anchor=operation/modify_storage

[remove storage]: https://onedata.org/#/home/api/stable/onepanel?anchor=operation/remove_storage

[get storage]: https://onedata.org/#/home/api/stable/onepanel?anchor=operation/get_storages

[screen-storage-config]: ../../../../images/admin-guide/oneprovider/configuration/storages/storage-config.png

[QoS documentation]: qos.md#qos-parameters