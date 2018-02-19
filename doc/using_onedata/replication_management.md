# Replication and Transfer Management

<!-- toc -->

Onedata provides advanced functionality in terms of replica and transfer management in order to support most demanding use cases such as high performance scientific applications.

On the low level, all files are divided into equal size blocks which can be independently replicated between storage resources. The API's for replication and transfer management give detailed information on which blocks are replicated at which sites, which allows for custom control and optimization at the application level.

## Web user interface

Web interface provides visual information on the current replication of each file among the storage providers supporting the user space in which this file is located. Sample replication visualization is presented in the image below:

<img  style="display:block;margin:0 auto;max-width:380px" src="../img/transfers_menu.png">

## REST interface

For full control over transfer and replication users can directly invoke REST API of Oneprovider service.

### Replication

The `/replicas/` methods allow retrieving of information about file replica distribution among Onedata providers as well as requesting specific file replication to selected providers.

Information about replicas of a specific file can be retrieved using the following query:
```bash
curl -X GET -H "X-Auth-Token: $ACCESS_TOKEN" \
https://$ONEPROVIDER_HOST/api/v3/oneprovider/replicas/MySpace1/MyFolder2/my_file3.dat
```

The result is a JSON list of objects, where each contains the id of one of the providers hosting at least some fragments of the file and the list of blocks stored at it's premises in the form: `[offset, size]`.

```json
[
    {
        "blocks": [
            [
                0,
                4
            ],
            [
                10,
                20
            ]
        ],
        "providerId": "UMa3Dg7iliXbAYsQ10f7L0ZZFJlNKDYYY62LQy9HW4k"
    },
    {
        "blocks": [
            [
                1024,
                2048
            ],
            [
                4096,
                1048576
            ]
        ],
        "providerId": "34fgtYRDD5rhg5e1W4t4gt557VSffsDDAJTTS31SHRS"
    }
]

```

In order to request replication of the file to a specific provider, a `POST` request on the specific file path has to be invoked with provider ID provided as parameter, for example:

```bash
curl -X POST -H "X-Auth-Token: $ACCESS_TOKEN"  \
'https://$ONEPROVIDER_HOST/api/v3/oneprovider/replicas/MySpace1/MyFolder2/my_file3.dat?provider_id=34fgtYRDD5rhg5e1W4t4gt557VSffsDDAJTTS31SHRS'
```

This operation returns a transfer ID which can be used to monitor and cancel the transfer:
```json
{
    "transferId": "UGHLKJ8758ASD99879ASDASD987897aDASD"
}
```
Please note, that this operation is asynchronous as it can take a long time depending on the size of the data to move. If the path parameter specifies a folder, entire folder is replicated to requested provider.

The default API for replica management is compatible with [CDMI]() convention of using complete file and directory paths directly in the request URL's. Additionaly, we provide REST operations which take directly file and folder ID's instead of paths and can be used in the same way as the above operations, i.e.:

```bash
# Replicate file AO3413D85757asdASas3ASD to Oneprovider at $ONEPROVIDER_HOST
curl -X GET -H "X-Auth-Token: $ACCESS_TOKEN" \
https://$ONEPROVIDER_HOST/api/v3/oneprovider/replicas-id/AO3413D85757asdASas3ASD

# Replicate file AO3413D85757asdASas3ASD to another Oneprovider with specific Id
curl -X POST -H "X-Auth-Token: $ACCESS_TOKEN"  \
https://$ONEPROVIDER_HOST/api/v3/oneprovider/replicas-id/AO3413D85757asdASas3ASD?provider_id=34fgtYRDD5rhg5e1W4t4gt557VSffsDDAJTTS31SHRS
```


### Transfer control and monitoring

#### Using GUI
In order to initiate a transfer (either replication or migration),
simply select the `Data distribution` icon in the top
menu of the file browser of Oneprovider and select the target provider, to which
replication or migration should take place:

<img  style="display:block;margin:0 auto;max-width:380px" src="../img/transfers_menu.png">


Transfers can be conveniently managed and monitored using Oneprovider GUI. 
For each space, under tab `Transfers` on the left a dedicated transfer management
view is available:

<img  style="display:block;margin:0 auto;" src="../img/transfers.png">

For each transfer within the current data space an appropriate entry in the list below is
added, which provides information on current throughput of a specific transfer.

Overall throughput for the space can be observed on the world map.

#### Using REST API

The `/transfer/` operations provide basic transfer management functionality based on the ID of transfer returned by `/replicas/{path} [POST]` operation.

In order to get information about a specific transfer, simply query the following resource:

```bash
curl -X GET -H "X-Auth-Token: $ACCESS_TOKEN" \
https://$ONEPROVIDER_HOST/api/v3/oneprovider/transfers/<TRANSFER_ID>
```

or you can request all active transfers for given user:
```bash
curl -X GET -H "X-Auth-Token: $ACCESS_TOKEN" \
https://$ONEPROVIDER_HOST/api/v3/oneprovider/transfers
```

Each transfer can be cancelled using `DELETE` method:
```bash
curl -X DELETE -H "X-Auth-Token: $ACCESS_TOKEN" \
https://$ONEPROVIDER_HOST/api/v3/oneprovider/transfers/<TRANSFER_ID>
```

