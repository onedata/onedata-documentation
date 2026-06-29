# OnedataRESTFSSpec (Python)

[toc][]

## In a nutshell

`OnedataRESTFSSpec` is an [fsspec][] filesystem implementation for Onedata
on [Onedata REST API][].

As an fsspec implementation, `OnedataRESTFSSpec` allows you to work with
Onedata spaces using the same Python API as other filesystems supported by
fsspec.

The library supports reading and writing files, directory operations, file
metadata access, authentication using access tokens, environment-based and
URI-based configuration, and optional OpenTelemetry metrics export.

## Installation

`OnedataRESTFSSpec` library can be installed directly from [PyPI][], for example
using `pip`:

```bash
pip install onedatarestfsspec
```

Optional OpenTelemetry metrics support can be installed using:

```bash
pip install 'onedatarestfsspec[monitoring]'
```

Requirements include Python `>= 3.10`, `fsspec >= 2021.10.0`,
`onedatafilerestclient >= 25.0.0`, and `aiohttp`.

## Usage

For reference documentation and usage examples see the [GitHub][] page.

<!-- references -->

[toc]: <>

[GitHub]: https://github.com/onedata/onedatarestfsspec

[PyPI]: https://pypi.org/project/onedatarestfsspec

[fsspec]: https://filesystem-spec.readthedocs.io/en/latest/

[Onedata REST API]: https://onedata.org/#/home/api/stable/oneprovider
