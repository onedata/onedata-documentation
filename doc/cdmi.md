
# CDMI

Onedata supports file operations via Cloud Data Management Interface (CDMI), version 1.1.1. 
CDMI provides a universal, vendor-agnostic interface for discovering capabilities of storage providers, managing Cloud storage and basic data access mechanism. 
For more information about CDMI please visit official CDMI [website](http://www.snia.org/cdmi).

The mapping between CDMI and Onedata concepts is as follows:

| CDMI concept | Onedata concept|
|:--------------------------------|:-------|
| Data object | Data objects in Onedata are basic files stored in user's Spaces|
| Container | Both Space and directories in Onedata are referred to as containers via CDMI |
| ACL | Onedata supports full CDMI Access Control List mechanism |
| | |

The list of currently supported operations is presented below:

| Operations                       | Capabilities                                                                            |
|:---------------------------------|:----------------------------------------------------------------------------------------|
| Basic object GET, PUT, DELETE      | cdmi_dataobjects, cdmi_read_value, cdmi_modify_value, cdmi_delete_dataobject            |
| Basic container GET, PUT, DELETE   | cdmi_list_children, cdmi_create_container, cdmi_delete_container                        |
| Metadata (container&dataobject)  | cdmi_read_metadata, cdmi_modify_metadata, cdmi_size, cdmi_atime, cdmi_mtime, cdmi_ctime |
| Access control lists (rwx)       | cdmi_acl |
| Big folders                      | cdmi_list_children_range |
| File System Export (FUSE client) | -                                                                                       |
| Move and copy                    | cdmi_move_container, cdmi_move_dataobject,  cdmi_copy_container, cdmi_copy_dataobject                                 |
| Big files                        | cdmi_read_value_range, cdmi_modify_value_range                                          |
| Access by ObjectID               | cdmi_object_access_by_ID                                                                |

## Examples of usage

### Generation of access token
In order to use Onedata CDMI interface, a unique access token has to be generated using authentication code which can be obtained from the Onedata Web GUI. Using the authentication code, the access token can be obtained from the command line

~~~
export AUTHENTICATION_CODE=<GENERATED_CODE>
> curl -k -X POST -H 'Content-Type: application/json' -d "{\"code\" : \"$AUTHENTICATION_CODE\", \"client_name\" : \"cdmi_client\"}" https://plgdutka.onedata.org:8443/rest/latest/token
RES: {"accessToken":"<TOKEN>"}
~~~

Before running the below examples please export the following environment variables:
~~~
export ACCESS_TOKEN=<TOKEN>
export TOKEN_HEADER="x-auth-token: $ACCESS_TOKEN"
export CDMI_VSN_HEADER='X-CDMI-Specification-Version: 1.0.2'
export ENDPOINT=https://plgdutka.onedata.org:8443/cdmi
~~~


### Basic object GET PUT DELETE - example


##### CDMI PUT request
~~~
> curl -k -H $TOKEN_HEADER -H $CDMI_VSN_HEADER -H 'Content-Type: application/cdmi-object'  -X PUT -d '{"value":"file content"}' $ENDPOINT/file.txt
~~~



##### CDMI GET encoding, mimetype and filename
~~~
> curl -k -H $TOKEN_HEADER -H $CDMI_VSN_HEADER -X GET "$ENDPOINT/file.txt?valuetransferencoding;mimetype;objectName"
~~~


##### CDMI PUT request
~~~
> curl -k -H $TOKEN_HEADER -H $CDMI_VSN_HEADER -H 'Content-Type: application/cdmi-container' -X PUT $ENDPOINT/dir2/
~~~

### Metadata - example
##### Setting custom metadata:
~~~
> curl -k -H $TOKEN_HEADER -H $CDMI_VSN_HEADER -H 'Content-Type: application/cdmi-object' -d '{"metadata" : {"meta1" : "val1", "meta2" : "val2"}}' -X PUT  $ENDPOINT/file.txt
~~~

##### Getting previously inserted metadata by prefix
~~~
> curl -k -H $TOKEN_HEADER -H $CDMI_VSN_HEADER -X GET "$ENDPOINT/file.txt?metadata:meta"
~~~

### ACL management

Access control lists provide mechanism for granting and prohibiting access to data on space, directory and file levels. Onedata supports the complete ACL functionality of CDMI, which can be also managed through the Web GUI.


ACL's are stored as cdmi_acl metadata
An object with unset ACL, has virtual ACL which contains entries for every space member, that gives him permissions equal to posix file mode
If we explicitly set ACL, the posix mode is no longer used
A single Access Control Entry contains:
Type – ALLOW | DENY
Identifier – USERNAME[#HASH] | GROUPNAME[#HASH]
Flags – NO_FLAGS | IDENTIFIER_GROUP
Mask – {READ, WRITE, EXECUTE}
Identifier may be followed by optional id prefix hash, to distinguish equal names
Flag IDENTIFIER_GROUP indicates group name in identifier. Mask may contain any combination of rwx perms i. e. “READ, WRITE, EXECUTE”


### Access control lists - example
##### ACL cdmi modification
~~~
> curl -k -H $TOKEN_HEADER -H $CDMI_VSN_HEADER -H 'Content-Type: application/cdmi-object' -d '{"metadata" : {"cdmi_acl":[
{"acetype":"ALLOW","identifier":"Tomasz Lichoń", "aceflags":"NO_FLAGS","acemask":"READ, WRITE"}, {"acetype":"ALLOW","identifier":"Lukasz Dutka", "aceflags":"NO_FLAGS","acemask":"READ"}]}}' -X PUT  $ENDPOINT/file.txt\?metadata:cdmi_acl
~~~

### Big folders - example
List first child of „spaces” container
~~~
> curl -k -H $TOKEN_HEADER -H $CDMI_VSN_HEADER -X GET $ENDPOINT/spaces/\?children:0-0;childrenrange
~~~

### File System Export (FUSE client)
~~~
onedata does not support cdmi file system export, but has its own dedicated fuse client, which can be installed and mounted in filesystem
Installation instruction can be found in our website

###Move and copy - example
Container copy
~~~
> curl -k -H $TOKEN_HEADER -H $CDMI_VSN_HEADER -H 'Content-Type: application/cdmi-container' -d '{"copy" : "/dir/"}' -X PUT $ENDPOINT/dir3/

### Big files - example
##### CDMI partial upload
~~~
> curl -k -H $TOKEN_HEADER -H $CDMI_VSN_HEADER -H 'Content-Type: application/cdmi-object'  -H 'X-CDMI-Partial: true' -X PUT -d '{"value" : "MDEy"}' $ENDPOINT/partial\?value:0-2
> curl -k -H $TOKEN_HEADER -H $CDMI_VSN_HEADER -H 'Content-Type: application/cdmi-object'  -H 'X-CDMI-Partial: false' -X PUT -d '{"value" : "MzQ1Ng=="}' $ENDPOINT/partial\?value:3-6
~~~

##### HTTP range read
~~~
> curl -k -H $TOKEN_HEADER -H 'Range: 0-3' -X GET $ENDPOINT/partial
~~~

### Access by ObjectID
Every object has unique id, and can be accessed by URI “/cdmi_objectid/<ObjectID>”
~~~
# get objectid
> curl -k -H $TOKEN_HEADER -H $CDMI_VSN_HEADER -X GET $ENDPOINT/dir/\?ObjectID
RES:{"objectID":"<ID>"}

# perform post request
> curl -k -H $TOKEN_HEADER -H $CDMI_VSN_HEADER -H 'Content-Type: application/cdmi-object' -X PUT -d '{"value":"val"}' $ENDPOINT/cdmi_objectid/<ID>/new_file
~~~

<!-- ### Authorization via certificates
Generate .pem encoded public key from your certificate -->
