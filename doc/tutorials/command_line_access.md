# Onedata Command Line Access Tutorial

* [Overview](#overview)
* [Prerequisites](#prerequisites)
* [Authentication](#authentication)
* [Account management](#account_management)
* [Space management](#space_management)
* [Group management](#group_management)
* [Data management](#data_management)
* [Metadata management](#metadata_management)

## Overview {#overview}
This tutorial section presents how to manage Onedata platform and access user data solely from command line, using Onedata's REST and CDMI API's as well as *oneclient* command line tool for mounting virtual Onedata filesystem on the local machine.

## Prerequisites {#prerequisites}
This tutorial assumes the Onedata is already deployed and the following tools are available on the local machine:

* Onedata account
* [oneclient](onedata.org)
* [cURL](https://curl.haxx.se/)
* [jsawk](https://github.com/micha/jsawk)

Before proceeding first set the following environment variables:
```bash
export ONEZONE_HOST=<ONEZONE IP ADDRESS>:8443
export CDMI_VSN_HEADER='X-CDMI-Specification-Version: 1.1.1'
```

## Authentication {#authentication}

Onedata authentication is based on authentication tokens. In order to proceed with the next steps it is necessary to generate an access token for an active user account. 

The access token can be generated either in the Web GUI, in the **Access Tokens** menu:

![Access Tokens](../img/access_token_creation.png)

or using Onedata REST API (if basic authentication is available for the user account):

```bash
export ONEDATA_TOKEN=`curl -Ssk -X GET -u admin:Password1 \
"https://$ONEZONE_HOST/api/v3/onezone/user/client_token" \
| jsawk "return this.token"`
```

Check if the token has been generated successfully. From now on we can use it for authenticating all requests to Onedata.
```bash
echo $ONEDATA_TOKEN

MDAxNWxvY2F00aW9uIG9uZXpvbmUKMDAzYmlkZW500aWZpZXIgNWtjVmZJLXgxSjR2TUZQMUt5aEhwQTdkOWVhbXdfVTRpdG1aSFppTkV5cwowMDFhY2lkIHRpbWUgPCAxNTA00MjY1NzU5CjAwMmZzaWduYXR1cmUgXOsXPG9oHKRpzoLP7f9smAW8tsWS7OI3D5Hw25T00IfwK
```


## Account management {#account_management}

First of all, we can retrieve basic user account information using REST API:
```bash
curl -Ssk -X GET -H "macaroon: ${ONEDATA_TOKEN}" https://$ONEZONE_HOST/api/v3/onezone/user

{
    "userId":"6vLIkkTRQKGzzZs-ZNRF1vcTfC_NekD4ucSgR8cnt7A",
    "login":"admin",
    "name":"admin",
    "connectedAccounts":[],
    "alias":"",
    "emailList":[]
}
```

and modify some of the properties, for instance user alias to `user1`:
```bash
curl -Ssk -X PATCH -H "macaroon: ${ONEDATA_TOKEN}" \
-d '{"alias": "user1"}' -H "Content-type: application/json" \
https://$ONEZONE_HOST/api/v3/onezone/user
```

## Space management {#space_management}
All space related functionality can be accessed through the REST API.

To see the list of all user spaces call:
```bash
curl -Ssk -X GET -H "macaroon: ${ONEDATA_TOKEN}" \
https://$ONEZONE_HOST/api/v3/onezone/user/spaces

{
    "spaces":
    ["CY-4rGELS_f8WK-akN0_omUadcok3ntTCg4qhnxqrYM","tPQ7uiCLeMUwe-V6ZD2Xv1mLlpN7gUmk4682exQ_bIY"],
    "default":"tPQ7uiCLeMUwe-V6ZD2Xv1mLlpN7gUmk4682exQ_bIY"
}
```
which returns the list of GUID's of spaces to which the user belongs and the ID of the home (default) space.

In order to get more information about a specific space use:
```bash
curl -Ssk -X GET -H "macaroon: ${ONEDATA_TOKEN}" \
https://$ONEZONE_HOST/api/v3/onezone/spaces/tPQ7uiCLeMUwe-V6ZD2Xv1mLlpN7gUmk4682exQ_bIY

{
    "spaceId":"tPQ7uiCLeMUwe-V6ZD2Xv1mLlpN7gUmk4682exQ_bIY",
    "name":"OSX Space",
    "canonicalName":"OSX Space",
    "providersSupports":{
        "bHvJ2yr1IjWnvSnrmh-0n-eC05MhBAHLJ0EkJbmyDUE":1073741824}
}
```
which returns basic space properties. 

Now we can simply change these properties, for instance the space's name:

```bash
echo '{"name": "Work"}' \
| curl -Ssk -X PATCH -H "macaroon: ${ONEDATA_TOKEN}" -H "Content-type: application/json" -d @- \
https://$ONEZONE_HOST/api/v3/onezone/spaces/tPQ7uiCLeMUwe-V6ZD2Xv1mLlpN7gUmk4682exQ_bIY
```

Furthermore, we can also create a new space, called `Personal files`. The newly create space GUID is returned in the `Location:` header (please note the `-vvv` argument which prints out the headers). The  :
```bash
echo '{"name": "Personal files"}' \ 
| curl -Ssk -X POST -H "macaroon: ${ONEDATA_TOKEN}" -d @- -H "Content-type: application/json" \
https://$ONEZONE_HOST/api/v3/onezone/user/spaces  -vvv

...
location: /spaces/HVX8jhZ0GNZBCiCxit06da6IVIYOqOKFfod46FV4wBw
...
```

Now we can check the properties of the space, in particular see if there are any providers supporting the space:

```bash
curl -Ssk -X GET -H "macaroon: ${ONEDATA_TOKEN}" \
https://$ONEZONE_HOST/api/v3/onezone/user/spaces/HVX8jhZ0GNZBCiCxit06da6IVIYOqOKFfod46FV4wBw \
| jsawk 'return "Space \"" + this.name +"\" is supported by " + this.providersSupports.length + " providers."' | cowsay


Space "Personal files" is supported by 0 providers.
```

Since by default all newly created spaces in Onedata have no storage support, a storage support must be requested from some provider. The request token can be generated using this command:

```bash
curl -Ssk -X GET -H "macaroon: ${ONEDATA_TOKEN}" \
https://$ONEZONE_HOST/api/v3/onezone/spaces/HVX8jhZ0GNZBCiCxit06da6IVIYOqOKFfod46FV4wBw/providers/token \
| jsawk "return this.token"

MDAxNmxvY2F00aW9uIHJlZ2lzdHJ5CjAwM2JpZGVudGlmaWVyIGlHSnM4Qmo3UktqekQ3T00RFZUMwQkxMU00hYbl9ub00hscEs00SWx00Uk00wQVEKMDAyOGNpZCB00b2tlblR5cGUgPSBzcGFjZV9zdXBwb3J00X3Rva2VuCjAwMmZzaWduYXR1cmUgFprGihoQEQM3P7gWzsOq1lGvqwcKvowxnpdeeL012nxAK
```

This token has to be sent to the preferred storage provider who will grant the storage support.

## Group management {#group_management}

TODO

## Data management {#data_management}
Onedata provides several means for accessing the data including Web GUI (not covered here), REST and CDMI API's as well as direct POSIX access via *oneclient* tool.

First, let's select a space on which we'll be working on. For that we need to extract the ID of the space "Personal files":
```bash
curl -Ssk -X GET -H "macaroon: ${ONEDATA_TOKEN}" https://$ONEZONE_HOST/api/v3/onezone/user/spaces \
| jsawk 'return this.spaces.join("\n")' \
| xargs -n1 -I{} sh -c 'curl -Ssk -X GET -H "macaroon: ${ONEDATA_TOKEN}" https://$ONEZONE_HOST/api/v3/onezone/spaces/{} | jsawk "if (this.name == \"Personal files\") return this.spaceId; else return \"\""'

HVX8jhZ0GNZBCiCxit06da6IVIYOqOKFfod46FV4wBw
```

now we can export it as ONEDATA_SPACE environment variable:
```bash
export ONEDATA_SPACE=HVX8jhZ0GNZBCiCxit06da6IVIYOqOKFfod46FV4wBw
```

Since this is a new space, it is empty. We can mount this space directly to the local filesystem, but first we need to find an IP of the provider who supports our space:
```bash
curl -Ssk -X GET -H "macaroon: ${ONEDATA_TOKEN}" https://$ONEZONE_HOST/api/v3/onezone/spaces/$ONEDATA_SPACE \
| jsawk "return Object.keys(this.providersSupports)[0]" \
| xargs -n1 -I{} 'curl -Ssk -X GET -H "macaroon: ${ONEDATA_TOKEN}" https://$ONEZONE_HOST/api/v3/onezone/provider/{} | jsawk "return this.urls[0]"'

195.216.97.151
```


```bash
export PROVIDER_HOSTNAME=195.216.97.151
export ONEPROVIDER_HOST=$PROVIDER_HOSTNAME:8443
export ONECLIENT_ACCESS_TOKEN=$ONEDATA_TOKEN

mkdir ~/mnt`
mkdir ~/mnt/onedata
oneclient --authentication token --no_check_certificate ~/mnt/onedata
ls -la ~/mnt/onedata

total 0
drwxr-xr-x  1 root    wheel      0 Aug 25 23:29 .
drwxr-xr-x  4 bartek  staff    136 Aug 27 21:25 ..
drwxrwx---  1 root    1728123    0 Sep  1 14:11 Personal files
drwxrwx---  1 root    754053     0 Aug 30 13:34 Work
drwxrwx---  1 root    1785011    0 Aug 30 13:30 test
```

Now we can create some test files in the `Personal files` space:
```bash
echo "FILE1" > ~/mnt/onedata/Personal\ files/file1.txt
echo "FILE2" > ~/mnt/onedata/Personal\ files/file2.txt
echo "FILE3" > ~/mnt/onedata/Personal\ files/file3.txt
```


Now we can see the contents of the space using the following CDMI command:
```bash

```

TODO

## Metadata management {#metadata_management}

Onedata supports 3 levels of metadata (for more details see [here](../using_onedata/metadata.md)):
* Filesystem attributes
* Extended attributes
* User metadata

This section will present how to access and modify each of these metadata types:

### Filesystem attributes
Basic filesystem attributes are mostly read only properties defined dynamically by the data management system. 

For instance to get information about the file size, we can execute:
```bash
curl -k -H "X-Auth-Token: ${ONEDATA_TOKEN}" -H $CDMI_VSN_HEADER -X GET \
"https://$ONEPROVIDER_HOST/api/v3/oneprovider/cdmi/Personal%20files/test.txt?size"

...
```

### Extended attributes
Extended attributes provide means for adding simple key-value attributes to objects in the filesystem.

Extended attributes can be set using the REST API:
```bash
echo '{ "name": "license", "value": "CC-0" }' \
curl -Ssk -X PUT -H "X-Auth-Token: $ONEDATA_TOKEN" -H 'Content-type: application/json' -d @- \
"https://$ONEPROVIDER_HOST/api/v3/oneprovider/attributes/Personal%20files/file1.txt?extended=true"
```

which we can check from the command line using `xattr` command line tools:
```bash
## NOT SUPPORTED YET

# Linux
getfattr -n license ~/mnt/onedata/Personal\ files/file1.txt

# OSX
xattr -p license ~/mnt/onedata/Personal\ files/file1.txt
```


### User metadata
The last type of metadata, allows users to store any JSON or RDF documents. Currently, JSON metadata backend supports complete querying and indexes, while RDF only allows storage of valie RDF documents attached to data objects.

#### JSON
In order to add custom JSON document to a file:
```bash
echo '{"key1": "value1", "key2": 2, "key3": ["a1", "a2", "a3"]}' \
| curl -Ssk -X PUT -H "X-Auth-Token: $ONEDATA_TOKEN" -H 'Content-type: application/json' -d @- \
"https://$ONEPROVIDER_HOST/api/v3/oneprovider/metadata/Personal%20files/file1.txt"
```

Now in order to get the second element of the `key3` array:
```bash
curl -Ssk -X GET -H "X-Auth-Token: $ONEDATA_TOKEN" \
"https://$ONEPROVIDER_HOST/api/v3/oneprovider/metadata/Personal%20files/file1.txt?filter_type=keypath&filter=key3.\[2\]"

"a2"
```

In a similar vein, we can modify only a selected key in the JSON metadata document:
```bash
echo 5 \
| curl -Ssk -X PUT -H "X-Auth-Token: $ONEDATA_TOKEN" -H 'Content-type: application/json' -d @- \
"https://$ONEPROVIDER_HOST/api/v3/oneprovider/metadata/Personal%20files/file1.txt?filter_type=keypath&filter=key2"
```

For larger data sets, it might be necessary to create an index, which enables efficient data discovery based on JSON metadata.

An index can be created using REST API:
```bash
echo 'TODO' \
| curl -H "X-Auth-Token: $ONEDATA_TOKEN" -X POST -H "Content-type: application/json" \
https://$HOST:8443/api/v1/oneprovider/index?space_id=$ONEDATA_SPACE&name=MyIndex1
```

Now the files which match the specified index can be queried using:

#### RDF
Custom RDF documents can also be attached to any data object:
```bash
curl -Ssk https://www.w3.org/2000/10/rdf-tests/Miscellaneous/animals.rdf \
| curl -Ssk -X PUT -H "X-Auth-Token: $ONEDATA_TOKEN" -H 'Content-type: application/rdf+xml' -d @- \
"https://$ONEPROVIDER_HOST/api/v3/oneprovider/metadata/Personal%20files/file1.txt"
```

and then retrieved:
```bash
curl -Ssk -X GET -H "X-Auth-Token: $ONEDATA_TOKEN" -H 'Accept: application/rdf+xml' \
"https://$ONEPROVIDER_HOST/api/v3/oneprovider/metadata/Personal%20files/file1.txt" | xmllint --format -

<?xmls version="1.0"?>

<RDF:RDF xmlns:RDF="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:ANIMALS="http://www.some-ficticious-zoo.com/rdf#">

<RDF:Seq about="urn:animals:data">
  <RDF:li>
    <RDF:Description about="urn:animals:lion">
      <ANIMALS:name>Lion</ANIMALS:name>
      <ANIMALS:species>Panthera leo</ANIMALS:species>
      <ANIMALS:class>Mammal</ANIMALS:class>
    </RDF:Description>
  </RDF:li>
  <RDF:li>
    <RDF:Description about="urn:animals:tarantula">
      <ANIMALS:name>Tarantula</ANIMALS:name>
      <ANIMALS:species>Avicularia avicularia</ANIMALS:species>
      <ANIMALS:class>Arachnid</ANIMALS:class>
    </RDF:Description>
  </RDF:li>
  <RDF:li>
    <RDF:Description about="urn:animals:hippopotamus">
      <ANIMALS:name>Hippopotamus</ANIMALS:name>
      <ANIMALS:species>Hippopotamus amphibius</ANIMALS:species>
      <ANIMALS:class>Mammal</ANIMALS:class>
    </RDF:Description>
  </RDF:li>
</RDF:Seq>
</RDF:RDF>
```