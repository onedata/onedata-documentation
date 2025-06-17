# OnedataFileRestClient (Python)

[toc][]

## In a nutshell

`OnedataFileRESTClient` is a Python client to the Onedata file REST API. It offers basic
operations on files as a concise, low-level library. Most users will probably be more
interested in [onedatarestfs](./onedata-rest-fs.md) library, which is a plugin for
[PyFilesystem], implemented using `OnedataFileRESTClient`, providing much more user
friendly interface.

Supported Onezone versions: `>= 21.02.5`

Supported Oneprovider versions: `>= 21.02.5`

> As an alternative to this library, we also provide a Python wrapper library supporting
our binary data and metadata protocol - [onedatafs](./onedata-fs.md), which has better
performance, however requires installation of several C++ dependencies.

## Installation

`OnedataFileRESTClient` library can be installed directly from [PyPi], for example:

```bash
pip install onedatafilerestclient
```

The source code is available on [GitHub].

## Usage

For reference documentation and usage examples see [GitHub] page.

<!-- references -->

[GitHub]: https://github.com/onedata/onedatafilerestclient

[PyPi]: https://pypi.org/project/onedatafilerestclient/

[PyFilesystem]: https://github.com/PyFilesystem/pyfilesystem2
