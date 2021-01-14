# Data
<!-- This file is referenced at least one time as "data.md" -->

## File path and Id
<!-- This header is referenced at least one time as "#file-path-and-id" -->

### File path
<!-- This header is referenced at least one time as "#file-paths" -->
It is recommended to use [file Ids](#file-id) to identify files, although some endpoints allow working with paths. 
When referencing files or directories (also called dataobjects or containers in CDMI) by path, 
please remember that Onedata organizes all data into spaces, and space name is the first element of 
the file path. Consider this example:
```shell script
/CMS%201/file.txt
```
`CMS 1` is the space name and `/file.txt` is the absolute path in this space.

>**NOTE:** Make sure to urlencode the path if used in URL, as in above example.

### File Id
<!-- This header is referenced at least one time as "#file-id" -->

File Id is a unique, global identifier associated with a file or directory and
can be used universally in the CDMI and REST APIs. There are several ways to 
find out the file Id of given file or directory:

1. Web GUI - click on Information in the file/directory context menu and look 
for `File ID`
![image](../../images/user-guide/data/file-information.png)

2. REST API - use the file Id resolution endpoint. Below example returns the 
file Id of file `/CMS 1/file.txt`, where `CMS 1` is the space name 
(see [file paths](#file-path)):
```bash 
curl -H "X-Auth-Token: ${ACCESS_TOKEN}" \
     -X POST "https://$ONEPROVIDER_DOMAIN/api/v3/oneprovider/lookup-file-id/CMS%201/file.txt"
```

```json 
{
  "fileId": "094576776E667431723230677767776C6B497031394E445F6E3868677873..."
}
```

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
