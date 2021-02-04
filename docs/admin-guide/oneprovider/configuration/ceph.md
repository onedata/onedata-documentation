# Ceph
<!-- This file is referenced at least one time as "ceph.md" -->

During the deployment of your Oneprovider service you can choose to setup a fully
functional storage system - *Ceph* - which can be later used as a storage for supporting your spaces.
That approach is mostly useful when your system does not provide any existing storage
mechanisms. In such a situation Onedata can take care of configuring and managing storage
for you, so you can start using it without any extra effort.

Ceph is a popular and well-tested storage platform, which allows to persist your data
in a fault-tolerant way (via a process of data replication) and minimized administration
time. To read more about characteristics of this solution, see [Ceph homepage](https://ceph.io/).

[[toc]]

## Installation

Ceph cluster configuration is performed during a Oneprovider deployment and involves
three main steps.

### 1. Selecting nodes for your Ceph cluster

In the first step of the Oneprovider deployment we have to choose which nodes will
become responsible for Ceph-related services. These can be selected using toggles. At
least one node must be enabled in the "Ceph" column.

![image](../../../../images/admin-guide/oneprovider/configuration/ceph/ceph-nodes-selection.png#bordered)

As you probably noticed, after enabling Ceph an additional step has been added to the wizard:
`Step 2. Ceph Configuration`.

If you want to use a node which is not on the list, use **Add new host** button. You can
read more about adding nodes in the [manual cluster deployment instruction](../installation.md#manual).

After Ceph nodes selection, click on **Proceed >**.

### 2. Setting Ceph cluster configuration

In the second step of the Oneprovider deployment we have to configure Ceph services
on the nodes we have previously selected.

![image](../../../../images/admin-guide/oneprovider/configuration/ceph/ceph-configuration-start.png#bordered)

#### Global parameters

The Ceph cluster has only one global parameter - **Cluster name**. It is preferred
to use the default name - `ceph`, but fell free to use your own name if it is needed.

#### Manager & Monitor services

To be functional, Ceph needs at least one node with enabled *Manager & Monitor* service.
It is responsible for managing cluster configuration and notifying about services health
and errors.

![image](../../../../images/admin-guide/oneprovider/configuration/ceph/ceph-monitor-configuration.png#bordered)

You can customize an IP address of the monitor node in the network connecting
Ceph nodes. It is an optional operation - autodetected IP address will be used when
not provided.

> It is recommended to configure an odd number of nodes with enabled *Manager & Monitor*.

#### OSDs

*OSD* (*Object Storage Daemon*) is the main service responsible for the data persistence.
Ceph cluster needs at least one OSD to work, although it is recommnded to have multiple
OSDs for the data replication purposes. To add a new OSD, click on **Add OSD** button
inside node entry.

![image](../../../../images/admin-guide/oneprovider/configuration/ceph/ceph-add-osd-btn.png#bordered)

OSDs comes in two flavours:
1. **Block device** - will use a real block device to storage your data. If you want to use
the whole disk partition or LVM logical volume for the storage, then this is the best choice.
2. **Loop device** - will persist data packed into a regular file. It is a good option
when you do not have a free block device for your storage. With that mechanism, data can be
located on any existing storage device.

##### Block device OSD setup

Choose **Block device** type and then select a free block device from the **Device**
dropdown. Be sure that the selected device has enough space for Ceph structures and your data -
at least 3 GiB.

![image](../../../../images/admin-guide/oneprovider/configuration/ceph/ceph-osd-block-device.png#bordered)

> Each block device can be used only by one OSD at the same time. Also be sure, that
the block device which you have selected **is not used by any other software** and **does not
contain any user files**. Ceph installation process will wipe all data stored on that device.

##### Loop device OSD setup

Choose **Loop device** type and then adjust the size of the OSD. It must be big enough
for Ceph structures and your data - at least 3 GiB. It must be also smaller than the
available space of the storage where the device file will be located.

![image](../../../../images/admin-guide/oneprovider/configuration/ceph/ceph-osd-loop-device.png#bordered)

You can also change the default path of the loop device file and place it somewhere else
in your storage.

> Paths used by loop devices must be unique across the same node. Paths proposed by the
GUI wizard are unique by default.

#### Finalizing Ceph configuration

If you filled in all needed fields properly, then there should be no warning at the top
of the configuration view and the **Deploy** button should be enabled. Example configuration:

![image](../../../../images/admin-guide/oneprovider/configuration/ceph/ceph-configuration-correct.png#bordered)

To start the cluster installation, click on **Deploy** button.

### 3. Creating a new Ceph storage (*Local Ceph*)
<!-- This header is referenced at least one time as "#_3-creating-a-new-ceph-storage-local-ceph" -->

In the **Storage Configuration** deployment step you can add a new storage, that will use
our local Ceph cluster. To do so, select **Local Ceph** value in **Storage type** drowdown.

![image](../../../../images/admin-guide/oneprovider/configuration/ceph/ceph-add-storage.png#bordered)

Most of the options in this form are described in the [documentation of storage configuration](./storages.md#configuration).
There are three fields, which are dedicated for *Local Ceph* storage type:
- **Number of copies** - number of data copies to distribute among OSDs. It must be
less than or equal to the number of Ceph OSDs,
- **Min. number of copies** - number of data copies below which (e.g. in case of OSD
failure) new writes will not be permitted. It must be less than or equal to the *number of copies*,
- **Block size** - storage block size in bytes. Is optional - by default it is `4194304` (4 MiB).

When your *Local Ceph* storage configuration is ready, click on **Add** button below the form
and continue the deployment process.

## Cluster management

You can monitor and manage you local Ceph cluster using GUI. View dedicated for Ceph is
available via **Ceph** submenu of your Oneprovider cluster.

![image](../../../../images/admin-guide/oneprovider/configuration/ceph/ceph-view.png#bordered)

### Ceph status

**Status** tab contains information about the overall cluster status and
visualizes OSDs usage on each node.

In case of any cluster errors, appropriate warning will be visible. Example:

![image](../../../../images/admin-guide/oneprovider/configuration/ceph/ceph-warning.png#bordered)

### Ceph configuration

**Configuration** tab presents the Ceph cluster configuration as set during the
Oneprovider installation. It cannot be modified.

![image](../../../../images/admin-guide/oneprovider/configuration/ceph/ceph-configuration-view.png#bordered)

### Ceph pools

**Pools** tab presents a list of pools of your Ceph cluster. Ceph pool is a logical
partition for storing object. In Onedata system pool is equivalent to the storage concept.
Any new *Local Ceph* storage will create a new pool and
vice versa - any new pool created in *Ceph pools* view will create a corresponding storage.

![image](../../../../images/admin-guide/oneprovider/configuration/ceph/ceph-pools-view.png#bordered)

As it was said, from this view you can create a new *Local Ceph* storage. Click on
**Create pool (as storage)** button and proceed as it was described in
[creating a new Ceph storage](#_3-creating-a-new-ceph-storage-local-ceph) section.

![image](../../../../images/admin-guide/oneprovider/configuration/ceph/ceph-new-pool-form.png#bordered)
