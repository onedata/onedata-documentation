# Quality of Service

[toc][1]

Quality of Service (QoS) is used to manage file [replica distribution][] and redundancy
between [providers][] supporting a [space][].

This documentation concerns the proper configuration of the Oneprovider service
so that QoS rules can be effectively utilized by the users. For details on how
QoS works and how to use it, consult the [counterpart documentation for end users][users-qos].

## QoS parameters

QoS management is based on QoS parameters that are assigned to storage backends
by Oneprovider admins. All parameters are in the form of `key=value`.

Each storage has implicit parameters representing its ID and the ID of its Oneprovider:
`storageId=$STORAGE_ID` and `providerId=$PROVIDER_ID`.

You can modify the QoS parameters using the [Web GUI][] (Administration Panel) or [REST API][].

::: tip NOTE
The `storageId` and `providerId` parameters cannot be removed or modified.
:::

## Web GUI guide

QoS parameters can be set during storage creation:
![screen-create-storage][]

To modify the parameters, use the **Modify** action for the desired row in the **Storage backends** view.

![screen-modify-storage][]

## Using REST API

Below are some links to the REST API documentation for Oneprovider administrators concerning the management
of storage backend's QoS parameters:

| Operation                | Link to the API docs         |
| ------------------------ | ---------------------------- |
| Listing QoS parameters   | [API][list-qos-parameters]   |
| Modifying QoS parameters | [API][modify-qos-parameters] |

#### Modifying QoS parameters

<!-- @TODO VFS-6429 Update example after storage modify endpoint is reworked -->

Adding new parameters, removing or modifying existing ones is done with the use of the
same REST endpoint. Submitted QoS parameters overwrite the previous ones.
The below example assumes that QoS parameters before modifications were as follows:

```js
    "geo": "PL",
    "type": "disk"
```

The following command will result in the parameter `geo` being removed, the value of parameter `type` updated
and a new parameter `new_key` added.

```bash
curl -H "${AUTH_HEADER}" -H "${CT}" -X PATCH {$PANEL_API}/provider/storages/$STORAGE_ID -d '{
    "$STORAGE_NAME": {
        "type": "$STORAGE_TYPE",
        "qosParameters": {
            "type": "modified_type",
            "new_key": "new_value"
        }
    }
}'
```

[1]: <>

[replica distribution]: ../../../user-guide/data-distribution.md

[providers]: ../../../user-guide/providers.md

[space]: ../../../user-guide/spaces.md

[users-qos]: ../../../user-guide/qos.md#Basics

[Web GUI]: ../administration-panel.md

[REST API]: ./rest-api.md

[list-qos-parameters]: https://onedata.org/#/home/api/stable/onepanel?anchor=operation/get_storage_details

[modify-qos-parameters]: https://onedata.org/#/home/api/stable/onepanel?anchor=operation/modify_storage

[screen-create-storage]: ../../../../images/admin-guide/oneprovider/configuration/qos/qos-params-create-storage.png

[screen-modify-storage]: ../../../../images/admin-guide/oneprovider/configuration/qos/qos-params-modify-storage.png
