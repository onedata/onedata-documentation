# Oneprovider


<a name="overview"></a>
## Overview
This is the RESTful API definition of Oneprovider component of Onedata data management system [onedata.org](http://www.onedata.org).

> This API is defined using [Swagger](http://swagger.io/), the JSON specification can be used to automatically generate
> client libraries - [swagger.json](../../../swagger/oneprovider/swagger.json).

All paths below are relative to a common Oneprovider basepath which is `/api/v3/oneprovider`, thus a complete example
query for 'mode' file attributes would be:
 ```
 https://ONEPROVIDER_HOSTNAME/api/v3/oneprovider/attributes/Space1/directory1/file1.txt?attribute=mode
 ```
Please note that currently the default port for Oneprovider instances is `8443`.

In addition to REST API, Oneprovider also provides support for [CDMI](../../cdmi/cdmi.html) protocol, 
and some of data management operations are currently only possible via CDMI.


## Authentication
In order to be able to use this API the REST client must be able to authenticate with the Oneprovider service.

Currently this is supported through authentication token which can be generate using the Onedata user interface. 
The token must be added to the request header like this:
 ```
 macaroon: LAKSJHDLKJAHSDKLJHASKLCBBASKLCBLHABSCBALKSBCK...
 ```

In addition please take into account, that depending on your account authorization rights, not all operations
may be possible.

## API structure
The Oneprovider API reflects the fact that most operations deal directly with virtual file paths relative to
user spaces, which are provided as part of the paths in the REST calls.

The API provides the following functionality:

### Data

#### File attributes
The `/attributes/` operation group provides GET and PUT methods enable querying
for file attributes, such as 'mode' file permissions and updating them.

#### File browser
The `/files/` path methods provide basic capability for browsing files in spaces and folders.
Currently no wildcards are possible, thus paths must be complete up to a folder whose
contents are needed and start with the name of the space containing the requested folders and files.

#### Space information
For convenience, `/space/` methods provider means for getting basic information about
spaces directly from the Oneprovider service. For more comprehensive operations
on spaces please use the Onezone API.

### Replication

#### Replica management
The `/replicas/` methods allow retrieving of information about file replica distribution
among Onedata providers as well as requesting specific file replication to selected
providers.

#### Transfer management
The `/transfer/` operations provide basic transfer management functionality based on the ID of transfer
returned by `/replicas/{path} [POST]` operation. 

### Monitoring

#### Changes subscription
The `/changes/` method group provides means for subscribing (through HTTP long-polling technique) for
file related events such as reads, writes or deletes which are returned as complete file metadata
records with sequence numbers representing their current version.

#### Monitoring metrics
The `/metrics/` operations enable retrieval of internal Oneprovider monitoring data.
All monitoring data is returned in the form of [RRD](http://oss.oetiker.ch/rrdtool/) 
database files, with resolution determined by the `step` query parameter.

## Examples

**Create replica of file at specific storage provider**
```bash
curl -v --tlsv1.2 -H "macaroon: $TOKEN" -X POST \
 "https://$PROVIDER:8443/replicas/MySpace1/MyFile2.txt?provider_id=ASDNKJASF"
```

**Get space storage qouta metric**
```bash
curl -v --tlsv1.2 -H "macaroon: $TOKEN" -X GET \
 "https://$PROVIDER:8443/metrics/space/MySpace1?metric=storage_qouta"
```


### Version information
*Version* : 3.0.0-RC1


### Contact information
*Contact* : Onedata support  
*Contact Email* : info@onedata.org


### License information
*License* : Apache 2.0  
*License URL* : http://www.apache.org/licenses/LICENSE-2.0.html


### URI scheme
*BasePath* : /api/v3/oneprovider


### Tags

* Data : Space and file related operations
* Replication : Replication, file distribution and transfer control operations
* Monitoring : Metrics and change events monitoring related operations



