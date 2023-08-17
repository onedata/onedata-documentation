# File registration

File registration is dedicated for reflecting external datasets in a Onedata space.
Space users can perform registration by providing the location of a file on an external
storage and optionally its attributes. Upon registration, the file becomes accessible
in the space under requested path. No data is copied in the process — merely a file
metadata entry is created in the space with a reference to the external storage,
which will be contacted by the Oneprovider whenever the file is accessed.

> **NOTE**: Registration of directories is not supported.

File registration is available only for storages that support the space and are configured
as [*Imported storage*][1]
with [*manual import mode*][2]
(as opposed to [*auto import mode*][3], where the registration is done automatically).

## Registration API

<!-- references -->

Currently, the only way to register files in a space is to use the
[REST API][4].
Space users can choose a file within the dataset that is to be accessible via Onedata and invoke
the registration in a Oneprovider supporting the space. The file will become visible immediately.

[1]: ../admin-guide/oneprovider/configuration/storages.md#imported-storage

[2]: ../admin-guide/oneprovider/configuration/storage-import.md#manual-storage-import

[3]: ../admin-guide/oneprovider/configuration/storage-import.md#auto-storage-import

[4]: https://onedata.org/#/home/api/stable/oneprovider?anchor=tag/File-registration
