# Oneprovider Installation

> A detailed screencast presenting a single node installation of Oneprovider is located in the tutorials section.

Oneprovider instllation consists of two parts:
* installation of oneprovider services on the cluster nodes
* registration of oneprovider cluster with Onedata.

## Services Installation

In order to install oneprovider service, you need a (virtual) machine with one of supported operating systems installed. Currently oneprovider can be installed using RPM packages on:
* Scientific Linux 6.x
* CentoOS 7.x

and on other Linux platforms using Bash installation script.


For detailed instructions on how to install oneprovider package on each of those systems please visit [download section](https://onedata.org/download) on Onedata hopepage.

Oneprovider package setups a service called onepanel. Onepanel is an cluster installation and administration user interface that detects all other nodes in the network where oneprovder package has been installed and allows for configuration of services on each cluster node.

Upon successful installation of oneproivder package you need to navigate to `https://<ip>:9443` address. The default credentials for logging into onepanel are:
~~~
login: admin
password: password
~~~

### Step 1: Hosts selection

<p align="center"><img src="img/admin/step1_host_selection.png"></p>

In this step, onepanel detects all nodes in the network where oneprovider package has been installed and onepanel serices is running. Youcan configure on which nodes which oneprovider serices will be installed.


### Step 2: Primary Cluster Manager selection

<p align="center"><img src="img/admin/step2_primary_cm_selection.png"></p>

You can deploy multiple Cluster Managers for redundancy purposes but only one will be active at the time. Here you chose which one.

### Step 3: Application ports check.

<p align="center"><img src="img/admin/step3_ports_check.png"></p>

In order to work properly oneprovider needs a number of ports open on machine. In this step oneprovider ensures that all needed ports are open.


### Step 4: System limits configuration.

<p align="center"><img src="img/admin/step4_system_limists.png"></p>

While discouraged to do that, administrators may impose limit on a number of opened files by oneprovider services and processes spawned by them.


### Step 5: Storage configuration.

<p align="center"><img src="img/admin/step5_path_to_storage.png"></p>

Select a path to a mounted storage which oneprovider will use to store user data.

## Oneprovider Registration
Once installed it is recommended to register oneprovider with onedata ecosystem, so users can use onedata.org in order to login into your cluster.

### Step 1&2: Connection check and Ports configuration
<p align="center"><img src="img/admin/rstrep1_info.png"></p>

<p align="center"><img src="img/admin/rstep2_ports.png"></p>

In order to communicate with onedata, oneprovider needs a public with ports `443` and `8443` opened, or a private address with those ports properly redirected.

### Step 3: Name configuration
<p align="center"><img src="img/admin/rstep2_name.png"></p>
The last step is to set a name for a provider by which it will be identified in onedata ecosystem.
