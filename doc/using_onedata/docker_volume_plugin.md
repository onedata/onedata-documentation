# Onedata Docker volume plugin

<!-- toc -->

## Overview

[Docker volume plugins](https://docs.docker.com/engine/extend/plugins_volume/)
allow creation of Docker volumes independently of any containers, enabling
automatic connection between containers and custom storage systems, without
the necessity of installing any third party software inside the containers.

Onedata volume plugin allows to create volumes for your spaces. Each volume
represents a specific Oneclient set of settings in terms of Oneprovider host
and access token, i.e. multiple users can have different volumes on the same
host machine.

Using Onedata Docker volume plugins, enables users to access Onedata spaces
from their containers without having to manually start Oneclient neither on the
host or within the container.

## Installation

The Onedata Docker volume plugin can be installed using packages which are
provided for Ubuntu Wily, Ubuntu Xenial, CentOS 7 and Fedora 23.

The easiest way is to use our automated installation script:

```
# Using cURL
$ curl -sSL http://packages.onedata.org/onedata-docker-volume.sh | sh

# Or using wget
$ wget -qO- http://packages.onedata.org/onedata-docker-volume.sh | sh
```

The script will automatically check for Docker and install latest Docker if
none is installed on the host, after a short warning message.

If an older version of Docker than required (1.13) is installed the script
will abort, and a newer Docker version must be installed manually.

After the install script completes, latest `oneclient` version will be
installed on the host, which can be verified using:

```
$ oneclient -V
Oneclient: 18.02.0
FUSE library: 2.9
```

Onedata Docker volume plugin is installed as a systemd service, and can be
managed using `systemctl` command. After installation is complete it should
be enabled and started as follows:

```
$ sudo systemctl enable docker-volume-onedata.service
$ sudo systemctl start docker-volume-onedata.service
```

In order to check that the service is running properly, the following command
can be used and the expected output should look similar to this example:

```
$ sudo systemctl status docker-volume-onedata.service

● docker-volume-onedata.service - Onedata Docker volume plugin
   Loaded: loaded (/usr/lib/systemd/system/docker-volume-onedata.service; disabled; vendor preset: enabled)
   Active: active (running) since Wed 2017-08-02 11:08:59 CEST; 1h 56min ago
 Main PID: 5481 (docker-volume-o)
    Tasks: 3
   Memory: 1.2M
      CPU: 182ms
   CGroup: /system.slice/docker-volume-onedata.service
           └─5481 /usr/bin/docker-volume-onedata /var/lib/docker/plugins

Aug 02 22:08:59 ubuntu systemd[1]: Started Onedata Docker volume plugin.
Aug 02 22:08:59 ubuntu docker-volume-onedata[5481]: Plugins root: /var/lib/docker/plugins
Aug 02 22:08:59 ubuntu docker-volume-onedata[5481]: time="2017-08-02T11:08:59+02:00" level=info msg="Listening on Unix socket: /run/docker/plugins/onedata.so
```

## Usage

Once the Onedata Docker volume plugin service is running, all users in the
`docker` group can create their volumes.

### Creating volumes
A basic command to create a volume named `my_volume`, which mounts user spaces
from a specific Oneprovider and with a specific access token is as follows:

```
$ docker volume create --driver onedata \
        -o host=$ONEPROVIDER_HOSTNAME \
        -o token=$ACCESS_TOKEN \
        my_volume
```

In cases when connecting to a Oneprovider instance without a trusted certificate,
`-o insecure=true` option must be added. Additionally, Onedata Docker volume
plugins supports all regular
[Oneclient command line options](../using_onedata/oneclient.md), which must be
added with `-o` followed by option name, equal sign and value
(e.g. `-o force-direct-io=true -o read-buffer-max-size=52428800`):

After the volume is created successfully, it's settings can be checked using:
```
$ docker volume inspect my_volume

[
    {
        "Driver": "onedata",
        "Labels": {},
        "Mountpoint": "/var/lib/docker/plugins/volumes/6a539918ac2c5baf8c0dbf324fe3826f",
        "Name": "my_volume",
        "Options": {
            "host": "oneprovider.example.com",
            "insecure": "true",
            "token": "MDAxNWxvY2F00aW9uIG9uZXpvbmUKMDAzYmlkZW500aWZpZXIgRHR00WTg5dHNHOFZxSzVBZkJhamtaa004wMU5ocWc00azI3WkV00Z00ZkdDJSawowMDFhY2lkIHRpbWUgPCAxNTE5NDgyNDc4CjAwMmZzaWduYXR1cmUgt01Zu6WZ2Wqt3s02nUItRAVDBMYWx6BlBTNQ5KBNqQSDI1"
        },
        "Scope": "local"
    }
]
```

Creating volume does not automatically invoke Oneclient and does connect to
Oneprovider in anyway. Only when a container is started with this volume
attached, the Oneclient will be invoked. If multiple containers have the same
volume attached, the Oneclient will be automatically unmounted after the last
container is stopped.

To remove a volume simply run:

```
$ docker volume rm my_volume
```

This command will not remove any data, it will simply remove the volume entry
from local Docker configuration on the host.

### Using volumes in containers

In order to attach a volume to container, simply start any Docker image and
attach the Onedata volume to some directory within the container, e.g.:

```
$ docker run -v my_volume:/spaces -it alpine ls /spaces

MySpace1
MySpace2
```

Please note, that the Docker image doesn't need any Onedata specific packages
installed.

### Security

Docker volume plugins do have a serious security limitation, which allows any
user in the `docker` group to access any volumes on the host, regardless of
which user created them. Thus, it is advisable to only use Docker volume plugins
on machines with exclusive access or where only trusted users have access, as
they will be able to access any Onedata volume created on this host.
