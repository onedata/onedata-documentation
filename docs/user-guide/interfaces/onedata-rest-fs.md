# OnedataRestFS (Python)

[toc][]

## In a nutshell

`OnedataRESTFS` is a [PyFilesystem2][] plugin for Onedata distributed file system based on
[Onedata REST API][].

As a `PyFilesystem2` plugin implementation, `OnedataRESTFS` allows you to work with
Onedata in the same way as any other filesystem supported by `PyFilesystem2`.

Supported Onezone versions: `>= 21.02.5`.

Supported Oneprovider versions: `>= 21.02.5`.

## Installation

`OnedataRESTFS` library can be installed directly from [PyPi][], for example using `pip`:

```bash
pip install fs.onedatarestfs
```

::: tip NOTE
The package name `fs.onedatarestfs` is due to the convention of `PyFilesystem2` plugins.
:::

The source code is available on [GitHub][].

::: tip NOTE
As an alternative to this library, we also provide a Python wrapper library supporting
our binary data and metadata protocol — [OnedataFS][], which has better
performance, however requires installation of several C++ dependencies.
:::

## Usage

For reference documentation and usage examples see the [GitHub][] page.

<!-- references -->

[GitHub]: https://github.com/onedata/onedatarestfs

[PyPI]: https://pypi.org/project/fs.onedatarestfs

[PyFilesystem2]: https://pyfilesystem2.readthedocs.io/en/stable/info.html

[Onedata REST API]: https://onedata.org/#/home/api/stable/oneprovider

[OnedataFS]: ./onedata-fs.md
