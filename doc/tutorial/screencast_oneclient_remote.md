
# Using Onedata Client From Remote Host

In this screencast you will learn how to install Onedata Client and how to connect to Onedata from a remote host (eg. your laptop at home).

* {% youtube caption="Using Onedata Client From Remote Host"%}https://youtu.be/ZLbtYWxcP28{% endyoutube %}


## Prerequisites
- access to a working Onedata Provider with public IP address
- access to a virtual machine with Centos 7


## Screencast Content Overview
This screencast presents the installation and usage of Onedata Linux client.

1. Installation of Onedata Client
2. Connecting Onedata Client with user account
3. Uploading files using Onedata Client


## Screencast Notes


### Onedata Client Installation Instructions for Centos 7
~~~
sudo wget -O /etc/yum.repos.d/onedata.repo http://packages.onedata.org/yum/centos/7x/onedata.repo 
sudo yum -y --enablerepo=onedata install oneclient
~~~

### Mounting user Spaces using authentication token
~~~
oneclient --no-check-certificate  --authentication token <mount_point>
~~~

### Forcing Onedata Client to connect to particular provider
~~~
export PROVIDER_HOSTNAME=<provider_ip_address>
~~~
