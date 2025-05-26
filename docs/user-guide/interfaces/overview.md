# Overview

Onedata creates a virtual file system layer spanning geographically dispersed computing
centers and data providers that host heterogeneous storage resources. The virtual file
system is POSIX-compatible and based on a classic structure of directories and files. The
virtualized data can be accessed using multiple interfaces: Web GUI, REST API, CDMI API,
fuse-based POSIX mount, Python libraries, or S3. Regardless of the interface, the user
gets the same, unified view of all his data.

![image-onedata-fs-interfaces][]

Here is a summary of all available data access interfaces:

* [Web file browser][] — this rich graphical interface can be used for all data management
  tasks and is designed to be intuitive for non-computer-savvy users with basic needs,
  while offering advanced features for skilled personnel, such as data stewards,
  developers, or administrators. A good starting point if you are getting to know Onedata.

* [Oneclient][] (FUSE native mount) — allows mounting your Onedata Spaces in a Linux
  filesystem, so that the data can be accessed as if it resided in the local filesystem.
  Useful both in personal use-cases and computing environments (direct storage access).
  Requires an [access token][].

* [OnedataFS][] (Python) — offers an alternative to [Oneclient][]. As a [PyFilesystem][]
  plugin, allows you to work with Onedata in the same way as any other supported
  filesystem. Suitable for computing environments (direct storage access). Requires an
  [access token][].

* [OnedataRestFS][] (Python) — a lightweight cousin of [OnedataFS][], with identical
  functionality and suitable for proxied data access (accessing the data via a Oneprovider
  service), based on the [OnedataFileRestClient][] library. Requires an [access token][].

* [OnedataFileRestClient][] (Python) — a client to the Onedata file REST API,
  offering basic operations on files as a concise, low-level library.

* [REST API][] — a RESTful interface, documented in OpenAPI (a.k.a. Swagger), for
  integration with other services, creating middleware, and automating repetitive
  processes.

* [CDMI API][] (Cloud Data Management Interface) — an API based on the CDMI standard,
  which defines a universal, vendor-agnostic interface for discovering the capabilities of
  storage providers, managing Cloud storage, and accessing data stored within it.

* **S3 interface** — currently in beta, coming soon as a production-grade functionality in
  Onedata. Spaces are emulated as S3 Buckets and files are emulated as objects, allowing
  interaction with Onedata like with a regular S3 server.

* **Windows Sync & Share** — an early phase prototype of a client for the Windows
  platform. It provides integration with the Windows filesystem and file explorer to
  access the user data in Onedata. Make sure to let us know if you are interested!

<!-- references -->

[image-onedata-fs-interfaces]: ../../../images/user-guide/interfaces/overview/onedata-fs-interfaces.png

[Web file browser]: ./web-file-browser.md

[Oneclient]: ./oneclient.md

[OnedataFS]: ./onedata-fs.md

[OnedataRestFS]: ./onedata-rest-fs.md

[OnedataFileRestClient]: ./onedata-file-rest-client.md

[REST API]: ./data-access-rest-api.md

[CDMI API]: ./cdmi.md

[pyfilesystem]: https://www.pyfilesystem.org/

[access token]: ../tokens.md#access-tokens
