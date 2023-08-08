# Storage import

*Storage import* is dedicated for importing files located on a storage by registering them in the space supported by
the storage. The file registration process **does not copy any data**, it simply creates the necessary metadata so that
the files pre-existing on the storage are reflected and accessible in the supported space. It is possible to configure
the storage to detect consecutive changes made directly on the storage after the initial import (during the space
lifecycle) — using the continuous scan option, by manually triggering scans or by re-registering files.

This functionality should be used in two setups:

* There is a legacy dataset located on the storage, which should be imported into a space.
* The data on storage is to be modified directly by third party applications, bypassing
  the provider interfaces, and the changes should be reflected in the supported space.

> **NOTE**: In other setups, it is **not recommended** to enable *storage import*, as it will introduce unnecessary
> overheads. Essentially, the regular storage setup in Onedata assumes that the supporting storage is initially empty
> and dedicated exclusively for being accessed by the Oneprovider software. This should be the preferred setup, except
> for the two above-mentioned cases.

*storage import* can be enabled only if the space is supported with an [*Imported storage*][1].

## Configuration

There are 2 possible modes of *storage import*: [*manual*][2] and [*auto*][3].
The mode is chosen when the space is being supported with an [*Imported storage*][1]
as presented in the below picture.

> **NOTE**: *storage import* mode cannot be changed during the space lifecycle.

![Supporting the space with an imported storage][4]

## Manual storage import

In case of *manual* mode, the files must be [registered manually][5] by the space users.
Registration of directories is not supported.

This option is preferred when only a part of the dataset is to be imported, but required if the storage backend does
not support [automatic import scans][3].

### Storage configuration for manual import:

*Manual storage import* is supported on the following storage backends:

* `POSIX`
* `GlusterFS`
* `Null device`
* `WebDAV`
* `XRootD`
* `HTTP`
* `S3`
* `Swift`
* `Ceph RADOS`

> **NOTE**: The storage must have [*canonical path type*][6].
> Moreover, on object storages: S3, SWIFT and CEPHRADOS the `Block size` parameter **must be set to `0`!**

## Auto storage import

In case of *auto* mode, the storage is automatically scanned and data is imported from storage into the
assigned space.

### Storage configuration for auto import:

*Auto storage import* is supported on the following storage backends:

* `POSIX`
* `GlusterFS`
* `Null device`
* `WebDAV`
* `XRootD`
* `S3`

> **NOTE**: The storage must have [*canonical path type*][6].
> Moreover, on S3 the `Block size` parameter **must be set to `0` !**

### Configuration

The configuration of *auto storage import* can be set when supporting the space, as presented in the
[previous picture][7]. It can also be modified later in the
`Spaces -> "Space Name" -> Storage import > Auto storage import configuration` tab, as presented below:

![Auto storage import configuration][8]

The available configuration options are:

* `Max depth` — Maximum depth of filesystem tree that will be traversed during the scan. By default it is 65535.
* `Synchronize ACL` — Enables import of NFSv4 ACLs. Note that this option requires proper [mappings in LUMA DB][9].
* `Detect modifications` — If disabled, the storage will be treated as immutable — changes of already imported files
  will not be detected. Relevant only if more than one scan is performed.
* `Detect deletions` — Flag determining that deletions of already imported files will be detected and reflected.
  Relevant only if more than one scan is performed.
* `Continuous scan` — Indicates if the data on the storage should be imported into the space periodically. Continuous
  import guarantees data integrity if direct modifications on the storage are to be made during the space lifecycle.
* `Scan interval` — Period between subsequent scans in seconds (counted from end of one scan till beginning of the following),
  relevant only if `Continuous scan` is enabled.

### Last scan summary

Below the configuration tab, there is information about current or last finished scan: its status, start & stop times
and the number all of processed files (`Processed files`) as well as the total number of files residing on the storage
during the scan (`Total storage files`).
`Processed files` is a sum of `Created files`, `Modified files`, `Unmodified files`, `Deleted files` and `Failed files`
counters, which are presented in the right column of the tab. `Failed files` is the number of files for which processing has failed.
`Total storage files` is a sum of `Created files`, `Modified files` and `Unmodified files` counters.
File counters include both directories and regular files.
If the `Continuous scan` is enabled, it also displays the estimated time of the next scan.

![Last scan summary][10]

### Starting a scan on demand

It is possible to forcefully start a single scan of *auto storage import*, even if `Continuous scan` is disabled
(use the green button). The scan will be started with current configuration.

![Starting a scan on demand][10]

> **NOTE:** A new scan can be started only if there is no scan in progress for the space.

### Stopping a scan on demand

It is also possible to forcefully stop the current scan of *auto storage import* (use the red button).

![Stopping a scan on demand][11]

> **NOTE:** Stopping the scan is asynchronous — may take some time and does not guarantee instant effect.

### Statistics

Progress of the *auto storage import* can be observed on three charts, as shown below.
It is possible to change the time resolution of the charts in the upper right corner of the charts view.

![Auto storage import statistics][12]

[1]: storages.md#imported-storage

[2]: #manual-storage-import

[3]: #auto-storage-import

[4]: ../../../../images/admin-guide/oneprovider/configuration/storage-import/storage_import_config.png#screenshot

[5]: ../../../user-guide/file-registration.md

[6]: storages.md#storage-path-type

[7]: #configuration

[8]: ../../../../images/admin-guide/oneprovider/configuration/storage-import/auto_storage_import_config.png#screenshot

[9]: luma.md#imported-storages

[10]: ../../../../images/admin-guide/oneprovider/configuration/storage-import/auto_storage_import_info.png#screenshot

[11]: ../../../../images/admin-guide/oneprovider/configuration/storage-import/auto_storage_import_stop.png#screenshot

[12]: ../../../../images/admin-guide/oneprovider/configuration/storage-import/auto_storage_import_stats.png#screenshot
