
# Installation and Use of Onedata Client

The installation is explained step by step in the following screencast:

* {% youtube caption="Installation and Use of Onedata Client"%}https://youtu.be/vyq_czO8ayg{% endyoutube %}


## Prerequisites
- access to a working Onedata Provider with public IP address
- access to a virtual machine with Centos 7


## Screencast Content Overview
This screencast presents the installation and usage of Onedata Linux client.

1. Installation of Onedata Client.
2. Connecting Onedata Client with user account.
3. Uploading files using Onedata Client.


## Screencast Notes


### Onedata Client Installation Instructions for Centos 7
~~~
sudo wget -O /etc/yum.repos.d/onedata.repo http://packages.onedata.org/centos/7x/onedata.repo
sudo yum -y --enablerepo=onedata install oneclient
~~~

### Mounting user Spaces using authentication token
~~~
oneclient --no-check-certificate  --authentication token <mount_point>
~~~
