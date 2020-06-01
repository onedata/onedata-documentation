# Quality of Service

<!-- toc -->

Quality of Service functionality in Onedata allows you to choose storages 
(and by this providers) where your data should be kept. 

## QoS parameters
QoS management is based on QoS parameters. These parameters are in form `key=value`. 
Storage QoS parameters can be managed by an administrator of a Oneprovider.

Each storage has implicit parameters representing its id and id of its Oneprovider: 
`storageId=$STORAGE_ID` and `providerId=$PROVIDER_ID`.

Adding new QoS parameters and removing existing ones is managed 
in `Modify Storage Details` by Oneprovider administrator in Onepanel.  
[See more in REST API examples](#qos-parameters-management).

## QoS expression
With use of QoS parameters one can easily describe desired storages. 

For example:  
`geo=PL & type=disc` - disc storages located in Poland  
`geo=PL | type=disc` - storages located in Poland or disc storages anywhere  
`geo=PL - type=disc` - storages located in Poland that are not of disc type  

Expressions can be combined into more complex one, e.g:  
`geo=FR | (geo=PL & type=disc)` - storages in France or disc storages located in Poland

## QoS entries
QoS expression can be added to a file and it means that a file replica
is required on a storage that matches given expression.  
Adding QoS expression to a directory means that replicas of all 
files in a directory subtree are required.

Amount of required replicas can also be provided. Together expression and number 
of replicas make up a **QoS entry**.

After QoS entry is added to a file/directory required number of storages is selected 
from those matching given expression and one replica is created on each one of them. 
Created replicas are from this moment protected from being evicted manually or by auto-cleaning.
Also replicas will be automatically updated after every remote change to file.

When there is not enough storages to satisfy QoS entry it is marked as impossible. 

## QoS status
QoS entry can be in one of three possible states:
 - `pending`
 - `fulfilled`
 - `impossible`
 
When QoS entry is `impossible` it means that there are not enough storages with 
required QoS parameters so entry cannot be satisfied.

Entry is `fulfilled` when all required replicas have been created and all remote changes have been reconciled.

Entry is `pending` when it is possible but not yet fulfilled.


## Using REST API

Below are some examples how the REST API can be used to manage user tokens. For
detailed documentation of all endpoints, please refer to the 
[API documentation](https://onedata.org/#/home/api/latest/oneprovider?anchor=tag/QoS).

Below examples assume that the following envs are exported:

```bash
REST_API="https://<oneprovider-domain>/api/v3/oneprovider"
PANEL_API="https://<onepanel-domain>/api/v3/onepanel"
AUTH_HEADER="x-auth-token: <your-access-token>"
CT="content-type: application/json"
```

#### Adding new QoS entry

First ensure that you have id of file that you want to add your QoS entry to. 
One can be easily obtained using [lookup file id endpoint](https://onedata.org/#/home/api/latest/oneprovider?anchor=operation/lookup_file_id):

```bash
curl -H "${AUTH_HEADER}" -X POST {$REST_API}/lookup-file-id/PathToFile
```

```bash
{"fileId":"000000000052732467756964236431303233303132616362346233373463306263626339666535303630343135636861356536236334613030626466613534643064636666656335633430313039633762663635636861356536"}
```

Once you have id of your file id(e.g in FILE_ID variable) you can add QoS entry:

```bash
curl -H "${AUTH_HEADER}" -H "${CT}" -X POST {$REST_API}/qos_entry/ -d '{
"expression": "geo=FR | (geo=PL & type=disc)", 
"replicasNum": 2, 
"fileId": "$FILE_ID"
}'
```

In response you will receive id of your newly created QoS entry:

```bash
{
    "qosEntryId": "c4bb03e7ae90d9886cbb68e6a08312c7ch08f5"
}
```

#### Getting QoS entry details

Getting details of a QoS entry can be achieved with following endpoint:

when `$QOS_ENTRY_ID` is id of a QoS entry.

```bash
curl -H "${AUTH_HEADER}" -X GET {$REST_API}/qos_entry/$QOS_ENTRY_ID
```

```bash
{
  "status": "pending",
  "replicasNum": 2,
  "qosEntryId": "c4bb03e7ae90d9886cbb68e6a08312c7ch08f5",
  "fileId": "000000000052732467756964236431303233303132616362346233373463306263626339666535303630343135636861356536236334613030626466613534643064636666656335633430313039633762663635636861356536",
  "expression": "geo=FR|(geo=PL&type=disc)"
}
```

#### Deleting QoS entry

QoS entry can be deleted like this:

```bash
curl -H "${AUTH_HEADER}" -X DELETE {$REST_API}/qos_entry/$QOS_ENTRY_ID
```

#### QoS summary for a file

QoS summary contains information of all entries (added directly or inherited from ancestors) for given file.

```bash
curl -H "${AUTH_HEADER}" -X GET {$REST_API}/data/$FILE_ID/qos_summary
```

```bash
{
  "status": "pending",
  "entries": {
    "c4bb03e7ae90d9886cbb68e6a08312c7ch08f5": "pending",
    "a77d55692d4b0216ceccc4b83e47cca3ch08f5": "fulfilled"
  },
  "assignedEntries": {
    "40852d6e487167c003065e0d3d8f4c08ch98e2": [
      "a77d55692d4b0216ceccc4b83e47cca3ch08f5",
      "c4bb03e7ae90d9886cbb68e6a08312c7ch08f5"
    ]
  }
}
```
Fields of response are explained [here](https://onedata.org/#/home/api/latest/oneprovider?anchor=operation/get_file_qos_summary)

### QoS parameters management

Below are some examples for Oneprovider administrators concerning management of storage 
QoS parameters with the use of [REST api](https://onedata.org/#/home/api/latest/onepanel?anchor=operation/get_storage_details).

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
      "type": "disc"
    }
    ...
}
```

#### Modifying QoS parameters

Adding new parameters, removing and modifying existing ones is done with the use of the 
same REST endpoint. It can be achieved by submitting QoS parameters that are expected after all changes.  
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
