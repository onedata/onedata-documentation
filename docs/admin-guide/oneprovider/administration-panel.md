# Administration panel

Administration panel — in the form of the Onepanel service — is responsible for a range of functionalities related to managing the Oneprovider service cluster. Examples of tasks performed by Onepanel include:

* conducting the Oneprovider cluster installation process,
* managing certificates,
* adding new storages,
* supporting spaces with existing storages,
* and many others.

All these configuration aspects are available both in the form of a web application and a [REST API](./configuration/rest-api.md). Descriptions of their usage can be found in the *Configuration* series of articles.

## Accessing the administration panel

Users can access the administration panel interface in two ways:

1. Through the Onezone service interface.
2. Through the emergency interface.

### Access via Onezone service interface

This type of access is the default and also the most secure option. It is based on standard login to the Onezone service and then selecting the desired Oneprovider cluster from the *Clusters* menu.

![image](../../../images/admin-guide/oneprovider/administration-panel/onepanel-hosted.png#screenshot)

However, in certain situations, this method may not be available due to some system issues. In such cases, it is possible to use the so-called emergency interface.

### Access via emergency interface

Only use this method if access through the first approach fails. The emergency interface is usually located at the address `https://my.provider.domain.org:9443`, where `my.provider.domain.org` represents the Oneprovider domain.

Click on *Sign in to emergency interface* and provide the emergency passphrase that allows entry into the administration panel. This passphrase was set during the Oneprovider cluster installation and is not connected to any user in the system.

![image](../../../images/admin-guide/oneprovider/administration-panel/onepanel-emergency-login.png#screenshot)

::: warning
Try to avoid using the emergency interface. Leaking the passphrase to this interface can lead to unauthorized access by third parties and data loss.
:::

#### Changing the emergency interface passphrase

You can change the emergency interface passphrase if you suspect that the current passphrase is no longer secure. This can be done only via the emergency interface of administration panel (in the *Emergency passphrase* submenu).

![image](../../../images/admin-guide/oneprovider/administration-panel/change-emergency-passphrase.png#screenshot)

## Managing access to the administration panel

Users who are members of a specific Oneprovider cluster have access to its administration panel. Similar to other resources, the list of authorized users can be found under the *Members* submenu. In this place you can add and remove authorized users or change their access permissions. Read more [here](./configuration/cluster-members.md).

::: tip
Members settings do not apply to the emergency interface. Signing-in using the emergency passphrase always grants full management rights to the cluster.
:::
