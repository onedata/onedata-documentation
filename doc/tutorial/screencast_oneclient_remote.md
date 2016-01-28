
# Installation and Use of Onedata Client

{% youtube caption="Installation and Use of Onedata Client"%}https://youtu.be/vyq_czO8ayg{% endyoutube %}


## Prerequisites
- access to a working Onedata Provider with publci ip address
- access to a virtual machine with Centos 7


## Screencast Content Overview
This screencasts presents the installation and usage of onedata linux client.

1. Installation of Onedata Client.
2. Connecting Onedata Client to user account.
3. Uploading files with Onedata Client.


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
