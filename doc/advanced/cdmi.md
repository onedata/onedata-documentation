
# CDMI

Onedata supports file operations via Cloud Data Management Interface (CDMI), version 1.1.1.
CDMI provides a universal, vendor-agnostic interface for discovering capabilities of storage providers, managing Cloud storage and basic data access mechanism.
For more information about CDMI please visit official CDMI [website](http://www.snia.org/cdmi).

CDMI uses certain terms such as dataobject or container to refer to various elements of storage, the mapping between main CDMI and Onedata concepts is as follows:

| CDMI concept | Onedata concept                                                                                                                                |
|:-------------|:-----------------------------------------------------------------------------------------------------------------------------------------------|
| Data object  | Data objects in Onedata are basic files stored in user's Spaces                                                                                |
| Container    | Both spaces and folders in Onedata are referred to as containers in CDMI                                                                   |
| ACL          | Onedata currently supports setting permissions for users and groups for read, write and execute access. ACL inheritance is also not supported. |


The list of currently supported operations is presented below:

| Operations                       | Capabilities                                                                                                                  |
|:---------------------------------|:------------------------------------------------------------------------------------------------------------------------------|
| Basic object GET, PUT, DELETE    | *cdmi_dataobjects, cdmi_read_value, cdmi_modify_value, cdmi_delete_dataobject*|
| Basic container GET, PUT, DELETE | *cdmi_list_children, cdmi_create_container, cdmi_delete_container*|
| Metadata (container&dataobject)  | *cdmi_read_metadata, cdmi_modify_metadata, cdmi_size, cdmi_atime, cdmi_mtime, cdmi_ctime* |
| Access control lists (rwx*)      | *cdmi_acl*    |
| Big folders                      | *cdmi_list_children_range* |
| Move and copy                    | *cdmi_move_dataobject_by_ID*, *cdmi_copy_dataobject_by_ID*|
| File System Export               | CDMI filesystem export is not supported. Instead, Onedata provides a custom Fuse client which is more efficient and reliable. |
| Big files                        | *cdmi_read_value_range, cdmi_modify_value_range* |
| Access by ObjectID               | *cdmi_object_access_by_ID* |

## Examples of usage

### Generation of access token
In order to use Onedata CDMI, an active Onedata access token must be provided. The access token can be generated either in the Web GUI, in the **Access Tokens** menu:

![Access Tokens](../img/access_token_creation.png)

or using Onedata REST API (if basic authentication is available for the user account):

```bash
export ONEZONE_HOST=<ONEZONE IP ADDRESS>

curl -k -X GET -u username:password "https://$ONEZONE_HOST/api/v3/onezone/user/client_token"


{"token": "MDAxNWxvY2F00aW9uIG9uZXpvbmUKMDAzYmlkZW500aWZpZXIgam9LZGVIMFpldVdhVzY00ZmF6bkFkU009jZk5JejJvSzBaRU5tNlptWTJlYwowMDFhY2lkIHRpbWUgPCAxNTA00MDExODMwCjAwMmZzaWduYXR1cmUgtHHSpfXzfWZUI42uHPXf6b87asof1clOAqBe4prCIXkK"}
```

For the sake of examples, we assume that the following additional environment variables are exported (where `ACCESS_TOKEN` is the value obtained in the previous step). Please note, that CDMI should be called directly on Oneprovider service instances and not Onezone service, which are usually on different hosts:

```bash
export ACCESS_TOKEN="MDAxNWxvY2F00aW9uIG9uZXpvbmUKMDAzYmlkZW500aWZpZXIgam9LZGVIMFpldVdhVzY00ZmF6bkFkU009jZk5JejJvSzBaRU5tNlptWTJlYwowMDFhY2lkIHRpbWUgPCAxNTA00MDExODMwCjAwMmZzaWduYXR1cmUgtHHSpfXzfWZUI42uHPXf6b87asof1clOAqBe4prCIXkK"

export TOKEN_HEADER="X-Auth-Token: $ACCESS_TOKEN"

export CDMI_VSN_HEADER='X-CDMI-Specification-Version: 1.1.1'

export ONEPROVIDER_HOST=<ONEPROVIDER IP ADDRESS>

export ENDPOINT=https://$ONEPROVIDER_HOST/cdmi
```


### Dataobject GET, PUT, DELETE

When referencing dataobjects or containers through CDMI, please remember that Onedata organizes all data into spaces. In our case, using *$ENDPOINT/file.txt* will address file *file.txt* in home space and using *$ENDPOINT/spaces/TestSpace/file.txt* will address file *file.txt* in space *TestSpace*.


##### CDMI PUT request
Create new file `test.txt` in space `test` with content `Test content`:
```bash
curl -k -H $TOKEN_HEADER -H $CDMI_VSN_HEADER -H 'Content-Type: application/cdmi-object'  \
-X PUT -d '{"value": "Test content"}' "$ENDPOINT/test/test.txt"


{
    "objectType":"application/cdmi-object",
    "objectID":"000000000055D4E4836803640004677569646D00000016726D75766662565765386857595139592D594E736C676D0000002B43592D347247454C535F6638574B2D616B4E305F6F6D556164636F6B336E745443673471686E787172594D",
    "objectName":"test.txt",
    "parentURI":"/test/",
    "parentID":"00000000008E4440836803640004677569646D0000004F673267435A4141466333426859325674414141414B304E5A4C5452795230564D5531396D4F46644C4C574672546A4266623231565957526A6232737A626E52555132633063576875654846795755306D0000002B43592D347247454C535F6638574B2D616B4E305F6F6D556164636F6B336E745443673471686E787172594D",
    "capabilitiesURI":"cdmi_capabilities/dataobject/",
    "completionStatus":"Complete",
    "metadata":{
        "cdmi_size":"12",
        "cdmi_ctime":"2016-08-29T14:17:39Z",
        "cdmi_atime":"2016-08-29T14:17:38Z",
        "cdmi_mtime":"2016-08-29T14:17:39Z",
        "cdmi_owner":"1965822"
    },
    "mimetype":"application/octet-stream"
}
```


##### CDMI GET encoding, mimetype and filename
Get selected `test.txt` attributes:

```bash
curl -k -H $TOKEN_HEADER -H $CDMI_VSN_HEADER \
-X GET "$ENDPOINT/test/test.txt?valuetransferencoding;mimetype;objectName"


{
    "valuetransferencoding":"utf-8",
    "mimetype":"application/octet-stream",
    "objectName":"test.txt"
}
```


##### CDMI PUT request
Create new directory `dirtest` in `test` space (the trailing slash is required):
```bash
curl -k -H $TOKEN_HEADER -H $CDMI_VSN_HEADER \
-H 'Content-Type: application/cdmi-container' -X PUT "$ENDPOINT/test/dirtest/"


{
    "objectType":"application/cdmi-container",
    "objectID":"000000000055276D836803640004677569646D00000016424C4D75757A4266454D74535233646D38395A3369516D0000002B43592D347247454C535F6638574B2D616B4E305F6F6D556164636F6B336E745443673471686E787172594D",
    "objectName":"dirtest/",
    "parentURI":"/test/",
    "parentID":"00000000008E4440836803640004677569646D0000004F673267435A4141466333426859325674414141414B304E5A4C5452795230564D5531396D4F46644C4C574672546A4266623231565957526A6232737A626E52555132633063576875654846795755306D0000002B43592D347247454C535F6638574B2D616B4E305F6F6D556164636F6B336E745443673471686E787172594D",
    "capabilitiesURI":"cdmi_capabilities/container/",
    "completionStatus":"Complete",
    "metadata":{
        "cdmi_size":"0",
        "cdmi_ctime":"2016-08-29T14:26:49Z",
        "cdmi_atime":"2016-08-29T14:26:49Z",
        "cdmi_mtime":"2016-08-29T14:26:49Z",
        "cdmi_owner":"1965822"
    },
    "childrenrange":"",
    "children":[]
}
```

### Container DELETE

CDMI delete container (directory):
```bash
curl -k -H $TOKEN_HEADER -H $CDMI_VSN_HEADER \
-H 'Content-Type: application/cdmi-container' -X DELETE "$ENDPOINT/Space1/dir2/"
```


### Metadata - example

##### Setting custom metadata

Add `meta1` and `meta2` metadata propertie sto `test.txt`:
```bash
curl -k -H $TOKEN_HEADER -H $CDMI_VSN_HEADER -H 'Content-Type: application/cdmi-object' \
-d '{"metadata" : {"meta1" : "val1", "meta2" : "val2"}}' \
-X PUT "$ENDPOINT/test/test.txt"
```

##### Getting previously inserted metadata by prefix
Get the value of `meta1` attribute for `test.txt` file:
```bash
curl -k -H $TOKEN_HEADER -H $CDMI_VSN_HEADER -X GET "$ENDPOINT/test/test.txt?metadata:meta1"


{
    "metadata": {
        "meta1":"val1"
    }
}
```

### ACL management

Access control lists provide mechanism for granting and prohibiting access to data on a space, directory and file levels. Onedata supports the complete ACL functionality of CDMI, which can be also managed through the Web GUI.

In CDMI, ACL's are stored as cdmi_acl metadata. An object with unset ACL, has virtual ACL which contains entries for every space member, that gives him permissions equal to POSIX file mode. ACL permissions always take precedence over POSIX style permissions.

A single Access Control Entry contains:
 * Type – **ALLOW** | **DENY**
 * Identifier – **[USERNAME#]IDENTIFIER**
 * Flags – **NO_FLAGS** | **IDENTIFIER_GROUP**
 * Mask – **READ_OBJECT** | **LIST_CONTAINER** | **WRITE_OBJECT** | **ADD_OBJECT** | **ADD_SUBCONTAINER** | **READ_METADATA** | **WRITE_METADATA** | **EXECUTE** | **TRAVERSE_CONTAINER** | **DELETE_OBJECT** | **DELETE_SUBCONTAINER** | **READ_ATTRIBUTES** | **WRITE_ATTRIBUTES** | **WRITE_RETENTION** | **DELETE** | **READ_ACL** | **WRITE_ACL** | **WRITE_OWNER**

Identifier must contain the full Onedata user ID. Optionally the **USERNAME** can be provided before the `#`, but this is only for informational purposes.

Onedata user ID can be easily extracted using Onezone REST API:
```bash
curl -k -S -X GET -H "X-Auth-Token: ${ACCESS_TOKEN}" https://$ONEZONE_HOST/api/v3/onezone/user

{
    "userId":"6vLIkkTRQKGzzZs-ZNRF1vcTfC_NekD4ucSg18cnt7A",
    "name":"admin",
    "alias":"johnd",
    "emails":[],
    "linkedAccounts":[],
}
```

Flag **IDENTIFIER_GROUP** indicates group name in identifier.


#### ACL CDMI modification
Create an Access Control Entry (ACE) list for file `test.txt`, specifying that:
* User `John Johnson` can read and write the file

First create a file `acl.json` with the following content:
```json
{
  "metadata":{
      "cdmi_acl":[
         {
            "acetype":"0x00",
            "identifier":"#6vLIkkTRQKGzzZs-ZNRF1vcTfC_NekD4ucSg18cnt7A",
            "aceflags":"0x01",
            "acemask": "0x03"
         }
      ]
   }
}
```

and then set the `cdmi_acl` property of the `test.txt` dataobject:
```bash
curl -k -H $TOKEN_HEADER -H $CDMI_VSN_HEADER -H 'Content-Type: application/cdmi-object' \
-d @acl.json -X PUT "$ENDPOINT/test/test.txt?metadata:cdmi_acl"
```

The `acemask` field can also be specified using mask string expressions, as specified by CDMI specification.

### CDMI children objects

List children of `dirtest` directory in space `test`:
```bash
curl -k -H $TOKEN_HEADER -H $CDMI_VSN_HEADER \
-X GET "$ENDPOINT/test/dirtest/?children:0-2;childrenrange"


{
    "children":[
        "test1.txt",
        "test2.txt",
        "test3.txt"
    ],
    "childrenrange":"0-2"
}
```


### Move and copy - example
Copy directory (CDMI container) `dirtest` to directory `dirtest2`:

```bash
curl -k -H $TOKEN_HEADER -H $CDMI_VSN_HEADER -H 'Content-Type: application/cdmi-container' \
-d '{"copy" : "/dirtest/"}' -X PUT $ENDPOINT/dirtest2/
```


### CDMI partial upload

CDMI since version 1.0.2 provides support for partial uploads, where a subrange of *value* field can be provided as a long as byte range that is submitted is specified using URL attribute `?value:START_OFFSET-END_OFFSET`.

The value must be provided in Base64 (as it can be a binary dataobject).

Change first 4 bytes of `test.txt` file to "ABCD":
```bash
echo -n ABCD | base64

QUJDRA==
```

```bash
curl -k -H $TOKEN_HEADER -H $CDMI_VSN_HEADER -H 'Content-Type: application/cdmi-object' \
-H 'X-CDMI-Partial: true' -X PUT -d '{"value": "QUJDRA=="}' \
"$ENDPOINT/test/test.txt?value:0-3"
```

### HTTP range read
Get the first 4 bytes from the file directly using HTTP range read:
```bash
curl -k -H $TOKEN_HEADER -H 'Range: 0-3' -X GET "$ENDPOINT/test/test.txt"

ABCD
```

### Access by ObjectID
Every object has unique id, and can be accessed by URI `/cdmi_objectid/OBJECT_ID`.

Get CDMI ID of `dirtest` folder:
```bash
curl -k -H $TOKEN_HEADER -H $CDMI_VSN_HEADER -X GET $ENDPOINT/test/dirtest/?objectID


{"objectID":"000000000055B7D1836803640004677569646D000000165F7647654E5A50676438555061434575484567712D516D0000002B43592D347247454C535F6638574B2D616B4E305F6F6D556164636F6B336E745443673471686E787172594D"}
```

Add new file to the `dirtest` folder using ID:
```bash
curl -k -H $TOKEN_HEADER -H $CDMI_VSN_HEADER -H 'Content-Type: application/cdmi-object' \
-X PUT -d '{"value": "val"}' "$ENDPOINT/cdmi_objectid/000000000055B7D1836803640004677569646D000000165F7647654E5A50676438555061434575484567712D516D0000002B43592D347247454C535F6638574B2D616B4E305F6F6D556164636F6B336E745443673471686E787172594D/test10.txt"


{
    "objectType":"application/cdmi-object",
    "objectID":"0000000000557F7B836803640004677569646D00000016666B5373794258327952616A6E3067744443495274516D0000002B43592D347247454C535F6638574B2D616B4E305F6F6D556164636F6B336E745443673471686E787172594D",
    "objectName":"test10.txt",
    "parentURI":"/test/dirtest/",
    "parentID":"000000000055B7D1836803640004677569646D000000165F7647654E5A50676438555061434575484567712D516D0000002B43592D347247454C535F6638574B2D616B4E305F6F6D556164636F6B336E745443673471686E787172594D",
    "capabilitiesURI":"cdmi_capabilities/dataobject/",
    "completionStatus":"Complete",
    "metadata":{
        "cdmi_size":"3",
        "cdmi_ctime":"2016-08-29T15:45:04Z",
        "cdmi_atime":"2016-08-29T15:45:03Z",
        "cdmi_mtime":"2016-08-29T15:45:04Z",
        "cdmi_owner":"1965822"
    },
    "mimetype":"application/octet-stream"
}
```

