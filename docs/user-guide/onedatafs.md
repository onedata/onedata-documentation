# OnedataFS

[toc][1]

OnedataFS is a Python library for accessing the Onedata virtual file system,
an alternative to [Oneclient][2] that offers a POSIX interface.
As a [PyFilesystem][3] plugin,
[OnedataFS][4] allows you to work with
Onedata in the same way as any other supported filesystem.

## Installation

OnedataFS can be installed from our provided packages for both Python 2 and Python 3.

### Ubuntu

```bash
$ curl -sSO https://get.onedata.org/oneclient.sh

# For Python2
$ pip install fs
$ sh oneclient.sh python-fs-plugin-onedatafs

# For Python3
$ pip3 install fs
$ sh oneclient.sh python3-fs-plugin-onedatafs
```

### CentOS

Please note that CentOS packages are distributed according to the
[Software Collections][5] standard.

```bash
$ curl -sSO https://get.onedata.org/oneclient.sh

# For Python3
$ pip3 install fs
$ sh oneclient.sh onedata2102-python3-fs-onedatafs
$ scl enable onedata2102 bash
```

### Anaconda

OnedataFS can be installed using
[Anaconda][6], from the official
[Onedata conda repository][7]:

> NOTE: Currently only Python 3 version (3.6, 3.7) are supported.

```bash
$ conda --experimental-solver=libmamba install -c onedata -c conda-forge fs.onedatafs
```

or to install a specific version of `fs.onedatafs`

```bash
$ conda --experimental-solver=libmamba install -c onedata -c conda-forge fs.onedatafs=20.02.5
```

Furthermore, to ensure that conda will not upgrade Python in a given environment,
it is possible to provide the exact build number of the OnedataFS packages, which
includes the Python version, e.g.:

```bash
$ conda --experimental-solver=libmamba install -c onedata -c conda-forge fs.onedatafs=20.02.5=py36_0
```

## Usage

To create an instance of OnedataFS connected to a specific Oneprovider, use the following code:

```python
from fs.onedatafs import OnedataFS
onedata_provider_host = "..."
onedata_access_token = "..."

# Create connection to the provider
odfs = OnedataFS(onedata_provider_host, onedata_access_token)

# Open selected space directory
space = odfs.opendir('/SpaceA')

# List SpaceA contents
space.listdir('/')
```

From then on, `space` can be used as any `PyFilesystem` instance. Refer
to the [PyFilesystem API documentation][8]
for all operations available on a filesystem object.

The complete list of options that can be provided to the OnedataFS constructor
can be found below (only `host` and `token` are required).

* `host` — provider hostname — follow the same guidelines as for [Oneclient][9]
* `token` — Onedata user access token — follow the same guidelines as for [Oneclient][10]
* `port` — provider port (defaults to 443)
* `space` — the list of space names which should be listed (defaults to all user spaces)
* `space_id` — the list of space IDs that should be listed (defaults to all user spaces)
* `insecure` — when `True`, allows connecting to providers without a valid SSL certificate
* `force_proxy_io` — when `True`, forces all data transfers to go via providers
* `force_direct_io` — when `True`, forces all data transfers to go directly via
  the target storage API. If storage is not available, for instance, due to
  network firewalls, an error will be returned for all `read` and `write`
  operations
* `no_buffer` — when `True`, disables all internal buffering in the OnedataFS
* `io_trace_log` — when `True`, the OnedataFS will log all requests in a CSV
  file in the directory specified by `log_dir`
* `provider_timeout` — specifies the timeout for waiting for provider responses, in seconds
* `metadata_cache_size` — the size of the cache for file and directory metadata
* `drop_dir_cache_after` — time in seconds after unused metadata entries are
  purged from the cache
* `log_dir` — path in the filesystem, where internal OnedataFS logs should be
  stored. When `None`, no logging will be generated
* `cli_args` — any other Oneclient command line arguments can be passed as a
  value of this argument as a single string, e.g. `'--storage-timeout=120 --storage-helper-thread-count=20`

Refer to the [Oneclient options][11] documentation for more details.

### Advanced usage

In addition to `PyFilesystem` interface, `OnedataFS` provides some specific methods
for using its advanced features.

#### File location information

In Onedata, each file can be distributed among different providers,
in blocks of various sizes.  In order to get information about the distribution
of these blocks, use the `location` method:

```python
space.location("file.txt")
```

This will give the following output:

```python
{'e0e49ac3d9b058c4839f8fb7ccc02d72': [[0, 1615273]]}
```

where the dictionary provides information on which Oneprovider, represented here
by its ID, holds which blocks (specified using byte ranges). In the above example,
provider `e0e49ac3d9b058c4839f8fb7ccc02d72` holds the entire file (1.6MB).

#### Extended attributes and metadata

Onedata supports metadata for each file or directory, which is accessible via
the virtual filesystem through the extended attribute mechanism. Since no such
API is provided by `PyFilesystem`, `OnedataFS` provides additional methods
which allow interacting with the metadata directly.

For example to list extended attributes defined for `file.txt`:

```python
# List extended attributes names for `file.txt`
space.listxattr("file.txt")
```

```python
['org.onedata.guid',
 'org.onedata.file_id',
 'org.onedata.space_id',
 'org.onedata.storage_id',
 'org.onedata.storage_file_id',
 'org.onedata.access_type',
 'org.onedata.file_blocks_count',
 'org.onedata.file_blocks',
 'org.onedata.replication_progress']
```

To get the specific attribute value:

```python
space.getxattr("file.txt", "org.onedata.space_id")
```

```python
b'"8a803754b41d9d744c8f03170193c0ab"'
```

To create a new extended attribute:

```python
space.setxattr("file.txt", "license", '"CC-0"')
```

Please note that the extended attribute values are by default parsed as JSON values, thus to insert a string, it has to have additional `"` qoutes.

This allows to add numeric constants as values like this:

```python
space.setxattr("file.txt", "priority", "2500")
```

which then will be indexed by Onedata as numbers not strings, and thus enable
more efficient data discovery in some cases.

It is also possible to attach entire JSON document with a key, by simply encoding
JSON as string for the value parameter:

```python
space.setxattr("file.txt", "origin", '{"continent": "Europe"}')
```

Finally to remove an extended attribute:

```python
space.removexattr("file.txt", "license")
```

<!-- references -->

[1]: <>

[2]: onedatafs.md

[3]: https://www.pyfilesystem.org/

[4]: https://github.com/onedata/fs-onedatafs/

[5]: https://www.softwarecollections.org/en/

[6]: https://anaconda.org

[7]: https://anaconda.org/onedata

[8]: https://docs.pyfilesystem.org/en/latest/interface.html

[9]: oneclient.md#basic-usage

[10]: oneclient.md#authentication

[11]: oneclient.md#options
