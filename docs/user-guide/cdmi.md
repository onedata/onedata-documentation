# CDMI

[[toc]]

## NOTE

Please, check and consider using Onedata 
[REST](https://onedata.org/#/home/api/stable/oneprovider?anchor=tag/Basic-File-Operations)
interface instead as it has better performance. One of the key differences 
causing this is operating on file content as binaries only (REST) instead of Base64 
encoded strings (CDMI). Due to that data send or received via CDMI may make up 
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

CDMI specification does not force to implement all capabilities. Please, check 
available capabilities before making any further requests.

```bash
curl -X GET "${ENDPOINT}/cdmi_capabilities/" -H "${CDMI_VSN_HEADER}"
```

```json
{
  "objectType": "application/cdmi-capability",
  "objectName": "cdmi_capabilities/",
  "objectID": "0000000000208CA83030303030303030303030303030303030303030303030303030303030303031",
  "childrenrange": "0-1",
  "children": [
    "container/",
    "dataobject/"
  ],
  "capabilities": {
    "cdmi_security_access_control": "true",
    "cdmi_object_move_from_local": "true",
    "cdmi_object_copy_from_local": "true",
    "cdmi_object_access_by_ID": "true",
    "cdmi_dataobjects": "true"
  }
}
```

In above example system capabilities declares support for **container** and 
**dataobject** entities (`children`). Their supported capabilities can be 
similarly checked using following queries:

```bash
curl -X GET "${ENDPOINT}/cdmi_capabilities/container/" -H "${CDMI_VSN_HEADER}"
```

```json
{
  "parentURI": "cdmi_capabilities/",
  "parentID": "0000000000208CA83030303030303030303030303030303030303030303030303030303030303031",
  "objectType": "application/cdmi-capability",
  "objectName": "container/",
  "objectID": "0000000000208DE83030303030303030303030303030303030303030303030303030303030303032",
  "children": [],
  "capabilities": {
    "cdmi_size": "true",
    "cdmi_read_metadata": "true",
    "cdmi_mtime": "true",
    "cdmi_move_dataobject": "true",
    "cdmi_move_container": "true",
    "cdmi_modify_metadata": "true",
    "cdmi_list_children_range": "true",
    "cdmi_list_children": "true",
    "cdmi_delete_container": "true",
    "cdmi_ctime": "true",
    "cdmi_create_dataobject": "true",
    "cdmi_create_container": "true",
    "cdmi_copy_dataobject": "true",
    "cdmi_copy_container": "true",
    "cdmi_atime": "true",
    "cdmi_acl": "true"
  }
}
```

```bash
curl -X GET "${ENDPOINT}/cdmi_capabilities/dataobject/" -H "${CDMI_VSN_HEADER}"
```

```json
{
  "parentURI": "cdmi_capabilities/",
  "parentID": "0000000000208CA83030303030303030303030303030303030303030303030303030303030303031",
  "objectType": "application/cdmi-capability",
  "objectName": "dataobject/",
  "objectID": "0000000000204D293030303030303030303030303030303030303030303030303030303030303033",
  "children": [],
  "capabilities": {
    "cdmi_size": "true",
    "cdmi_read_value_range": "true",
    "cdmi_read_value": "true",
    "cdmi_read_metadata": "true",
    "cdmi_mtime": "true",
    "cdmi_modify_value_range": "true",
    "cdmi_modify_value": "true",
    "cdmi_modify_metadata": "true",
    "cdmi_delete_dataobject": "true",
    "cdmi_ctime": "true",
    "cdmi_atime": "true",
    "cdmi_acl": "true"
  }
}
```

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
  "parentID": "0000000000583AC1677569642373706163655F6161383362353733643364303135353236313133316232366236633637366534636862313464236161383362353733643364303135353236313133316232366236633637366534636862313464",
  "objectType": "application/cdmi-object",
  "objectName": "file.txt",
  "objectID": "000000000052F53167756964233865663133343936393036393330633736306362383730623530376165643230636862313464236161383362353733643364303135353236313133316232366236633637366534636862313464",
  "mimetype": "application/octet-stream",
  "metadata": {
    "cdmi_size": "12",
    "cdmi_owner": "2a6af6ad4958f084f6c0ef252787d693ch9547",
    "cdmi_mtime": "2021-01-14T09:13:38Z",
    "cdmi_ctime": "2021-01-14T09:13:38Z",
    "cdmi_atime": "2021-01-14T09:13:38Z"
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

### Get part of file content

Please, consider using [this](https://onedata.org/#/home/api/stable/oneprovider?anchor=operation/download_file_content) 
REST endpoint instead.

```bash
curl -X GET "${ENDPOINT}/MySpace/file.txt?value:5-11" \
-H "${TOKEN_HEADER}" -H "${CDMI_VSN_HEADER}"
```

```json
{
  "value": "content"
}
```

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
# originally, the file content is  "Test content"

curl -X PUT "$ENDPOINT/MySpace/file.txt?value:0-3" \
-H "X-CDMI-Partial: true" -H "${TOKEN_HEADER}" -H "${CDMI_VSN_HEADER}" -H "${CT_DATAOBJECT}" -d '{
  "value": "QUJDRA=="
}'

# upon success, the file content is "ABCD content"
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
  "parentID": "0000000000583AC1677569642373706163655F6161383362353733643364303135353236313133316232366236633637366534636862313464236161383362353733643364303135353236313133316232366236633637366534636862313464",
  "objectType": "application/cdmi-container",
  "objectName": "dirtest/",
  "objectID": "00000000005257AF67756964236239306231623536626233663830323066653064373632653565616638633836636839353536236161383362353733643364303135353236313133316232366236633637366534636862313464",
  "metadata": {
    "cdmi_size": "0",
    "cdmi_owner": "2a6af6ad4958f084f6c0ef252787d693ch9547",
    "cdmi_mtime": "2021-01-14T09:30:53Z",
    "cdmi_ctime": "2021-01-14T09:30:53Z",
    "cdmi_atime": "2021-01-14T09:30:53Z"
  },
  "completionStatus": "Complete",
  "childrenrange": "",
  "children": [],
  "capabilitiesURI": "cdmi_capabilities/container/"
}
```

### List 3 first files in directory

Please, consider using [this](https://onedata.org/#/home/api/stable/oneprovider?anchor=operation/list_children) 
REST endpoint instead.

```bash
curl -X GET "$ENDPOINT/MySpace/dirtest/?children:0-2;childrenrange" \
-H "${TOKEN_HEADER}" -H "${CDMI_VSN_HEADER}"
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
    "onedata_json": {
      "key": "val"
    },
    "meta2": "val2",
    "meta1": "val1",
    "cdmi_size": "12",
    "cdmi_owner": "2a6af6ad4958f084f6c0ef252787d693ch9547",
    "cdmi_mtime": "2021-01-14T09:42:25Z",
    "cdmi_ctime": "2021-01-14T09:49:19Z",
    "cdmi_atime": "2021-01-14T09:42:24Z"
  }
}
```

### Get selected file metadata

Please, consider using [this](https://onedata.org/#/home/api/stable/oneprovider?anchor=operation/get_xattrs) 
REST endpoint instead.

```bash
curl -k -X GET "${ENDPOINT}/cdmi_objectid/${FILE_ID}?metadata:onedata_json" \
-H "${TOKEN_HEADER}" -H "${CDMI_VSN_HEADER}"
```

```json
{
  "metadata": {
    "onedata_json": {
      "key": "val"
    }
  }
}
```

### Set file ACL

For more information about ACL please refer to [this page](data.md#access-control-lists).

```bash
curl -k -X PUT "$ENDPOINT/MySpace/file.txt?metadata:cdmi_acl" \
-H "${TOKEN_HEADER}" -H "${CDMI_VSN_HEADER}" -H "${CT_DATAOBJECT}" -d '{
  "metadata": {
    "cdmi_acl": [
      {
        "acetype": "ALLOW",
        "identifier": "EVERYONE@",
        "aceflags": "NO_FLAGS",
        "acemask": "READ_OBJECT,READ_ATTRIBUTES,READ_METADATA,READ_ACL"
      }
    ]
  }
}'
```

### Get file ACL

For more information about ACL please refer to [this page](data.md#access-control-lists).

```bash
curl -X GET "$ENDPOINT/MySpace/file.txt?metadata:cdmi_acl" \
-H "${TOKEN_HEADER}" -H "${CDMI_VSN_HEADER}"
```

```json
{
  "metadata": {
    "cdmi_acl": [
      {
        "identifier": "EVERYONE@",
        "acetype": "0x0",
        "acemask": "0x20089",
        "aceflags": "0x0"
      }
    ]
  }
}
```
