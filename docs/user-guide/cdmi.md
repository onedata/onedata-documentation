# CDMI

<!-- This file is referenced at least one time as "cdmi.md" -->

[[toc]]

## NOTE

Please, check and consider using Onedata 
[REST](https://onedata.org/#/home/api/stable/oneprovider?anchor=tag/Basic-File-Operations)
interface instead as it has better performance. One of the key differences 
causing this is operating on file content as binaries (REST) instead of Base64 
encoded strings (CDMI). Due to that any data send or received via CDMI makes up 
4/3 of original data.


## Quickstart

See [usage examples](#examples-of-usage) for a quick guide how to perform basic
CDMI requests.


## Introduction

**Cloud Data Management Interface (CDMI)** defines a universal, vendor-agnostic 
interface for discovering capabilities of storage providers, managing Cloud 
storage and accessing data held in it. 

CDMI uses certain terms such as **data object** or **container** to refer to 
various elements of storage. The mapping between main CDMI and Onedata concepts 
is as follows:

| CDMI concept  | Onedata concept                           |
|:--------------|:------------------------------------------|
| Containers    | directories (including space directory)   |
| Data Objects  | regular files stored in user's Spaces     |
| Object ID     | [fileId](data.md#file-path-and-id)        |

Currently, Onedata supports CDMI version `1.1.1`. For more information about it 
please visit official CDMI [website](http://www.snia.org/cdmi).


## Endpoints

Files (and directories) can be accessed and managed in Onedata using CDMI queries 
on following paths:
- `/cdmi/${FILE_PATH}`
- `/cdmi/cdmi_objectid/${FILE_ID}`

It is advised to use the second approach (requests using file's own unique 
[fileId](data.md#file-path-and-id) file id instead of path) whenever possible 
as it has better performance (no path resolution needs to pe performed). 

When referencing files through CDMI using file path, please remember that 
Onedata organizes all data into spaces, and space name is the first element 
of the file path - for example `CMS 1` in path below (make sure to urlencode 
the path):

```bash
/cdmi/CMS%201/file.txt
```

Also, please note that there are strict rules on the format of path stating that
directory path must always end with `/` (e.g. `/cdmi/MysSpace/dir1/`) while 
file path without it (e.g. `/cdmi/MysSpace/file1.txt`).


## Examples of usage

### Prerequisites

In order to use Onedata CDMI, a valid Onedata access token must be provided. 
The access token can be generated either in the Web GUI or via REST API (refer 
to the [tokens section](./tokens.md)).

The following examples assume that below environment variables are exported. 

```bash
export FILE_ID=<FILE_ID>

export ACCESS_TOKEN=<ACCESS_TOKEN>

export TOKEN_HEADER="X-Auth-Token: ${ACCESS_TOKEN}"

export CDMI_VSN_HEADER="X-CDMI-Specification-Version: 1.1.1"

export CT_CONTAINER="Content-Type: application/cdmi-container"

export CT_DATAOBJECT="Content-Type: application/cdmi-object"

export ONEZONE_DOMAIN=<ONEZONE_DOMAIN>

export ONEPROVIDER_DOMAIN=<ONEPROVIDER_DOMAIN>

export ENDPOINT=https://${ONEPROVIDER_DOMAIN}/cdmi
```

Make sure to adjust the `$FILE_ID`, `$ACCESS_TOKEN`, `$ONEZONE_DOMAIN` and 
`$ONEPROVIDER_DOMAIN` variables. 

### Get supported capabilities
...

### Create new file

Please, consider using [this](https://onedata.org/#/home/api/stable/oneprovider?anchor=operation/create_file) 
REST endpoint instead.

```bash
curl -X PUT "${ENDPOINT}/MySpace/file.txt" \ 
-H "${TOKEN_HEADER}" -H "${CDMI_VSN_HEADER}" -H "${CT_DATAOBJECT}" -d '{
  "value": "Test content"
}' 
```

```json
{
  "parentURI": "/MySpace/",
  "parentID": "000000000058BEF4677569642373706163655F6661366566613631386132336638323930356237386337363564316638323635636866356638236661366566613631386132336638323930356237386337363564316638323635636866356638",
  "objectType": "application/cdmi-object",
  "objectName": "file.txt",
  "objectID": "0000000000527A3E67756964233761353832643834663064386536613330363666626334353931353635366236636866356638236661366566613631386132336638323930356237386337363564316638323635636866356638",
  "mimetype": "application/octet-stream",
  "metadata": {
    "cdmi_size": "12",
    "cdmi_owner": "b0954b21ece47c83c21f37de62a0ba13che47c",
    "cdmi_mtime": "2020-07-13T14:50:00Z",
    "cdmi_ctime": "2020-07-13T14:50:00Z",
    "cdmi_atime": "2020-07-13T14:50:00Z"
  },
  "completionStatus": "Complete",
  "capabilitiesURI": "cdmi_capabilities/dataobject/"
}
```

### Get selected file attributes

Please, consider using [this](https://onedata.org/#/home/api/stable/oneprovider?anchor=operation/get_attrs) 
REST endpoint instead.

```bash
curl -X GET "${ENDPOINT}/MySpace/file.txt?valuetransferencoding;mimetype;objectName" \
-H "${TOKEN_HEADER}" -H "${CDMI_VSN_HEADER}"
```

```json
{
  "valuetransferencoding": "utf-8",
  "mimetype": "application/octet-stream",
  "objectName": "test.txt"
}
```

### Get file content

Please, consider using [this](https://onedata.org/#/home/api/stable/oneprovider?anchor=operation/download_file_content) 
REST endpoint instead.

...

### Update file content

Please, consider using [this](https://onedata.org/#/home/api/stable/oneprovider?anchor=operation/update_file_content) 
REST endpoint instead.

CDMI since version 1.0.2 provides support for partial uploads, where 
a subrange of value field can be provided as a long as byte range 
that is submitted is specified using URL attribute 
`?value:<START_OFFSET>-<END_OFFSET>`.

Also, the value send must be Base64 encoded.

Change first 4 bytes of test.txt file to "ABCD":

```bash
echo -n ABCD | base64

QUJDRA==
```

```bash
# originally, the file content is  "qwertyuiop"

curl -k -X PUT "$ENDPOINT/test/test.txt?value:0-3" \
-H "X-CDMI-Partial: true" -H "${TOKEN_HEADER}" -H "${CDMI_VSN_HEADER}" -H "${CT_DATAOBJECT}" -d '{
  "value": "QUJDRA=="
}'

# upon success, the file content is "ABCDtyuiop"
```

### Delete file

Please, consider using [this](https://onedata.org/#/home/api/stable/oneprovider?anchor=operation/remove_file) 
REST endpoint instead.

```bash
curl -X DELETE "${ENDPOINT}/cdmi_objectid/${FILE_ID}" \
-H "${TOKEN_HEADER}" -H "${CDMI_VSN_HEADER}" -H "${CT_DATAOBJECT}"
```

### Create new directory

Please, consider using [this](https://onedata.org/#/home/api/stable/oneprovider?anchor=operation/create_file) 
REST endpoint instead.

```bash
curl -X PUT "${ENDPOINT}/MySpace/dirtest/" \
-H "${TOKEN_HEADER}" -H "${CDMI_VSN_HEADER}" -H "${CT_CONTAINER}"
```

```json
{
  "parentURI": "/MySpace/",
  "parentID": "000000000058BEF4677569642373706163655F6661366566613631386132336638323930356237386337363564316638323635636866356638236661366566613631386132336638323930356237386337363564316638323635636866356638",
  "objectType": "application/cdmi-container",
  "objectName": "dirtest/",
  "objectID": "0000000000528DE867756964233937353062353032366432613865396161373234366631643961613561633237636831616238236661366566613631386132336638323930356237386337363564316638323635636866356638",
  "metadata": {
    "cdmi_size": "0",
    "cdmi_owner": "b0954b21ece47c83c21f37de62a0ba13che47c",
    "cdmi_mtime": "2020-07-13T16:32:33Z",
    "cdmi_ctime": "2020-07-13T16:32:33Z",
    "cdmi_atime": "2020-07-13T16:32:33Z"
  },
  "completionStatus": "Complete",
  "childrenrange": "",
  "children": [],
  "capabilitiesURI": "cdmi_capabilities/container/"
}
```

### List directory

Please, consider using [this](https://onedata.org/#/home/api/stable/oneprovider?anchor=operation/list_children) 
REST endpoint instead.

```bash
curl -X GET "$ENDPOINT/MySpace/dirtest/?children:0-2;childrenrange" \
-H "${TOKEN_HEADER}" -H "${$CDMI_VSN_HEADER}"
```

```json
{
  "children":[
    "test1.txt",
    "test2.txt",
    "test3.txt"
  ],
  "childrenrange":"0-2"
}
```

### Delete directory

Please, consider using [this](https://onedata.org/#/home/api/stable/oneprovider?anchor=operation/remove_file) 
REST endpoint instead.

```bash
curl -X DELETE "${ENDPOINT}/MySpace/dirtest/" \
-H "${TOKEN_HEADER}" -H "${CDMI_VSN_HEADER}" -H "${CT_CONTAINER}"
```

### Set file metadata

Please, consider using [this](https://onedata.org/#/home/api/stable/oneprovider?anchor=operation/set_xattr) 
REST endpoint instead.

```bash
curl -X PUT "${ENDPOINT}/cdmi_objectid/${FILE_ID}" \
-H "${TOKEN_HEADER}" -H "${CDMI_VSN_HEADER}" -H "${CT_DATAOBJECT}" -d '{
  "metadata": {
    "meta1": "val1", 
    "meta2": "val2",
    "onedata_json": {"key": "val"}
  }
}'
```

### Get all file metadata

Please, consider using [this](https://onedata.org/#/home/api/stable/oneprovider?anchor=operation/get_xattrs) 
REST endpoint instead.

```bash
curl -X GET "${ENDPOINT}/MySpace/file.txt?metadata" \
-H "${TOKEN_HEADER}" -H "${CDMI_VSN_HEADER}"
```

```json
{
  "metadata": {
    "meta1": "val1",
    "meta2": "val2",
    "cdmi_size": "12",
    "cdmi_owner": "079f4ab79acd83b3ef41ec82f6b84abcchb280",
    "cdmi_mtime": "2020-07-14T08:06:54Z",
    "cdmi_ctime": "2020-07-14T09:20:47Z",
    "cdmi_atime": "2020-07-14T09:21:04Z"
  }
}
```

### Get selected file metadata

Please, consider using [this](https://onedata.org/#/home/api/stable/oneprovider?anchor=operation/get_xattrs) 
REST endpoint instead.

```bash
curl -X GET "${ENDPOINT}/cdmi_objectid/${FILE_ID}?metadata:onedata_json" \
-H "${TOKEN_HEADER}" -H "${CDMI_VSN_HEADER}"
```

```json
{
  "metadata": {
    "onedata_json": "val1"
  }
}
```

### ACL
