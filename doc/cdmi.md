
# CDMI

Onedata supports file operations via Cloud Data Management Interface (CDMI), version 1.0.2. 
CDMI provides a universal, vendor-agnostic interface for discovering capabilities of storage providers, managing Cloud storage and basic data access mechanism. 
For more information about CDMI please visit official CDMI [website](http://www.snia.org/cdmi).

CDMI uses certain terms such as dataobject or container to refer to various elements of storage, the mapping between main CDMI and Onedata concepts is as follows:

| CDMI concept | Onedata concept|
|:--------------------------------|:-------|
| Data object | Data objects in Onedata are basic files stored in user's Spaces|
| Container | Both Space and directories in Onedata are referred to as containers via CDMI |
| ACL | Onedata currently supports setting permissions for users and groups for read, write and execute access. ACL inheritance is also not supported. |


The list of currently supported operations is presented below:

| Operations                       | Capabilities                                                                            |
|:---------------------------------|:----------------------------------------------------------------------------------------|
| Basic object GET, PUT, DELETE      | *cdmi_dataobjects, cdmi_read_value, cdmi_modify_value, cdmi_delete_dataobject*            |
| Basic container GET, PUT, DELETE   | *cdmi_list_children, cdmi_create_container, cdmi_delete_container* |
| Metadata (container&dataobject)  | *cdmi_read_metadata, cdmi_modify_metadata, cdmi_size, cdmi_atime, cdmi_mtime, cdmi_ctime* |
| Access control lists (rwx*)       | *cdmi_acl* |
| Big folders                      | *cdmi_list_children_range* |
| File System Export | CDMI filesystem export is not supported. Instead, Onedata provides a custom Fuse client which is more efficient and reliable. |
| Move and copy                    | *cdmi_move_container, cdmi_move_dataobject,  cdmi_copy_container, cdmi_copy_dataobject*                                 |
| Big files                        | *cdmi_read_value_range, cdmi_modify_value_range*                                          |
| Access by ObjectID               | *cdmi_object_access_by_ID*                                                                |

## Examples of usage

### Generation of access token
In order to use Onedata CDMI interface, a unique access token has to be generated using authorization code which can be obtained from the Onedata Web GUI. Using the authorization code, the access token can be obtained using Onedata REST API. First you will need however to set your Onedata alias name, which can be found in the **Manage account** page in the Web GUI.

~~~
> export AUTHORIZATION_CODE=<GENERATED_CODE>

> export ONE_HOST=<YOUR_ALIAS>

> export ONE_HOST=$ONE_ALIAS.onedata.org

> curl -k -X POST -H 'Content-Type: application/json' -d "{\"code\" : \"$AUTHORIZATION_CODE\", \"client_name\" : \"cdmi_client\"}" https://$ONE_HOST:8443/rest/latest/token
RES: {"accessToken":"<TOKEN>"}
~~~

*ONE_HOST environment variable can also point directly to a specific Oneprovider service. The URL can be obtained simply from the web browser when access the Web GUI interface of Onedata.*

Before running the below examples please export the following environment variables:
~~~
> export ACCESS_TOKEN=<TOKEN>

> export TOKEN_HEADER="x-auth-token: $ACCESS_TOKEN"

> export CDMI_VSN_HEADER='X-CDMI-Specification-Version: 1.0.2'

> export ENDPOINT=https://$ONE_HOST:8443/cdmi
~~~


### Dataobject GET PUT DELETE

When referencing dataobjects or containers through CDMI, please remember that Onedata organizes all data into spaces. In our case, using *$ENDPOINT/file.txt* will address file *file.txt* in default space and using *$ENDPOINT/spaces/TestSpace/file.txt* will address file *file.txt* in space *TestSpace*. 


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

### Container GET PUT DELETE

CDMI create container (directory) 
~~~
curl -k -H $TOKEN_HEADER -H $CDMI_VSN_HEADER -H 'Content-Type: application/cdmi-container' -X PUT $ENDPOINT/dir2/
~~~


### Metadata - example
##### Setting custom metadata
~~~
> curl -k -H $TOKEN_HEADER -H $CDMI_VSN_HEADER -H 'Content-Type: application/cdmi-object' -d '{"metadata" : {"meta1" : "val1", "meta2" : "val2"}}' -X PUT  $ENDPOINT/file.txt
~~~

##### Getting previously inserted metadata by prefix
~~~
> curl -k -H $TOKEN_HEADER -H $CDMI_VSN_HEADER -X GET "$ENDPOINT/file.txt?metadata:meta"
~~~

### ACL management

Access control lists provide mechanism for granting and prohibiting access to data on space, directory and file levels. Onedata supports the complete ACL functionality of CDMI, which can be also managed through the Web GUI.


In CDMI, ACL's are stored as cdmi_acl metadata. An object with unset ACL, has virtual ACL which contains entries for every space member, that gives him permissions equal to POSIX file mode. ACL permissions always take precedence over POSIX style permissions.

A single Access Control Entry contains:
 * Type – **ALLOW** | **DENY**
 * Identifier – **USERNAME[#HASH]** | **GROUPNAME[#HASH]**
 * Flags – **NO_FLAGS** | **IDENTIFIER_GROUP**
 * Mask – {**READ**, **WRITE**, **EXECUTE**}

Identifier may be followed by optional ID prefix hash, to distinguish users/groups with the same name.

Flag **IDENTIFIER_GROUP** indicates group name in identifier. Mask may contain any combination of *rwx* permissions i.e. **READ**, **WRITE**, **EXECUTE**.


#### ACL CDMI modification
~~~
> curl -k -H $TOKEN_HEADER -H $CDMI_VSN_HEADER -H 'Content-Type: application/cdmi-object' -d '{"metadata" : {"cdmi_acl":[
{"acetype":"ALLOW","identifier":"Tomasz Lichon", "aceflags":"NO_FLAGS","acemask":"READ, WRITE"}, {"acetype":"ALLOW","identifier":"Lukasz Dutka", "aceflags":"NO_FLAGS","acemask":"READ"}]}}' -X PUT  $ENDPOINT/file.txt\?metadata:cdmi_acl
~~~

### Big folders - example
List first child of „spaces” container
~~~
> curl -k -H $TOKEN_HEADER -H $CDMI_VSN_HEADER -X GET "$ENDPOINT/spaces/?children:0-0;childrenrange"
~~~

### File System Export (FUSE client)

Onedata does not support CDMI file system export, but has its own dedicated FUSE client, which can be installed and mounted in filesystem.

Installation instructions can be found on our [website](https://onedata.org/download).

### Move and copy - example
Copy directory (CDMI container) *dir* to directory *dir3*
~~~
> curl -k -H $TOKEN_HEADER -H $CDMI_VSN_HEADER -H 'Content-Type: application/cdmi-container' -d '{"copy" : "/dir/"}' -X PUT $ENDPOINT/dir-copy/
~~~
### CDMI partial upload

CDMI since version 1.0.2 provides support for partial uploads, where a subrange of *value* field can be provided as long as byte range that is submitted is specified using URL attribute **?value:START_OFFSET-END_OFFSET**
~~~
> curl -k -H $TOKEN_HEADER -H $CDMI_VSN_HEADER -H 'Content-Type: application/cdmi-object'  -H 'X-CDMI-Partial: true' -X PUT -d '{"value": "MDEy"}' $ENDPOINT/partial_test.txt\?value:0-2

> curl -k -H $TOKEN_HEADER -H $CDMI_VSN_HEADER -H 'Content-Type: application/cdmi-object'  -H 'X-CDMI-Partial: false' -X PUT -d '{"value": "MzQ1Ng=="}' $ENDPOINT/partial_test.txt\?value:3-6
~~~

### HTTP range read

~~~
> curl -k -H $TOKEN_HEADER -H 'Range: 0-3' -X GET $ENDPOINT/partial_test.txt
~~~

### Access by ObjectID
Every object has unique id, and can be accessed by URI “/cdmi_objectid/OBJECT_ID”
~~~
# get objectid
> curl -k -H $TOKEN_HEADER -H $CDMI_VSN_HEADER -X GET $ENDPOINT/dir/\?ObjectID
RES:{"objectID":"<ID>"}

# perform post request
> curl -k -H $TOKEN_HEADER -H $CDMI_VSN_HEADER -H 'Content-Type: application/cdmi-object' -X PUT -d '{"value":"val"}' $ENDPOINT/cdmi_objectid/<ID>/new_file
~~~

<!-- ### Authorization via certificates
Generate .pem encoded public key from your certificate -->
