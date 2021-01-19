# Data
<!-- This file is referenced at least one time as "data.md" -->

## File path and Id
<!-- This header is referenced at least one time as "#file-path-and-id" -->

Files and directories in Onedata can be globally identified using unique file Ids or logical paths 
that include a space name.

### File path
<!-- This header is referenced at least one time as "#file-paths" -->
It is recommended to use [file Ids](#file-id) to identify files, although some endpoints allow working with paths. 
When referencing files or directories (also called dataobjects or containers in [CDMI](cdmi.md)) by path, 
please remember that Onedata organizes all data into spaces, and space name is the first element of 
the file path. Consider this example:
```bash
/CMS 1/file.txt
```
`CMS 1` is the space name and `file.txt` is child of the space directory.

The file can be accessed in several ways:
1. Web GUI
![image](../../images/user-guide/data/file-gui.png)

2. [Oneclient FUSE application](oneclient.md) 
    ```bash
    cat /CMS\ 1/file.txt
    ```        
3. [CDMI](cdmi.md):

    ```bash
    curl -H "X-Auth-Token: ${ACCESS_TOKEN}" -H "X-CDMI-Specification-Version: 1.1.1" \
    -X GET "https://${ONEPROVIDER_DOMAIN}/cdmi/CMS%201/file.txt"
    ```

    >**NOTE:** Make sure to urlencode the path if used in URL, as in above example.

    >**NOTE:** Above request returns ALL attributes of the file in a JSON, including its content, associated with
    > a key "value". The content may be returned as plain binary or as base64. Please check value of key
    > "valuetransferencoding" to determine in which format the content of the file was fetched.

4. [REST API](rest-api.md) in this case a file is referenced by its[file Id](#file-id).
Please see the [next section](#file-id) to find out how to obtain file Id. 

### File Id
<!-- This header is referenced at least one time as "#file-id" -->

File Id is a unique, global identifier associated with a file or directory and
can be used universally in the CDMI and REST APIs. There are several ways to 
find out the file Id of given file or directory:

1. Web GUI - click on Information in the file/directory context menu and look 
for `File ID`
![image](../../images/user-guide/data/file-information-gui.png)

2. [REST API](rest-api.md) - use the file Id resolution endpoint. Below example returns the 
file Id of file `/CMS 1/file.txt`, where `CMS 1` is the space name 
(see [file paths](#file-path)):

    ```bash
     curl -H "X-Auth-Token: ${ACCESS_TOKEN}" \
    -X POST "https://${ONEPROVIDER_DOMAIN}/api/v3/oneprovider/lookup-file-id/CMS%201/file.txt"
    ```
    ```json 
    {
        "fileId": "094576776E667431723230677767776C6B497031394E445F6E3868677873..."
    }
    ```
    >**NOTE:** Make sure to urlencode the path if used in URL, as in above example.


3. [CDMI](cdmi.md) - get CDMI objectID (which is a CDMI name for file Id)

    ```bash
    curl -H "X-Auth-Token: ${ACCESS_TOKEN}" -H "X-CDMI-Specification-Version: 1.1.1"
      -X GET "https://${ONEPROVIDER_DOMAIN}/cdmi/CMS%201/file.txt?objectID"
    ```
    ```json
    {
        "objectID":"094576776E667431723230677767776C6B497031394E445F6E3868677873..."
    }
    ```
    >**NOTE:** Make sure to urlencode the path if used in URL, as in above example.
                                                                                                                                                                                                                                                                                                                                                                                        
    >**NOTE:** Please remember that according to CDMI protocol path to a directory must end with trailing slash. See more [here](cdmi.md#endpoints).


## File permissions

### Posix permissions
<!-- This header is referenced at least one time as "#posix-permissions" -->

### Access Control Lists
<!-- This header is referenced at least one time as "#access-control-lists" -->

## File distribution  <!-- link to replication & migration -->

## Interfaces

### Oneclient <!-- TODO: link to Oneclient -->

### CDMI <!-- short description + link -->

### GUI <!-- screenshots -->
