# Oneprovider Installation

Oneprovider installation includes:
* installation of Oneprovider services on the cluster nodes,
* registration of Oneprovider cluster with Onezone.

## Services Installation

In order to install Oneprovider service, you need a (virtual) machine with one of supported operating systems installed. Currently Oneprovider can be installed using RPM packages on:
* Scientific Linux 6.x
* CentoOS 7.x

For detailed instructions on how to install Oneprovider package on each of those systems please visit [download section](https://onedata.org/download) on Onedata homepage.

Oneprovider package setups a service called Onepanel. Onepanel is a cluster installation and administration user interface that detects all other nodes in the local network where Oneprovider service has been installed and allows for configuration of services on each cluster node.

Upon successful installation of Oneprovider package, you need to navigate to `https://<ip>:9443` address. The default credentials for logging into Onepanel are:
~~~
login: admin
password: password
~~~

### Step 1: Hosts selection

<p align="center"><img src="../img/admin/step1_host_selection.png"></p>

In this step, Onepanel detects all nodes in the network where Oneprovider package has been installed and Onepanel service is running. You can configure on which nodes which Oneprovider each of the services will be installed.


### Step 2: Primary Cluster Manager selection

You can deploy multiple Cluster Managers for redundancy purposes but only one will be active at the same time. Here you can choose which one:

<p align="center"><img src="../img/admin/step2_primary_cm_selection.png"></p>


### Step 3: Application ports check.

In order to work properly Oneprovider needs a number of ports (443, 53) open on machine. In this step Oneprovider ensures that all needed ports are open.

<p align="center"><img src="../img/admin/step3_ports_check.png"></p>


### Step 4: System limits configuration.

Administrators may impose limit on a number of opened files by Oneprovider, services and processes spawned by them.

<p align="center"><img src="../img/admin/step4_system_limists.png"></p>


### Step 5: Storage configuration.

Select a path to a mounted storage, which Oneprovider will use to store user data. Detailed information on the supported storage types is discussed [here](./storage_configuration.md).

<p align="center"><img src="../img/admin/step5_path_to_storage.png"></p>


## Registration with Onezone service
Once installed, it is recommended to register Oneprovider with Onezone provider registry, so users can use Oneprovider instances within an entire zone transparently.

### Step 1&2: Connection check and Ports configuration

Please make sure that all [required ports](./firewall_setup.md) on Oneprovider and Onezone hosts are accessible to Onedata services and users. For the sake of security it is recommended, that ports on database and cluster manager nodes are not publicly available.

<p align="center"><img src="../img/admin/rstrep1_info.png"></p>

<p align="center"><img src="../img/admin/rstep2_ports.png"></p>

Ideally all the nodes should have a dedicated public IP address and the above mentioned ports open to the world. In other case you can configure a `;` separated *Redirection points*, where each entry is a pair of public IP and the port which point to one of the nodes.


### Step 3: Name configuration
The last step allows to set a name for the provider by which it will be identified in Onezone service and presented to users.

<p align="center"><img src="../img/admin/rstep2_name.png"></p>

