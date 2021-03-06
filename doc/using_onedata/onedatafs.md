# OnedataFS Python library

<!-- toc -->

In addition to accessing data via POSIX virtual filesystem provided by `oneclient`
transparently, since version `18.02.2` it is also possible to access data managed
by Onedata directly from Python, using OnedataFS Python library.

OnedataFS is a [PyFilesystem](https://www.pyfilesystem.org/) plugin to
[Onedata](https://onedata.org) virtual file system.
As a PyFilesystem concrete class, [OnedataFS](https://github.com/onedata/fs-onedatafs/)
allows you to work with Onedata in the same way as any other supported filesystem.


## Installation
OnedataFS can be installed from our provided packages for both Python 2 and Python 3.

### Ubuntu

```
wget https://get.onedata.org/oneclient.sh

# For Python2
pip install fs
sh oneclient.sh python-fs-plugin-onedatafs

# For Python3
pip3 install fs
sh oneclient.sh python3-fs-plugin-onedatafs
```

### CentOS

Please note that CentOS packages are distributed according to the
[Software Collections](https://www.softwarecollections.org/en/) standard.

```
wget https://get.onedata.org/oneclient.sh

# For Python2
pip install fs
sh oneclient.sh onedata1802-python2-fs-onedatafs
scl enable onedata1802 bash

# For Python3
pip3 install fs
sh oneclient.sh onedata1802-python3-fs-onedatafs
scl enable onedata1802 bash
```

### Anaconda

Since version `18.02.2` and `19.02.0-rc1` Oneclient can be installed using
[Anaconda](https://anaconda.org), from the official
[Onedata conda repository](https://anaconda.org/onedata):

```bash
conda install -c onedata fs.onedatafs
```

or to install a specific version of `fs.onedatafs`

```bash
conda install -c onedata fs.onedatafs=18.02.2
```

Furthermore, to ensure that conda will not upgrade Python in a given environment,
it is possible to provide the exact build number of the OnedataFS packages, which
includes the Python version, e.g.:

```bash
conda install -c onedata fs.onedatafs=18.02.2=py36_0
```

## Usage

To create an instance of OnedataFS connected to a specific Oneprovider, use
the following code:

```python
from fs.onedatafs import OnedataFS
onedata_provider_host = "..."
onedata_access_token = "..."

# Create connection to Oneprovider
odfs = OnedataFS(onedata_provider_host, onedata_access_token)

# Open selected space directory
space = odfs.opendir('/SpaceA')

# List SpaceA contents
space.listdir('/')
```
From then on, `space` can be used as any `PyFilesystem` instance, please refer
to [PyFilesystem](https://docs.pyfilesystem.org/en/latest/interface.html)
reference for documentation on all operations available
on a filesystem object.

The complete list of options which can be provided to the OnedataFS constructore
are as follows (only `host` and `token` are required):

* `host` - the Onedata Oneprovider host name
* `token` - the Onedata user access token
* `port` - the Onedata Oneprovider port
* `space` - the list of space names which should be listed. By default, all user spaces are listed
* `space_id` - the list of space id's which should be listed. By default, all user spaces are listed
* `insecure` - when `True`, allow connecting to Oneproviders without valid SSL certificate
* `force_proxy_io` - when `True`, forces all data transfers to go via Oneproviders
* `force_direct_io` - when `True`, forces all data transfers to go directly via the target storage API. If storage is not available, for instance due to network firewalls, error will be returned for all `read` and `write` operations
* `no_buffer` - when `True`, disable all internal buffering in the OnedataFS
* `io_trace_log` - when `True`, the OnedataFS will log all requests in a CSV file in the directory specified by `log_dir`
* `provider_timeout` - specifies the timeout for waiting for Oneprovider responses, in seconds
* `log_dir` - path in the filesystem, where internal OnedataFS logs should be stored. When `None`, no logging will be generated


### Advanced usage

In addition to `PyFilesystem` methods `OnedataFS` provides some specific methods
for using it's advanced features.

#### File location information

In Onedata, each file can be distributed among different Oneprovider instances,
in blocks of various size.  In order to get information about the distribution
of these blocks, use the `location` method:

```
space.location("file.txt")
```

This will give the following output:

```
{'e0e49ac3d9b058c4839f8fb7ccc02d72': [[0, 1615273]]}
```

where the dictionary provides information which Oneprovider, represented here by its ID,
holds which blocks defined by byte ranges. In the above example Oneprovider 
`e0e49ac3d9b058c4839f8fb7ccc02d72` holds the entire file.

#### Extended attributes and metadata

Onedata supports metadata for each file or directory, which are accessible via the 
virtual filesystem through the extended attribute mechanism. Since no such API is 
provided by `PyFilesystem`, `OnedataFS` provides additional methods which allow to 
interact with the metadata directly.

For example to list extended attributes defined for `file.txt`:
```
# List extended attributes names for `file.txt`
space.listxattr("file.txt")
```

gives:

```
['org.onedata.uuid',
 'org.onedata.space_id',
 'org.onedata.file_id',
 'org.onedata.access_type',
 'org.onedata.file_blocks_count',
 'org.onedata.file_blocks',
 'org.onedata.replication_progress',
 'org.onedata.storage_id']
```

To get the specific attribute value:
```
space.getxattr("file.txt", "org.onedata.space_id")
```

gives:

```
b'"8a803754b41d9d744c8f03170193c0ab"'
```

To create a new extended attribute:
```
space.setxattr("file.txt", "license", '"CC-0"') 
```
Please note that the extended attribute values are by default parsed as JSON values,
thus in order to insert a string, it has to have additional `"` qoutes.

This allows to add numeric constants as values like this:

```
space.setxattr("file.txt", "priority", "2500") 
```

which then will be indexed by Onedata as numbers not strings, and thus enable
more efficient data discovery in some cases.

It is also possible to attach entire JSON document with a key, by simply encoding
JSON as string for the value parameter:

```
space.setxattr("file.txt", "origin", '{"continent": "Europe"}') 
```

Finally to remove an extended attribute:

```
space.removexattr("file.txt", "license") 
```
