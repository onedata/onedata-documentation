
# Using Onedata Client with Direct I/O

In this screencast you will learn how to enable direct I/0 for Onedata Client.

* {% youtube caption="Using Onedata Client with Direct I/0"%}https://youtu.be/U2rG1rWjD44{% endyoutube %}


## Prerequisites
- have a Onedata account with at least one space supported by at least one Onedata Provider.
- oneclient software installed on a virtual machine (with Centos 7), which has a direct access to storage resource of the Onedata Provider

## Screencast Content Overview
This screencast presents the installation and usage of Onedata Linux client with direct I/O enabled. During the screencast discuss:

  1. why use direct I/0?
  2. how to use Oneclient with direct I/0 support.
  3. perform a simple benchmark with direct I/0 enabled.

## Screencast Notes

### All the commands used in the screencast with commentary (testes on Centos 7)
~~~
# check the status of oneprovider
sudo service oneprovider status

# check if oneclient is installed
oneclient --help

# make the directory where spaces will be mounted
mkdir <directory_name>

# use onedata client to mount spaces and use local oneprovider
PROVIDER_HOSTNAME=127.0.0.1 oneclient --authentication token --no-check-certificate myspaces

# add group with specyfic GID
sudo groupadd -g <gid> <some_space_name>

# add user to a group
sudo gpasswd -d <user_name> <group_name>

# check groups which user belongs to
id

# umount spaces directory
fusermount -u
~~~
