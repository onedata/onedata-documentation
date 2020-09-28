# File registration
<!-- This header is referenced at least one time as "#file-registration" -->

`File registration` is dedicated for importing files located on a storage by registering them in the space supported by
the storage. The file registration process **does not copy any data**, it simply creates the necessary metadata so that
the files pre-existing on the storage are reflected and accessible in the supported space. 
It is possible to reflect changes made directly on the storage after the initial registration of files by re-registering them. 

The files must be registered manually by the space users with [REST API](https://onedata.org/#/home/api/stable/oneprovider?anchor=tag/File-registration). 
Registration of directories is not supported.

> **NOTE**: `File registration` is possible only if the space is supported with an
> [`Imported storage`](../administering_onedata/storage_configuration.md#imported-storage) and if
> the [manual mode of `Storage import`](../administering_onedata/storage_import.md) is enabled.
 
        