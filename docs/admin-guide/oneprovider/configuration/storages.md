# Storages
<!-- This file is referenced at least one time as "storages.md" TODO VFS-7452 -->

[toc][]

## Configuration

Onepanel GUI allows creating, editing and deleting storages under the *Storages* menu. 
All storage configuration options are available during storage creation (see below picture and descriptions). 
After the storage is created, only some of the parameters can be changed so as not to break the data integrity.

![Configuration of storage](../../../../images/admin-guide/oneprovider/configuration/storages/storage_config.png#screenshot)

### Storage type
Determines the type of corresponding storage backend.

The currently supported storage backends include:
* `POSIX` – any POSIX compatible storage, typically attached over high-throughput local network, such as NFS.
* `S3` – [Amazon S3](http://docs.aws.amazon.com/AmazonS3/latest/API/Welcome.html) compatible storage.
* `Ceph RADOS` – storage backend compatible with [Ceph](http://ceph.com/ceph-storage/) object storage.
* `Swift` – storage backend compatible with [OpenStack SWIFT](http://docs.openstack.org/developer/swift/) protocol.
* `GlusterFS` – [GlusterFS](https://www.gluster.org/) volume directly attached to the Oneprovider.
* `Local Ceph` – local Ceph cluster that has been deployed during deployment of Oneprovider. For more information
on local Ceph deployment please see [here](ceph.md).
* `WebDAV` – storage backend compatible with [WebDAV](https://tools.ietf.org/html/rfc4918) protocol.
* `XRootD` – storage backend compatible with [XRootD](http://www.xrootd.org/) protocol.
* `HTTP` – any [HTTP](https://tools.ietf.org/html/rfc7231) or HTTPS compatible server. 
Supported only with [`Readonly`](#readonly) option enabled and in [manual import mode](storage-import.md#manual-storage-import).
* `Null device` – POSIX compatible storage which emulates behavior of `/dev/null` on local filesystem. 
Allows running various performance tests, which are not impacted by actual storage latency. 
[`Skip storage detection`](#skip-storage-detection) option is obligatory for this type of storage.

Please consult the [Add storage REST request](https://onedata.org/#/home/api/stable/onepanel?anchor=operation/add_storage)
for comprehensive description of type-specific configuration parameters. The parameters are visible after selecting
the specific type of storage from the dropdown in the request body specification.

### Storage name
A unique name for the storage resource.

### Storage path type 
Determines how the logical file paths are mapped on the storage:
 * `canonical` paths reflect the logical file names and directory structure, however each rename operation 
 requires renaming the files on the storage which may result in copying the file blocks on some storage backends.
 Canonical path type is obligatory for [*imported storages*](#imported-storage).
 * `flat` paths are based on unique file UUID's and do not require on-storage rename when logical file name is changed.


### Imported storage
<!-- This file is referenced at least one time as "#imported-storage" TODO VFS-7452 -->

Option `Imported storage` determines if the contents of this storage should be imported to the Onedata space supported
with the storage. This option should be enabled in two setups: 
* There is a legacy dataset located on the storage, which should be imported into a space.
* The data on storage is to be modified directly by third party applications, bypassing 
  the Oneprovider interfaces, and the changes should be reflected in the supported space.
  
> **NOTE**: Storage that is marked as an *imported storage* can be used to support just one space.

> **NOTE**: Only one out of supporting providers can support the space with an *imported storage*.

Supporting the space with an *imported storage* results in enabling the *storage import*, which allows 
registering storage files in the space without copying any data. More information can be found [here](storage-import.md).

Please make sure that the storage backend for which you intend to enable `Imported storage` option is supported.
Consult the list of supported backends and the required configuration for 
[*manual*](storage-import.md#storage-configuration-for-manual-import) 
and [*auto*](storage-import.md#storage-configuration-for-auto-import) *import modes*.

### Readonly
Option `Readonly` determines that the storage is to be treated by the Oneprovider as readonly.
In such case, Oneprovider does not attempt to create, modify or delete files on the storage.
File blocks cannot be replicated onto the storage from other providers.
For above reasons, [*storage import*](storage-import.md) is effectively the only way to use such storage within a space – in consequence 
the `Readonly` option is available only for an [*imported storage*](#imported-storage).
The imported data will be available in readonly mode, unless replicated to other providers. 

This option can be chosen even if the provider has write access to the storage, but the admin decides that it
should be perceived as readonly. However, if the storage is indeed readonly (prevents making any changes),
`Readonly` **must** be enabled for correct operation of the Oneprovider service.

If you wish to use [Oneclient in direct-io mode](../../../user-guide/oneclient.md#direct-io-and-proxy-io-modes)  on
a readonly storage, you should also enable [`Skip storage detection`](#skip-storage-detection) option to turn off
automatic detection of direct access to the storage in the Oneclient application. Please remember that in such case,
 `--force-direct-io` option has to be passed to Oneclient application to enable `direct-io` mode. 
Additionally, on POSIX compatible storages mountpoint must be passed manually.
Please see Oneclient's documentation for [`--force-direct-io`](../../../user-guide/oneclient.md#direct-io-and-proxy-io-modes) 
and [`--override`](../../../user-guide/oneclient.md#overriding-storage-helper-parameters) options.


### Skip storage detection 
`Skip storage detection` option turns off automatic detection of direct access to the storage in all instances of Oneclient application.
It also disables checks performed by Oneprovider when storage is added or modified. This option is relevant
only for storages that are **not** marked as `readonly` – for readonly storages, it is implicitly set to `true`.


### LUMA feed
Option `LUMA feed` determines type of feed for [Local User Mapping Database](luma.md).
There are 3 possible values:
 * `auto`
 * `local`
 * `external`

For more information on configuration of LUMA DB feed please see [here](luma.md#configuration).

### Timeout
Storage operation timeout in milliseconds. This parameter is optional, the default is 120 seconds.

### QoS Parameters
<!-- TODO VFS-6815: After dividing the chapter, update below link to point to
     the QoS parameters in the admin chapter.
 -->
Quality of service parameters. 
For more information on configuration of *Quality of Service* mechanism please see [here](quality-of-service.md#qos-params).
 

## REST API

All operations on storage resources can be performed using the REST API.
Please refer to the linked API documentation for detailed information and examples.
 
| Request                      | Link to API |
|------------------------------|-------------|
| Create storage               | [API](https://onedata.org/#/home/api/stable/onepanel?anchor=operation/add_storage)|        
| Get storage details          | [API](https://onedata.org/#/home/api/stable/onepanel?anchor=operation/get_storage_details)|        
| Update storage               | [API](https://onedata.org/#/home/api/stable/onepanel?anchor=operation/modify_storage)|             
| Remove storage               | [API](https://onedata.org/#/home/api/stable/onepanel?anchor=operation/remove_storage)|             
| List storage resources       | [API](https://onedata.org/#/home/api/stable/onepanel?anchor=operation/get_storages)|