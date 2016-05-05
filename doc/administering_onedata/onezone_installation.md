# Onezone Installation

> A detailed screencast presenting a single node installation of Onezone is located in the tutorials section.

## Services Installation

In order to install Onezone service, you need a (virtual) machine with one of supported operating systems installed. Currently Onezone can be installed using RPM packages on:
* Scientific Linux 6.x
* CentoOS 7.x

For detailed instructions on how to install Onezone package on each of those systems please visit [download section](https://onedata.org/download) on Onedata homepage.

Onezone package setups a service called Onepanel. Onepanel is a cluster installation and administration user interface that detects all other nodes in the local network where Onezone service has been installed and allows for configuration of services on each cluster node.

Upon successful installation of Onezone package, you need to navigate to `https://<ip>:9443` address. The default credentials for logging into Onepanel are:
~~~
login: admin
password: password
~~~

### Step 1: Hosts selection

<p align="center"><img src="img/admin/oz_step1_host_selection.png"></p>

In this step, Onepanel detects all nodes in the network where Onezone package has been installed and Onepanel service is running. You can configure on which nodes which Onezone each of the services will be installed.


### Step 2: Application ports check.

In order to work properly Onezone needs a number of ports (443, 53) open on machine. In this step Onezone ensures that all needed ports are open.

<p align="center"><img src="img/admin/oz_step3_ports_check.png"></p>


### Step 3: System limits configuration.

Administrators may impose limit on a number of opened files by Onezone, services and processes spawned by them.

<p align="center"><img src="img/admin/oz_step4_system_limists.png"></p>
