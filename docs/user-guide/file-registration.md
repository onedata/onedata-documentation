# File registration
<!-- This header is referenced at least one time as "#file-registration" -->

File registration is dedicated for reflecting external datasets in a Onedata space.
It is available only for a storage system that supports the space and is configured
as an [`Imported storage`](../admin-guide/oneprovider/configuration/storages.md#imported-storage)
with [manual import mode](../admin-guide/oneprovider/configuration/storage-import.md#manual-storage-import)
(as opposed to [auto import mode](../admin-guide/oneprovider/configuration/storage-import.md#auto-storage-import), where the registration is done automatically).

## Registration API
Currently, the only way to register files in a space is to use the 
[REST API](https://onedata.org/#/home/api/stable/oneprovider?anchor=tag/File-registration).
Space users can choose a file within the dataset that is to be accessible via Onedata and invoke 
the registration in a Oneprovider supporting the space. The file will become visible immediately.
No data is copied in the process - merely a file metadata entry is created in the space with a reference 
to the external storage, which will be contacted by the Oneprovider whenever the file is accessed.

> **NOTE**: Registration of directories is not supported.