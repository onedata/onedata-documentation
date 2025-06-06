# OnedataRestFS (Python)

[toc][]

## In a nutshell

`OnedataRESTFS` is a PyFilesystem plugin for Onedata distributed file system based on
[Onedata REST API].

As a [PyFilesystem] plugin implementation, `OnedataRESTFS` allows you to work with
Onedata in the same way as any other filesystem supported by `PyFilesystem`.

Supported Onezone versions: `>= 21.02.5`

Supported Oneprovider versions: `>= 21.02.5`.

## Installation

`OnedataRESTFS` library can be installed directly from [PyPi], for example using `pip`:

```bash
pip install fs.onedatarestfs
```

> The package name `fs.onedatarestfs` is due to the convention of `PyFilesystem` plugins.

The source code is available on [GitHub].

## Usage

In order to use the `OnedataRESTFS` client using [PyFilesystem] API, it is necessary to
create an instance of `OnedataRESTFS` class with the minimum following arguments:

* `onezone_host` - hostname of Onezone instance
* `token` - access token obtained from Onezone to be used for subsequent requests

```python
from fs.onedatarestfs import OnedataRESTFS

onezone_host = 'onezone.example.com'
access_token = 'MDAzM2xvY2F00aW9uIGRldi1vbmV6b25lLmRlZmF1bHQuc3ZjLmNsdXN0...'
restfs = OnedataRESTFS(onezone_host, access_token)
print(restfs.listdir(''))
```

which should return the list of space names accessible through the specified
`access_token`.

Additional options that can be passed to the `OnedataRESTFS` client include:

* `space` - when specified, the PyFilesystem instance will be limited to a single
            space
* `preferred_oneproviders` - by default, `OnedataRESTFS` will choose Oneprovider instance to
                             connect to for each space automatically, however if a list of
                             Oneprovider hostnames is provided here, they will be used if
                             possible,
* `verify_ssl` - allows to disable SSL certificate verification (not for production use),
* `timeout` - maximum request timeout (default `30s`)

Further documentation and usage examples can be found in the documentation for
[PyFilesystem].

<!-- references -->

[GitHub]: https://github.com/onedata/onedatarestfs

[PyPI]: https://pypi.org/project/fs.onedatarestfs

[PyFilesystem]: https://pyfilesystem2.readthedocs.io/en/stable/info.html

[Onedata REST API]: https://onedata.org/#/home/api/stable/oneprovider
