# OnedataFileRestClient (Python)

[toc][]

## In a nutshell

`OnedataFileRESTClient` is a Python client to the Onedata file REST API. It offers basic operations on files as a concise, low-level library. Most users will probably be more interested in [onedatarestfs](./onedatarestfs.md) library, which is a plugin for [PyFilesystem], implemented using `OnedataFileRESTClient`, providing much more user friendly interface.


Supported Onezone versions: `>= 21.02.5`

Supported Oneprovider versions: `>= 21.02.5`.

## Installation

`OnedataFileRESTClient` library can be installed directly from [PyPi], for example:

```bash
pip install onedatafilerestclient
```

The source code is available on [GitHub].

## Usage

In order to use the `OnedataFileRESTClient` we need to first import necessary module and then create an instance of `OnedataFileRESTClient` with Onezone hostname and an access token:

```python
from onedatafilerestclient import *

onezone_host = 'onezone.example.com'
access_token = 'MDAzM2xvY2F00aW9uIGRldi1vbmV6b25lLmRlZmF1bHQuc3...'
client = OnedataFileRESTClient(onezone_host, access_token)
```

The `OnedataFileRESTClient` class provides the following operations (examples below assume `OnedataFileRESTClient` has been setup as shown above).

### Common API conventions

For most methods of `OnedataFileRESTClient`, there are following common conventions for
passing arguments to methods which perform operations on Onedata filesystem:

* first argument is the name of the data space
* next arguments are keyword arguments, include `file_path` or `file_id` which need
  to be specified separately from the first argument and contain paths relative to the
  space directory

### Get token scope

Returns a dictionary with a map of data spaces available through specified access token,
including some attributes such a list of Oneproviders supporting that each space.

```python
>>> client.get_token_scope()
{'validUntil': None,
 'dataAccessScope': {'spaces': {'67ae143419b1838715505bbad66096d2chfcf2': {'supports': {'71eb92fb45b414fc87d47aab3cf4a6b8ch836c': {'readonly': False}},
                                                                           'name': 'MyData'}},
                     'readonly': False,
                     'providers': {'71eb92fb45b414fc87d47aab3cf4a6b8ch836c': {'version': '21.02.8',
                                                                              'online': True,
                                                                              'name': 'dev-oneprovider-krakow',
                                                                              'domain': 'dev-oneprovider-krakow.default.svc.cluster.local'}}}}

```

### List spaces

Returns the list of data space names effectively available to the user based on specified access token.

```python
>>> client.list_spaces()
['MyData']
```

### Get space id

Resolves a space name to a an internal Onedata space ID:

```python
>>> client.get_space_id('MyData')
'67ae143419b1838715505bbad66096d2chfcf2'
```

### Get file id

Resolves a path to a directory or file to a unique file ID (file here can refer to file, directory or entire space):

```python
>>> client.get_file_id('MyData')
'000000000058E0AC677569642373706163655F3637616531343334313962313833383731353530356262616436363039366432636866636632233637616531343334313962313833383731353530356262616436363039366432636866636632'
```

> Corresponding API endpoint is [lookup_file_id](https://onedata.org/#/home/api/stable/oneprovider?anchor=operation/lookup_file_id).

### Get attributes

This method returns attributes for specified space, directory or file.

For example, to get attributes for `MyData` space:

```python
>>> client.get_attributes('MyData')
{'fileId': '000000000058E0AC677569642373706163655F3637616531343334313962313833383731353530356262616436363039366432636866636632233637616531343334313962313833383731353530356262616436363039366432636866636632',
 'parentFileId': None,
 'name': 'MyData',
 'posixPermissions': '775',
 'atime': 1748857564,
 'mtime': 1748856735,
 'ctime': 1748856735,
 'type': 'DIR',
 'size': 0,
 'directShareIds': [],
 'index': 'g2gDZAAKbGlzdF9pbmRleG0AAAAmNjdhZTE0MzQxOWIxODM4NzE1NTA1YmJhZDY2MDk2ZDJjaGZjZjJkAAl1bmRlZmluZWQ',
 'displayGid': 0,
 'displayUid': 0,
 'ownerUserId': 'VIRTUAL_SPACE_OWNER_67ae143419b1838715505bbad66096d2chfcf2',
 'originProviderId': '71eb92fb45b414fc87d47aab3cf4a6b8ch836c',
 'hardlinkCount': 1}
```

To get attributes for a specific file, we need to also specify the path within the space:

```python
>>> client.get_attributes('MyData', file_path='/file.txt')
{'fileId': '000000000052E01B67756964236432666666313638346261626132626630623661333262353638653733333633636866636632233637616531343334313962313833383731353530356262616436363039366432636866636632',
 'parentFileId': '000000000058E0AC677569642373706163655F3637616531343334313962313833383731353530356262616436363039366432636866636632233637616531343334313962313833383731353530356262616436363039366432636866636632',
 'name': 'file.txt',
 'posixPermissions': '664',
 'atime': 1748862683,
 'mtime': 1748862675,
 'ctime': 1748862675,
 'type': 'REG',
 'size': 4,
 'directShareIds': [],
 'index': 'g2gDZAAKbGlzdF9pbmRleG0AAAAIZmlsZS50eHRtAAAAJjcxZWI5MmZiNDViNDE0ZmM4N2Q0N2FhYjNjZjRhNmI4Y2g4MzZj',
 'displayGid': 0,
 'displayUid': 1976898,
 'ownerUserId': '52d4038aab393bc675783924836879e9ch393b',
 'originProviderId': '71eb92fb45b414fc87d47aab3cf4a6b8ch836c',
 'hardlinkCount': 1}
```

> Corresponding API endpoint is [get_args](https://onedata.org/#/home/api/stable/oneprovider?anchor=operation/get_attrs).

### Set attributes

This method allows to modify selected file or directory attributes, for example we can modify file permissions:

```python
>>> client.set_attributes('MyData', file_path='/file.txt', attributes={'mode': '666'}) # TODO!!!!!!!!!!!!!!!!!!!!!!!
>>> client.get_attributes('MyData', file_path='/file.txt', attributes=['posixPermissions'])
{'posixPermissions': '666'}
```

> Corresponding API endpoint is [set_args](https://onedata.org/#/home/api/stable/oneprovider?anchor=operation/set_attrs).

### List children

Returns the list of direct children of a given directory (or data space):

```python
>>> client.list_children('MyData', file_path='dir1', limit=5)
{'nextPageToken': 'g2gEZAAQcGFnaW5hdGlvbl90b2tlbmgDZAAKbGlzdF9pbmRleG0AAAAKZmlsZTEyLnR4dG0AAAAmNzFlYjkyZmI0NWI0MTRmYzg3ZDQ3YWFiM2NmNGE2YjhjaDgzNmNkAAl1bmRlZmluZWRkAARtb3Jl',
 'isLast': False,
 'children': [{'name': 'file0.txt', 'type': 'REG'},
              {'name': 'file1.txt', 'type': 'REG'},
              {'name': 'file10.txt', 'type': 'REG'},
              {'name': 'file11.txt', 'type': 'REG'},
              {'name': 'file12.txt', 'type': 'REG'}]}
```

To get the next page of result, we need to pass the `nextPageToken` as `continuation_token` argument:

```python
>>> pprint.pp(client.list_children('MyData', file_path='dir1', limit=5, continuation_token='g2gEZAAQcGFnaW5hdGlvbl90b2tlbmgDZAAKbGlzdF9pbmRleG0AAAAKZmlsZTEyLnR4dG0AAAAmNzFlYjkyZmI0NWI0MTRmYzg3ZDQ3YWFiM2NmNGE2YjhjaDgzNmNkAAl1bmRlZmluZWRkAARtb3Jl'))
{'nextPageToken': 'g2gEZAAQcGFnaW5hdGlvbl90b2tlbmgDZAAKbGlzdF9pbmRleG0AAAAKZmlsZTE3LnR4dG0AAAAmNzFlYjkyZmI0NWI0MTRmYzg3ZDQ3YWFiM2NmNGE2YjhjaDgzNmNkAAl1bmRlZmluZWRkAARtb3Jl',
 'isLast': False,
 'children': [{'name': 'file13.txt', 'type': 'REG'},
              {'name': 'file14.txt', 'type': 'REG'},
              {'name': 'file15.txt', 'type': 'REG'},
              {'name': 'file16.txt', 'type': 'REG'},
              {'name': 'file17.txt', 'type': 'REG'}]}
```

and continue as long as `isLast` returns `False`.

> Corresponding API endpoint is [list_children](https://onedata.org/#/home/api/stable/oneprovider?anchor=operation/list_children).

### Get file or directory contents

This method allows to read entire file:

```python
>>> client.get_file_content('MyData', file_path='file.txt')
b'TEST'
```

or specified range in one request:

```python
>>> client.get_file_content('MyData', file_path='file.txt', offset=2, size=2)
b'ST'
```

If requested file is a directory, this method returns a TAR archive with its contents. Any nested files or subdirectories, to which
the client does not have access (e.g. due to insufficient POSIX permissions or ACLs) are omitted in the resulting archive.
Request for directory download results in a redirection URL (in Location header) that contains the ID of a temporary
download session.

```python
>>> tar_bytes = client.get_file_content('MyData', file_path='dir1')
>>> tar = tarfile.open(fileobj=io.BytesIO(tar_bytes))
>>> files = [entry.name for entry in tar.getmembers()]
>>> files[0:5]
['dir1', 'dir1/file0.txt', 'dir1/file1.txt', 'dir1/file10.txt', 'dir1/file11.txt']
```

> Corresponding API endpoint is [download_file_content_by_path](https://onedata.org/#/home/api/stable/oneprovider?anchor=operation/download_file_content_by_path).

### Iter file content

This method returns a Python iterator, allowing to read file in chunks of specified size:

```python
>>> stream = client.iter_file_content('MyData', chunk_size=2, file_path='file.txt')
>>> [chunk for chunk in stream]
[b'TE', b'ST']
```

> Corresponding API endpoint is [download_file_content_by_path](https://onedata.org/#/home/api/stable/oneprovider?anchor=operation/download_file_content_by_path).

### Put file content

This method allows to append or modify the contents of a file. The file must exist beforehand.

```python
>>> client.create_file('MyData', file_path='file2.txt')
'0000000000527B5767756964236333633832643730316165633034333139666634666161353331363861393465636866636632233637616531343334313962313833383731353530356262616436363039366432636866636632'
>>> client.put_file_content('MyData', b'ABCD', file_path='file2.txt')
>>> client.get_file_content('MyData', file_path='file2.txt')
b'ABCD'
```

It's also possible to specify an offset after which to write the content in the file:

```python
>>> client.put_file_content('MyData', b'EFGH', file_path='file2.txt', offset=2)
>>> client.get_file_content('MyData', file_path='file2.txt')
b'ABEFGH'
```

> Corresponding API endpoint is [update_file_content](https://onedata.org/#/home/api/stable/oneprovider?anchor=operation/update_file_content).

### Create file or directory

Creates a file at path specified in the URL, relative to the base directory given in the id parameter (see the parameter
description for details). If the parent path does not exist and create_parents flag is set to true, the operation will attempt to create intermediate parent directories.

If the file already exists, the operation fails with an error.

The file type can be one of:

* `REG` - regular file
* `DIR` - directory
* `LNK` - hard link
* `SYMLNK` - symbolic link

```python
>>> client.create_file('MyData', file_path='dir3', file_type='DIR')
'000000000052DBCF67756964236462363362636366653466373662336464333334316235396537653636613564636861383337233637616531343334313962313833383731353530356262616436363039366432636866636632'
```

```python
>>> client.create_file('MyData', file_path='dir3/file3.txt')
'000000000052EEA567756964233236346335393335643762386238363731363261663062393761303363653532636861383337233637616531343334313962313833383731353530356262616436363039366432636866636632'
```

> Corresponding API endpoint is [create_file](https://onedata.org/#/home/api/stable/oneprovider?anchor=operation/create_file).

### Remove

Removes file or directory specified by `file_path` argument. In case of a directory, all its children are recursively
removed - note that the operation will fail part-way if the client does not have permissions to remove some of the
nested files/directories.

```python
>>> client.remove('MyData', file_path='dir3/file3.txt')
```

> Corresponding API endpoint is [remove_file_at_path](https://onedata.org/#/home/api/stable/oneprovider?anchor=operation/remove_file_at_path).

### Move

This method allows to rename a file or directory, also between different data spaces:

```python
>>> client.move('MyData', 'file.txt', 'MyData', 'file_new.txt')
```

<!-- references -->

[GitHub]: https://github.com/onedata/onedatafilerestclient

[PyPi]: https://pypi.org/project/onedatafilerestclient/

[PyFilesystem]: https://github.com/PyFilesystem/pyfilesystem2
