# Quality of Service

[toc]

Quality of Service (QoS) is used to manage file replica distribution and redundancy
between providers supporting a space.
FIXME — add links to data distribution, provider, space

This guide is dedicated to non-admin users that would like to utilize QoS to manage
the distribution of their data. Consider reading the 
[counterpart documentation for admins](../admin-guide/oneprovider/configuration/qos.md) 
for information on the proper configuration of the Oneprovider service regarding QoS.

## Basics

Qos mechanisms are based on the continuous processing of ([QoS requirements](#qos-requirement)). 
A requirement is essentially a rule defining the desired data redundancy (replica count) 
and how to determine the placement of replicas ([QoS expression](#qos-expression)). 

Each file or directory can have any number of requirements — in the case of directories, the requirement is applied to all its files and subdirectories, recursively.

If required, data transfers are automatically triggered to satisfy the QoS requirements — remote
changes made to file content are automatically reconciled. File replicas corresponding to 
QoS requirements are protected from eviction.

Removing a QoS requirement does not automatically remove the replicas that were created during its
lifetime, but they are no longer protected.


## QoS expression
QoS expressions are a declarative way of specifying desired storage parameters in a unified format.
They are used to determine the replica placement — the target storage backends where the replicas
of the data will be stored. The expressions refer to storage parameters that are assigned
by [Oneprovider admins](../admin-guide/oneprovider/configuration/qos.md).

An expression is a set of one or more operands, each referring to one storage parameter.
An operand is in form `key {comparator} value`, where `{comparator}` is one of `<, >, <=, >=, =`, 
e.g. `key = value`. One exception from this is the single-worded, built-in operand `anyStorage`. 
If any comparator other than `=` is used, only numeric values are allowed.

Operands are processed left-to-right and can be combined:
* `&` — expression matches if both operands match,
* `|` — expression matches if any of the two operands matches,
* `\ ` — expression matches if the left-hand side operand matches and the right-hand side operand does not.

Example QoS expressions:  
* `geo=PL` — storage backends in Poland,
* `timeout < 8` — storage backends with timeout parameter set to less than 8,
* `timeout = 8` — storage backends with timeout parameter set to exactly 8,
* `geo=PL & type=disk` — storage backends of disk type in Poland,
* `geo=PL | type=disk` — storage backends in Poland or storage backends of disk type anywhere,
* `anyStorage \ type=disk` — storage backends that are not of the disk type.

Use parentheses to group operands that should be evaluated together, e.g:  
* `geo=FR | (geo=PL & type=disk)` — storage backends in France or storage backends of disk type in Poland,  
* `(geo=PL \ type=disk) | (geo=FR & type=disk)` — storage backends in Poland that are not of disk type or storage backends in France that are of disk type.


## QoS requirement
A QoS requirement consists of a [QoS expression](#qos-expression) and the target replica count.
Storage backends matching the expression are selected for data replication in a continuous re-evaluation
process until the target replica count is satisfied. If there are more matching backends than
the target replica count, a random subset is selected.

The replicas originating from the evaluation of QoS requirements are automatically managed — 
protected from eviction and reconciled upon changes to the file content.

Fulfillment of a QoS requirement is indicated by its **status**:
* `fulfilled` — the target replica count has been created on the matching storage backends 
  and their contents are up-to-date (remote changes have been reconciled).
* `pending` — the requirement is not yet fulfilled — data replication is still ongoing.
* `impossible` — there are not enough storage backends matching the expression to meet the target 
  replica count, hence the requirement cannot be satisfied — unless the list of supporting storage backends or their parameters change.


## Web GUI guide

To manage QoS requirements, choose the **Quality of Service** action from the file/directory's 
context menu in the [file browser](web-file-browser.md).

![qos_in_context_menu](../../images/user-guide/qos/context_menu.png#screenshot)

Choose the **Add requirement** action and specify the target replica count and the expression.  

![add_qos_req](../../images/user-guide/qos/add_qos_modal.png#screenshot)

QoS expression can be entered as text (useful when pasting a copied expression) or constructed 
using the built-in graphical editor.  

![qos_expression_editor](../../images/user-guide/qos/modal_expression.png#screenshot)  

The editor provides suggestions for each key/value, based on existing storage parameters.  

![qos_property_selector](../../images/user-guide/qos/modal_property_selector.png#screenshot)  

After expanding the row for a requirement, you can examine its status, transfer statistics, 
and audit log.

![qos_fulfilled](../../images/user-guide/qos/modal_fulfilled.png#screenshot)

In the charts, you can see the total number of files and the number of bytes that were
transferred in order to fulfill the requirement. 

::: warning NOTE
The QoS charts and audit logs are presented as seen from the point of view of the 
[currently selected provider](web-file-browser.md#switching-between-providers).
:::

#### INBOUND chart
* `Files` represent the number of regular files that were processed to fulfill the QoS requirement. 
If a single file is transferred multiple times (e.g. when the file content changes multiple times on a remote provider), each of these transfers contributes towards this counter. 
Empty files also increase the counter. 
* `Bytes` represent the number of bytes that have been written to the local storage backends to fulfill the QoS requirement.

#### OUTBOUND chart
* `Bytes` represent the number of bytes that have been transferred **from** remote storage backends.
The sum of these values is equal to the `Bytes` value shown in the `INBOUND` chart.


## Using REST API

FIXME adjust to guidelines

Below are some examples of how the REST API can be used to manage QoS requirements. For
detailed documentation of all endpoints, refer to the
[API documentation](https://onedata.org/#/home/API/latest/oneprovider?anchor=tag/QoS).

Below examples assume that the following environment variables are exported:

```bash
REST_API="https://<oneprovider-domain>/API/v3/oneprovider"
AUTH_HEADER="x-auth-token: <your-access-token>"
CT="content-type: application/json"
```

These endpoints can be used by a space member with manage QoS privileges to manage desired requirements.

<!-- @TODO VFS-6428 Add examples of retrieving storage qos parameters -->

#### Adding new QoS requirement

Prepare the ID of the file/directory to which you want to add your QoS requirement.
It can be found in the file browser GUI (`Information` in file/directory's context menu)  or
using the [lookup file ID endpoint](./rest-and-cdmi-api.md#file-paths):

```bash
curl -H "${AUTH_HEADER}" -X POST {$REST_API}/lookup-file-id/test-space/directory/file.txt
```

```bash
{"fileId":"000000000052732467756964236431303233303132616362346233373463306263626339666535303630343135636861356536236334613030626466613534643064636666656335633430313039633762663635636861356536"}
```

Assuming that the file ID is stored in $FILE_ID variable, you can add a QoS requirement:

```bash
curl -H "${AUTH_HEADER}" -H "${CT}" -X POST {$REST_API}/qos_requirement/ -d '{
"expression": "geo=FR | (geo=PL & type=disk)",
"replicasNum": 2,
"fileId": "$FILE_ID"
}'
```

In response, you will receive the ID of your newly created QoS requirement:

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
Response fields are explained in the [API documentation](https://onedata.org/#/home/API/latest/oneprovider?anchor=operation/get_file_qos_summary).

