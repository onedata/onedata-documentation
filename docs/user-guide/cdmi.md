# CDMI

[toc][1]

## Quickstart

Refer to the [usage examples][] for a quick guide on how to perform basic CDMI requests.

## CDMI vs. REST API

Consider using Onedata's [REST][] interface, which provides counterparts for
most CDMI operations with more straightforward API and better performance. This
is mainly because CDMI uses Base64 encoded strings for binary file content
transmission, resulting in approximately 33% larger I/O traffic compared to
REST, which works with plain binaries.

You can find the documentation for the file management API based on OpenAPI
(a.k.a. Swagger) [here][basic-file-api-reference].

## Introduction

The **Cloud Data Management Interface (CDMI)** defines a universal,
vendor-agnostic interface for discovering the capabilities of storage providers,
managing Cloud storage, and accessing data stored within it.

CDMI uses specific terms such as **data object** or **container** to refer to
various storage elements. The correspondence between the CDMI and Onedata
concepts is as follows:

| CDMI         | Onedata                                          |
| :----------- | :----------------------------------------------- |
| Containers   | directories (including root [space][] directory) |
| Data Objects | regular files stored in user's [spaces][space]   |
| Object ID    | [File ID][]                                      |

At present, Onedata supports CDMI version `1.1.1`.

For more information about CDMI, visit the [official website][CDMI specification].

## Endpoints

In Onedata, files and directories can be accessed and managed using CDMI queries
on the following paths:

* `/cdmi/${FILE_PATH}`: for interacting with files or directories using their logical path.
* `/cdmi/cdmi_objectid/${FILE_ID}`: for interacting with files or directories
  using their unique [File ID][].

It is recommended to use File IDs whenever possible as they offer better
performance, since no path resolution is required.

When referencing files through CDMI using the file path, keep in mind that
Onedata organizes all data into [spaces][space], and the space name is the first
element in the file path. For example, in the path below, `CMS 1` represents the
name of the space (**make sure to URL-encode the path**):

```bash
/cdmi/CMS%201/file.txt
```

::: warning NOTE
CDMI imposes strict rules regarding the trailing slash in paths:

* directory-path must always end with `/` — e.g. `/cdmi/MySpace/dir1/`,
* file-path must have no trailing slash — e.g. `/cdmi/MySpace/file1.txt`.

:::

## Examples of usage

Note that the examples provided below cover only a portion of the available API and parameters.

### Prerequisites

Prepare a valid access token. You can generate an access token either in the Web
GUI or via REST API (refer to the [tokens][] chapter).

The following examples assume that below environment variables are exported.

```bash
export ONEPROVIDER_DOMAIN="provider.example.com"  # replace with actual

export FILE_ID="39592D594E736C676D0000002B4345F6...."  # replace with actual

export ACCESS_TOKEN="MDAyMGxvY2F00aW9uIG96LAyL3Rt..."  # replace with actual

export TOKEN_HEADER="X-Auth-Token: ${ACCESS_TOKEN}"

export CDMI_VSN_HEADER="X-CDMI-Specification-Version: 1.1.1"

export CT_CONTAINER="Content-Type: application/cdmi-container"

export CT_DATAOBJECT="Content-Type: application/cdmi-object"

export ENDPOINT="https://${ONEPROVIDER_DOMAIN}/cdmi"
```

Make sure to adjust the `$FILE_ID`, `$ACCESS_TOKEN`, and `$ONEPROVIDER_DOMAIN` variables.

### Create new file

::: tip
Consider using the [create file][] REST endpoint instead, as it provides a more
straightforward API and better performance.
:::

```bash
curl -X PUT "${ENDPOINT}/MySpace/file.txt" \
-H "${TOKEN_HEADER}" -H "${CDMI_VSN_HEADER}" -H "${CT_DATAOBJECT}" -d '{
  "value": "Test content"
}' 
```

This CDMI query will create a file named `file.txt` in the `MySpace` space. The
content of the file is specified in the request body `("value": "Test
content")`.

Response example:

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

::: tip
Consider using the [get attributes][] REST endpoint instead.
:::

```bash
curl -X GET "${ENDPOINT}/MySpace/file.txt?valuetransferencoding;mimetype;objectName" \
-H "${TOKEN_HEADER}" -H "${CDMI_VSN_HEADER}"
```

This CDMI query will retrieve the specified attributes (`valuetransferencoding`, `mimetype`, and `objectName`) of
the file `file.txt` in the `MySpace` space.

Response example:

```json
{
  "valuetransferencoding": "utf-8",
  "mimetype": "application/octet-stream",
  "objectName": "test.txt"
}
```

### Get part of the file content

::: tip
Consider using the [download file content][] REST endpoint instead.
:::

```bash
curl -X GET "${ENDPOINT}/MySpace/file.txt?value:5-11" \
-H "${TOKEN_HEADER}" -H "${CDMI_VSN_HEADER}"
```

This CDMI query will retrieve the content of the file `file.txt` in the `MySpace` space from the byte range 5-11.

Response example: (original file content is `"Test content"`)

```json
{
  "value": "content"
}
```

### Update file content

::: tip
Consider using the [update file content][] REST endpoint instead.
:::

CDMI, starting from version 1.0.2, supports partial uploads, where a subrange of
the value field can be provided as a byte range using the URL attribute
`?value:<START_OFFSET>-<END_OFFSET>`. The value sent must be Base64 encoded.

```bash
echo -n ABCD | base64

QUJDRA==
```

```bash
curl -X PUT "$ENDPOINT/MySpace/file.txt?value:0-3" \
-H "X-CDMI-Partial: true" -H "${TOKEN_HEADER}" -H "${CDMI_VSN_HEADER}" -H "${CT_DATAOBJECT}" -d '{
  "value": "QUJDRA=="
}'
```

This CDMI query will update the first 4 bytes of the file `file.txt` in the
`MySpace` space to "ABCD". The value `QUJDRA==` represents the Base64 encoding
of "ABCD".

The original file content set in a previous example is "Test content". Upon
successful execution, the file's content will be "ABCD content".

### Delete file

::: tip
Consider using [remove file][] REST endpoint instead.
:::

```bash
curl -X DELETE "${ENDPOINT}/cdmi_objectid/${FILE_ID}" \
-H "${TOKEN_HEADER}" -H "${CDMI_VSN_HEADER}" -H "${CT_DATAOBJECT}"
```

This CDMI query will delete the file identified by `${FILE_ID}`.

### Create new directory

::: tip
Consider using [create file][] REST endpoint instead.
:::

```bash
curl -X PUT "${ENDPOINT}/MySpace/dir_test/" \
-H "${TOKEN_HEADER}" -H "${CDMI_VSN_HEADER}" -H "${CT_CONTAINER}"
```

This CDMI query will create a new directory named `dir_test` in the `MySpace` space.

Response example:

```json
{
  "parentURI": "/MySpace/",
  "parentID": "0000000000583AC1677569642373706163655F6161383362353733643364303135353236313133316232366236633637366534636862313464236161383362353733643364303135353236313133316232366236633637366534636862313464",
  "objectType": "application/cdmi-container",
  "objectName": "dir_test/",
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

### List 3 first files in a directory

::: tip
Consider using the [list children][] REST endpoint instead.
:::

```bash
curl -X GET "$ENDPOINT/MySpace/dir_test/?children:0-2;childrenrange" \
-H "${TOKEN_HEADER}" -H "${CDMI_VSN_HEADER}"
```

This CDMI query will retrieve the first 3 files in the `dir_test` directory located in the `MySpace` space.

Response example:

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

The `childrenrange` attribute specifies the range of children files that are
included in the response.

### Delete directory

::: tip
Consider using [remove file][] REST endpoint instead.
:::

```bash
curl -X DELETE "${ENDPOINT}/MySpace/dir_test/" \
-H "${TOKEN_HEADER}" -H "${CDMI_VSN_HEADER}" -H "${CT_CONTAINER}"
```

This CDMI query will delete the `dir_test` directory located in the MySpace space.

### Set file metadata

::: tip
Consider using [set metadata][] REST endpoint instead.
:::

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

This CDMI query will set the metadata for the specified file identified by `${FILE_ID}`.
You can include multiple metadata fields in the request payload.

### Get all file metadata

::: tip
Consider using [get metadata][] REST endpoint instead.
:::

```bash
curl -X GET "${ENDPOINT}/MySpace/file.txt?metadata" \
-H "${TOKEN_HEADER}" -H "${CDMI_VSN_HEADER}"
```

This CDMI query will fetch all the metadata associated with the `file.txt` file
located in the `MySpace` space.

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

::: tip
Consider using [get metadata][] REST endpoint instead.
:::

```bash
curl -X GET "${ENDPOINT}/cdmi_objectid/${FILE_ID}?metadata:onedata_json" \
-H "${TOKEN_HEADER}" -H "${CDMI_VSN_HEADER}"
```

This CDMI query will fetch the selected metadata field `onedata_json` for the file identified by `${FILE_ID}`.

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

```bash
curl -X PUT "$ENDPOINT/MySpace/file.txt?metadata:cdmi_acl" \
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

This CDMI query will set the ACL for the file named `file.txt` in the `MySpace`
space. The ACL defines access permissions for the specified identifier. In the
example provided, the ACL allows read access (`READ_OBJECT`, `READ_ATTRIBUTES`,
`READ_METADATA`, `READ_ACL`) for the identifier `EVERYONE@`.

Refer to the [documentation][ACL] to learn about ACL. 

### Get file ACL

```bash
curl -X GET "$ENDPOINT/MySpace/file.txt?metadata:cdmi_acl" \
-H "${TOKEN_HEADER}" -H "${CDMI_VSN_HEADER}"
```

This CDMI query will fetch the ACL metadata (`cdmi_acl`) for the file named `file.txt` in the `MySpace` space.

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

Refer to the [documentation][ACL] to learn about ACL. 

### Advanced operations

Onedata implements a certain subset of CDMI specification and not all available
operations are covered in this guide. You can use the capability discovery
endpoints to find out which operations are supported, as demonstrated below.

### Get supported capabilities

```bash
curl -X GET "${ENDPOINT}/cdmi_capabilities/" -H "${CDMI_VSN_HEADER}"
```

The response will contain information about the supported entities and their
capabilities. For example:

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

In the above response sample, the system declares support for **container** and
**dataobject** entities (`children`). Their supported capabilities can be
similarly checked using the following queries:

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

For more detailed information on CDMI operations and their parameters,
refer to the [CDMI specification][].

<!-- references -->

[1]: <>

[usage examples]: #examples-of-usage

[REST]: data.md#rest-api

[basic-file-api-reference]: https://onedata.org/#/home/api/stable/oneprovider?anchor=tag/Basic-File-Operations

[space]: spaces.md

[File ID]: data.md#file-path-and-id

[CDMI specification]: http://www.snia.org/cdmi

[tokens]: ./tokens.md

[create file]: https://onedata.org/#/home/api/stable/oneprovider?anchor=operation/create_file

[get attributes]: https://onedata.org/#/home/api/stable/oneprovider?anchor=operation/get_attrs

[download file content]: https://onedata.org/#/home/api/stable/oneprovider?anchor=operation/download_file_content

[update file content]: https://onedata.org/#/home/api/stable/oneprovider?anchor=operation/update_file_content

[remove file]: https://onedata.org/#/home/api/stable/oneprovider?anchor=operation/remove_file

[list children]: https://onedata.org/#/home/api/stable/oneprovider?anchor=operation/list_children

[set metadata]: https://onedata.org/#/home/api/stable/oneprovider?anchor=operation/set_xattr

[get metadata]: https://onedata.org/#/home/api/stable/oneprovider?anchor=operation/get_xattrs

[ACL]: data.md#access-control-lists
