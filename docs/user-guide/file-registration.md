# File registration

File registration is used to reflect read-only, external datasets in a Onedata [space][].
Space users can register files by providing the location of a regular file on external
storage, along with optional attributes. Upon registration, the file becomes accessible in
the space under the requested path. No data is copied in the process; instead, a metadata
entry is created in the space, containing a reference to the external storage. The
Oneprovider will contact the external [storage backend][] whenever the file is accessed.

The typical use case for file registration is exposing publicly available data
lying on an HTTP server via a Onedata [space][], by providing URLs to the files
during registration.

::: tip NOTE
Registration of directories is not supported.
:::

File registration is available **only for** storage backends that support the
space and that are configured as [imported storage][] with [manual import
mode][] (as opposed to [auto import mode][], where the registration is done
automatically).

## Registration API

Currently, the [REST API][] is the only way to register files in a space. Space
users can choose a file within the dataset that they want to make accessible via
Onedata and invoke the registration on an Oneprovider that supports the space.
The file will become visible immediately.

<!-- references -->

[space]: spaces.md

[storage backend]: spaces.md#storage-backends

[imported storage]: ../admin-guide/oneprovider/configuration/storage-backends.md#imported-storage

[manual import mode]: ../admin-guide/oneprovider/configuration/storage-import.md#manual-storage-import

[auto import mode]: ../admin-guide/oneprovider/configuration/storage-import.md#auto-storage-import

[REST API]: https://onedata.org/#/home/api/stable/oneprovider?anchor=tag/File-registration
