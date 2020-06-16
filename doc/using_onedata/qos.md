# Quality of Service

<!-- toc -->

## Basics

Quality of Service functionality in Onedata is used to manage file replica distribution and redundancy 
between supporting Oneproviders. Users can define any number of QoS requirements for a file or directory. 
Each requirement consists of target replicas number and an expression that is used to select storages 
where the replicas should be placed ‐ it is matched against parameters that were assigned to storages 
by Oneprovider admins.

If required, data transfers are automatically triggered to satisfy the QoS requirements, and remote 
changes made to file content are automatically reconciled. File replicas corresponding to QoS requirements 
are protected from eviction.

Removing a QoS requirement does not automatically remove the replicas that were created during its 
lifetime, but they are no longer protected. 

## QoS parameters
QoS management is based on QoS parameters that are assigned to storages by Oneprovider admins. 
All parameters are in form `key=value`. 

Each storage has implicit parameters representing its id and id of its Oneprovider: 
`storageId=$STORAGE_ID` and `providerId=$PROVIDER_ID`.

Adding new QoS parameters and removing existing ones can be done using the Modify Storage Details operation in Onepanel.  
[See more in REST API examples](#qos-parameters-management).

## QoS expression
QoS expressions are a declarative way of specifying desired storage parameters in a unified format.

Operands in expression must be in form `key=value`. One exception from this is operand `anyStorage`. 
Operands can be combined with the use of one of supported operators:
- `&` - results in storages that match expressions on both sides of this operator
- `|` - results in storages that match at least one expression on both sides of this operator
- `-` - results in storages that match expression on left side of this operator and do not match expression on the right side of operator

Example QoS expressions:  
- `geo=PL` - any storages in Poland  
- `geo=PL & type=disk` - disk storages located in Poland  
- `geo=PL | type=disk` - storages located in Poland or disk storages anywhere  
- `anyStorage - type=disk` - any storages that are not of disk type  


Operands and nesting can be used to combine simple expressions into complex ones, e.g:  
- `geo=FR | (geo=PL & type=disk)` - any storages in France or disk storages located in Poland  
- `(geo=PL - type=disk) | (geo=FR & type=disk)` - storages in Poland that are not of disk type or storages in France that are of disk type

## QoS requirements
QoS requirement consists of a [Qos expression](#qos-expression) and a desired number of replicas. 
It can be added for a single file or a whole directory (in such case all nested subfiles and 
subdirectories are affected). The QoS expression is used to select matching storages where the 
replicas will be placed - until the specified target number of replicas is satisfied. 
The replicas are automatically managed ‐ protected from eviction and reconciled upon changes 
to the file content.

Fulfillment of a QoS requirement is indicated by its `status`:
 - `impossible` - there are not enough storages matching the expression to meet the required number 
 of replicas, hence the requirement cannot be satisfied - unless the list of supporting storages 
 or their parameters change.
 - `fulfilled` - desired number of replicas have been created on matching storages and their contents 
 are up-to-date (remote changes have been reconciled).
 - `pending` - the requirement is not yet fulfilled - data replication is still ongoing.

## Using web GUI

Quality of Service can be managed in the web GUI. Look for the Quality of Service in the file/directory's context menu. 

## Using REST API

Below are some examples how the REST API can be used to manage QoS requirements. For
detailed documentation of all endpoints, please refer to the 
[API documentation](https://onedata.org/#/home/API/latest/oneprovider?anchor=tag/QoS).

Below examples assume that the following envs are exported:

```bash
REST_API="https://<oneprovider-domain>/API/v3/oneprovider"
PANEL_API="https://<oneprovider-domain>/api/v3/onepanel"
# or
PANEL_API="https://<oneprovider-domain>:9443/api/v3/onepanel"  # if you have access to the onepanel's emergency interface
AUTH_HEADER="x-auth-token: <your-access-token>"
CT="content-type: application/json"
```

###API for space users
These endpoints can be used by a space member with manage QoS privileges to manage desired requirements.

<!-- @TODO VFS-6428 Add examples of retrieving storage qos parameters -->

#### Adding new QoS requirement

Prepare the ID of the file/directory to which you want to add your QoS requirement.
It can be found in the file browser GUI (`Information` in file/directory's context menu)  or 
using the [lookup file id endpoint](https://onedata.org/#/home/API/latest/oneprovider?anchor=operation/lookup_file_id):

```bash
curl -H "${AUTH_HEADER}" -X POST {$REST_API}/lookup-file-id/test-space/directory/file.txt
```

```bash
{"fileId":"000000000052732467756964236431303233303132616362346233373463306263626339666535303630343135636861356536236334613030626466613534643064636666656335633430313039633762663635636861356536"}
```

Assuming that the file id is stored in $FILE_ID, you can add a QoS requirement: 

```bash
curl -H "${AUTH_HEADER}" -H "${CT}" -X POST {$REST_API}/qos_requirement/ -d '{
"expression": "geo=FR | (geo=PL & type=disk)", 
"replicasNum": 2, 
"fileId": "$FILE_ID"
}'
```

In response you will receive id of your newly created QoS requirement:

```bash
{
    "qosRequirementId": "c4bb03e7ae90d9886cbb68e6a08312c7ch08f5"
}
```

#### Getting QoS requirement details

Getting details of a QoS requirement can be achieved with querying following endpoint:

```bash
curl -H "${AUTH_HEADER}" -X GET {$REST_API}/qos_requirement/$QOS_REQ_ID
```

```bash
{
  "status": "pending",
  "replicasNum": 2,
  "qosRequirementId": "c4bb03e7ae90d9886cbb68e6a08312c7ch08f5",
  "fileId": "000000000052732467756964236431303233303132616362346233373463306263626339666535303630343135636861356536236334613030626466613534643064636666656335633430313039633762663635636861356536",
  "expression": "geo=FR|(geo=PL&type=disk)"
}
```

#### Deleting QoS requirement

QoS requirement can be deleted like this:

```bash
curl -H "${AUTH_HEADER}" -X DELETE {$REST_API}/qos_requirement/$QOS_REQ_ID
```

#### QoS summary for a file

QoS summary contains information of all requirements (added directly or to any ancestor directory) for given file.

```bash
curl -H "${AUTH_HEADER}" -X GET {$REST_API}/data/$FILE_ID/qos_summary
```

```bash
{
  "requirements": {
    "c4bb03e7ae90d9886cbb68e6a08312c7ch08f5": "pending",
    "a77d55692d4b0216ceccc4b83e47cca3ch08f5": "fulfilled"
  },
  "status": "pending"
}
```
Response fields are explained [here](https://onedata.org/#/home/API/latest/oneprovider?anchor=operation/get_file_qos_summary).

### API for Oneprovider admins

Below are some examples for Oneprovider administrators concerning management of storage 
QoS parameters with the use of [REST API](https://onedata.org/#/home/API/latest/onepanel?anchor=operation/get_storage_details).

#### Listing QoS parameters

In below example `$STORAGE_ID` is the id of your storage.

```bash
curl -H "${AUTH_HEADER}" -X GET {$PANEL_API}/provider/storages/$STORAGE_ID
```

```bash
{
    ...
    "qosParameters": {
      "storageId": "b1b9174674b951305831d55b42c6ae22ch975f",
      "providerId": "7b052ee78cb4fa0263d3bebeab1da7f3ch255b",
      "geo": "PL",
      "type": "disk"
    }
    ...
}
```

#### Modifying QoS parameters

<!-- @TODO VFS-6429 Update example after storage modify endpoint is reworked -->

Adding new parameters, removing and modifying existing ones is done with the use of the 
same REST endpoint. Submitted QoS parameters overwrite previous ones.  
In below example (assuming that QoS parameters before modifications are as in previous 
example) parameter `geo` is removed, value of parameter `type` is changed 
and new parameter `new_key` is added.

```bash
curl -H "${AUTH_HEADER}" -H "${CT}" -X PATCH {$PANEL_API}/provider/storages/$STORAGE_ID -d '{
    "$STORAGE_NAME": {
        "type": "$STORAGE_TYPE", 
        "qosParameters": {
            "type": "modified_type"
            "new_key": "new_value"
        }
    }
}'
```

NOTE: `storageId` and `providerId` parameters cannot be removed or modified.
