# Oneclient

[[toc]]

Onedata provides a command-line based client that is able to mount your spaces
in your local file system tree. Oneclient is based on
[Fuse](https://github.com/libfuse/libfuse) and can be downloaded from
[onedata.org](https://onedata.org/download). Please follow installation
instructions that can be found there for your particular platform.

## Installation

### Linux
Oneclient is supported on several major Linux platforms including Ubuntu and
Fedora. To install oneclient using packages simply use the following command:

```bash
curl -sS  http://get.onedata.org/oneclient-2002.sh | bash
```

>After installing ensure that you are able to access `fusermount` tool, by
>running `fusermount -h`. In case you are not allowed to execute `fusermount`,
>ask your administrator to make you a member of the `fuse` group. If you have
>administrator rights to your machine, use command `gpasswd -a <username> fuse`
>to add your account to the `fuse` group.

>NOTE: The above command is only valid when installing a major release 20.02.*. For other version using appropriate suffix, e.g. `1902`.

### Anaconda
Since version `18.02.2` and `19.02.0-rc1` Oneclient can be installed using [Anaconda](https://anaconda.org),
from the official [Onedata conda repository](https://anaconda.org/onedata):

```bash
conda install -c onedata oneclient
```

or to install a specific version of oneclient

```bash
conda install -c onedata oneclient=20.02.5
```


## Authentication

In order to be able to mount your spaces you need to authenticate with a
specific Onezone service and obtain an access token. Access token can be
generated directly from the Web interface using *Access tokens* menu:

<p align="center"> <img src="../img/access_token_menu.png"> </p>

> IMPORTANT: Please make sure not to share or publish access tokens with anyone, access tokens should be treated as private keys which should be only used by their owners for authentication with Onedata services. In particular they should NOT be used for sharing your data with others - for this purpose you can issue special purpose tokens such as [space invite tokens](space_collaboration.md) or [group invite tokens](group_management.md).

If you are connecting to a provider service which does not have a globally
trusted certificate, you will have to use `-i` or `--insecure` on every
`oneclient` invocation or export `ONECLIENT_INSECURE=1` environment variable .


### Mounting spaces

The basic command line syntax to mount spaces using a specific Oneprovider is:
```bash
oneclient -H <PROVIDER_HOSTNAME> -t <ACCESS_TOKEN> <MOUNT_POINT>
```

or

```bash
export ONECLIENT_ACCESS_TOKEN=<CLIENT_TOKEN>

export ONECLIENT_PROVIDER_HOST=<DEFAULT_PROVIDER>

oneclient <MOUNT_POINT>
```

In order to unmount your spaces, type:

```bash
fusermount -uz <MOUNT_POINT>
```

#### Mounting selected spaces only

`oneclient` will present under the specified mountpoint all spaces available to
the user whose access token was passed on the command line.

It is however possible to limit the spaces which are visible, by providing a
white list of the spaces on the command line. This can be achieved using 2
options:

  * `--space <name>` -  every occurence of this option followed by the name of a space will limit the mounted spaces to the specified spaces (e.g. `--space Space1 --space Space2`)
  * `--space-id <id>` -  every occurence of this option followed by the id of a space will limit the mounted spaces to the specified spaces (e.g. `--space-id a58a461875b59988bd16eca960d8130b --space-id bd16eca960d8130ba58a461875b53451`)

## Options

### Direct I/O and Proxy I/O modes


By default `oneclient` will automatically try to detect if it can access storage supporting
mounted spaces directly, which significantly improves I/O performance as all read and write
operations go directly to the storage and not via the Oneprovider service.

This feature can be controlled using 2 command line options:

  * `--force-proxy-io` - disables Direct I/O mode, all data transfers will go via Oneprovider service
  * `--force-direct-io` - forces Direct I/O mode, any `read` or `write` operation will return `Operation not supported` error. The only exception is when the file is not accessible due to incorrect permissions on the storage, in such case the file will be accessed using proxy I/O mode.

> NOTE: Oneclient will be able to use direct I/O to a storage only if connected to the Oneprovider, which supports the space with this storage.  

### Buffering
`oneclient` employs an in-memory buffer for input and output data blocks, which can significantly
improve performance for various types of storages, in particular object based storages such as S3.

If for some reason this local cache is undesired, it can be disabled using `--no-buffer` option.

The buffer size can be also fine-tuned using the following options:

  * `--read-buffer-min-size` - minimum size of the read buffer for a single opened file,
  * `--read-buffer-max-size` - maximum size of the read buffer for a single opened file,
  * `--read-buffer-total-size` - maximum size of read buffer for all opened files, if this value is exceeded consecutive open files will be unbuffered,
  * `--write-buffer-min-size` - minimum size of the write buffer for a single opened file,
  * `--write-buffer-max-size` - maximum size of the write buffer for a single opened file,
  * `--write-buffer-total-size` - maximum size of write buffer for all opened files, if this value is exceeded consecutive open files will be unbuffered,

### Overriding storage helper parameters

Oneclient allows to override certain storage helper parameters in order to
customize direct access to storage from a Oneclient host to the storage. Use
cases for this feature include specifying custom mounpoint for POSIX storages,
alternate IP addresses for network storages (e.g. available over local network
from Oneclient host), etc.

For example, to tell Oneclient that storage with a NFS storage is mounted at
`/home/user1/nfs` the following option should be added to the Oneclient command
line: `--override 2bede2623303bc2a19696e5817e13c0b:mountPoint:/home/user/nfs`, where
`2bede2623303bc2a19696e5817e13c0b` is the storage Id of this storage.

The `--override` option takes 3 arguments separated by `:`:
* `storade ID` - this is Onedata internal storage Id, which can be obtained from Onepanel administrator interface or using REST API
* `parameter name` - this is the name of the storage helper parameter, these are specific to particular type of storage
* `parameter value` - a value, which should override the value specified in the Oneprovider when registering the storage

### Logging

In order to enable a verbose log, *oneclient* provides a `-v` flag which takes a single integer argument which determines the log verbosity:

- `-v 0` - *(default)* only serious errors
- `-v 1` - warnings and errors which are not fatal
- `-v 2` - verbose information on requests and their handling
- `-v 3` - trace function calls along with their arguments
- `-v 4` - binary messages between Oneclient and Oneprovider

> Please note that above level 2, the size of the logs can be substantial thus it is necessary to monitor free disk space. When the machine runs out of disk space, Oneclient will stop logging.


### Other options

To see full set of `oneclient` command line options checkout the man page
`man oneclient` or print help information using `oneclient -h`:

```bash
$ oneclient -h
Usage: oneclient [options] mountpoint

A Onedata command line client.

General options:
  -h [ --help ]                         Show this help and exit.
  -V [ --version ]                      Show current Oneclient version and 
                                        exit.
  -u [ --unmount ]                      Unmount Oneclient and exit.
  -c [ --config ] <path> (=/etc/oneclient.conf)
                                        Specify path to config file.
  -H [ --host ] <host>                  Specify the hostname of the Oneprovider
                                        instance to which the Oneclient should 
                                        connect.
  -P [ --port ] <port> (=443)           Specify the port to which the Oneclient
                                        should connect on the Oneprovider.
  -i [ --insecure ]                     Disable verification of server 
                                        certificate, allows to connect to 
                                        servers without valid certificate.
  -t [ --token ] <token>                Specify Onedata access token for 
                                        authentication and authorization.
  --space <name>                        Allows to specify which space should be
                                        mounted, where the value of the 
                                        argument is space name. Specify 
                                        multiple times for multiple spaces. If 
                                        not specified, all users spaces will be
                                        mounted.
  --space-id <id>                       Allows to specify which space should be
                                        mounted, where the value of the 
                                        argument is space id. Specify multiple 
                                        times for multiple spaces. If not 
                                        specified, all users spaces will be 
                                        mounted.
  -l [ --log-dir ] <path> (=/tmp/oneclient/0)
                                        Specify custom path for Oneclient logs.
  -v [ --verbose-log-level ] <level> (=0)
                                        Specify the verbosity level (0-3) for 
                                        verbose logs (only available in debug 
                                        builds).

Advanced options:
  --io-trace-log                        Enable detailed IO trace log 
                                        (experimental).
  --log-read-write-perf                 Enable read write performance logger.
  --force-proxy-io                      Force proxied access to storage via 
                                        Oneprovider for all spaces.
  --force-direct-io                     Force direct access to storage for all 
                                        spaces.
  --buffer-scheduler-thread-count <threads> (=1)
                                        Specify number of parallel buffer 
                                        scheduler threads.
  --communicator-pool-size <connections> (=10)
                                        Specify number of connections in 
                                        communicator pool.
  --communicator-thread-count <threads> (=4)
                                        Specify number of parallel communicator
                                        threads.
  --scheduler-thread-count <threads> (=1)
                                        Specify number of parallel scheduler 
                                        threads.
  --storage-helper-thread-count <threads> (=10)
                                        Specify number of parallel storage 
                                        helper threads.
  --no-buffer                           Disable in-memory cache for 
                                        input/output data blocks.
  --provider-timeout <duration> (=120)  Specify Oneprovider connection timeout 
                                        in seconds.
  --storage-timeout <duration> (=120)   Specify I/O storage timeout in seconds.
  --disable-read-events                 Disable reporting of file read events.
  --no-fullblock-read                   Disable fullblock read mode. With this 
                                        option read can return less data than 
                                        requested in case it is immediately 
                                        available and consecutive blocks need 
                                        to be prefetched from remote storage.
  --read-buffer-min-size <size> (=4096) Specify minimum size in bytes of 
                                        in-memory cache for input data blocks.
  --read-buffer-max-size <size> (=104857600)
                                        Specify maximum size in bytes of 
                                        in-memory cache for input data blocks.
  --read-buffer-prefetch-duration <duration> (=1)
                                        Specify read ahead period in seconds of
                                        in-memory cache for input data blocks.
  --write-buffer-min-size <size> (=20971520)
                                        Specify minimum size in bytes of 
                                        in-memory cache for output data blocks.
  --write-buffer-max-size <size> (=52428800)
                                        Specify maximum size in bytes of 
                                        in-memory cache for output data blocks 
                                        of a single opened file handle.
  --read-buffers-total-size <size> (=2097152000)
                                        Specify total maximum size in bytes of 
                                        in-memory cache for input data blocks 
                                        of all opened file handles. When 0, 
                                        read buffers are unlimited.
  --write-buffers-total-size <size> (=1048576000)
                                        Specify total maximum size in bytes of 
                                        in-memory cache for output data blocks 
                                        of all opened file handles. When 0, 
                                        write buffers are unlimited.
  --write-buffer-flush-delay <delay> (=5)
                                        Specify idle period in seconds before 
                                        flush of in-memory cache for output 
                                        data blocks.
  --min-block-prefetch-size <bytes> (=1048576)
                                        Specify the minimum prefetch block 
                                        size.
  --seqrd-prefetch-threshold <fraction> (=1.000000)
                                        Specify the fraction of the file, which
                                        will trigger replication prefetch after
                                        that part of the file is already 
                                        replicated (experimental).
  --rndrd-prefetch-threshold <fraction> (=1.000000)
                                        Specify the fraction of the file, which
                                        will trigger replication prefetch after
                                        that part of the file is already 
                                        replicated in random blocks across 
                                        entire file (experimental).
  --rndrd-prefetch-eval-frequency <count> (=50)
                                        Number of reads from single file handle
                                        which will be skipped before next 
                                        evaluation of cluster prefetch. 0 means
                                        that prefetch evaluation will be 
                                        performed on each read. (experimental).
  --rndrd-prefetch-block-threshold <count> (=0)
                                        Number of separate blocks after which 
                                        replication for the file is triggered 
                                        automatically. 0 disables this feature 
                                        (experimental).
  --rndrd-prefetch-cluster-window <size> (=20971520)
                                        Cluster window size for prefetching in 
                                        [bytes]. When -1 is provided, the 
                                        entire file is considered for 
                                        prefetching (experimental).
  --rndrd-prefetch-cluster-block-threshold <count> (=5)
                                        Number of separate blocks in a cluster 
                                        window around current read, after which
                                        replication of a cluster block (window)
                                        is triggered (experimental).
  --rndrd-prefetch-cluster-window-grow-factor <fraction> (=0.000000)
                                        Prefetch cluster window grow factor, 
                                        which enables the prefetch window to 
                                        grow proportionally to current 
                                        replication progress - 
                                        initial_window_size*[1+grow_factor*file
                                        _size*replication_progress/initial_wind
                                        ow_size)] (experimental).
  --prefetch-mode arg (=async)          Defines the type of block prefetch 
                                        mode. Possible values are: async, sync.
                                        Default is: async (experimental).
  --cluster-prefetch-threshold-random   Enables random cluster prefetch 
                                        threshold selection (experimental).
  --metadata-cache-size <size> (=5000000)
                                        Number of separate blocks after which 
                                        replication for the file is triggered 
                                        automatically.
  --readdir-prefetch-size <size> (=2500)
                                        Specify the size of requests made 
                                        during readdir prefetch (in number of 
                                        dir entries).
  --dir-cache-drop-after <seconds> (=300)
                                        Specify (in seconds) how long should 
                                        directories be cached since last 
                                        activity. When 0 is provided, the cache
                                        never expires.
  --tag-on-create <name>:<value>        Adds <name>=<value> extended attribute 
                                        to each locally created file.
  --tag-on-modify <name>:<value>        Adds <name>=<value> extended attribute 
                                        to each locally modified file.
  -r [ --override ] <storageId>:<name>:<value>
                                        Allows to override selected helper 
                                        parameters for specific storage, e.g. 
                                        'd40f2f63433da7c845886f6fe970048b:mount
                                        Point:/mnt/nfs'
  --emulate-available-space <bytes> (=0)
                                        When set to non-zero value, emulates 
                                        available space reported by stat system
                                        call to specified number of bytes.
  --enable-archivematica                Enable Archivematica mode.

FUSE options:
  -f [ --foreground ]         Foreground operation.
  -d [ --debug ]              Enable debug mode (implies -f).
  -s [ --single-thread ]      Single-threaded operation.
  -o [ --opt ] <mount_option> Pass mount arguments directly to FUSE.

Monitoring options:
  --monitoring-type <reporter>        Enables performance metrics monitoring - 
                                      allowed values are: graphite.
  --monitoring-level-basic            Sets monitoring reporting level to basic 
                                      - default.
  --monitoring-level-full             Sets monitoring reporting level to full.
  --monitoring-period <seconds> (=30) Performance metrics reporting period.
  --graphite-url <url>                Graphite url - required when 
                                      monitoring-type is 'graphite', the scheme
                                      can be either tcp or udp and default port
                                      is 2003
  --graphite-namespace-prefix <name>  Graphite namespace prefix.
```

## Using Oneclient from Docker
Oneclient can also be started without installation using our official Docker images:

```bash
docker run --privileged -e ONECLIENT_ACCESS_TOKEN=<ACCESS_TOKEN> \
-e ONECLIENT_PROVIDER_HOST=<PROVIDER_HOSTNAME> \
-d --name oneclient-1 onedata/oneclient:__ONEDATA_RELEASE__
```

This will start a Docker container with mounted spaces in `/mnt/oneclient`
directory (inside container). They can be accessed from another terminal,
for instance using:
```bash
docker exec -it oneclient-1 /bin/bash

ls /mnt/oneclient
```

## Running Oneclient as systemd service

In some scenarios it may be convenient to run Oneclient as a service which is mounted before certain other services (e.g. user jobs) are executed on the machine. For this purpose a simple systemd service script can be created, with accompanying environment file with proper definitions.

The environment file should be created at: `/etc/oneclient.env`

```ini
ONECLIENT_PROVIDER_HOST=<ONEPROVIDER_HOST>
ONECLIENT_ACCESS_TOKEN=<ACCESS_TOKEN>
ONECLIENT_MOUNT=/mnt/oneclient
```

After that the systemd service script `/etc/systemd/system/oneclient.service` can look like this:

```ini
[Unit]
Description = Oneclient service
After       = network.target

[Service]
EnvironmentFile=/etc/oneclient.env
# Create Oneclient mountpoint if necessary
ExecStartPre=/usr/bin/mkdir -p $ONECLIENT_MOUNT
# Start Oneclient
ExecStart=/opt/oneclient/bin/oneclient -i -o allow_other $ONECLIENT_MOUNT
# Unmount oneclient when stopping the service
ExecStop      = /bin/fusermount -uz $ONECLIENT_MOUNT
# Change to `always` to automatically restart Oneclient
Restart       = no
Type          = forking

[Install]
WantedBy    = multi-user.target
```

The oneclient service can then be used in the following way:

```bash
# Start oneclient
sudo systemctl start oneclient

# Start oneclient on machine startup
sudo systemctl enable oneclient

# Unmount oneclient
sudo systemctl stop oneclient

# Check oneclient status
sudo systemctl status oneclient
```

## Docker Volume Plugin

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

### Installation

The Onedata Docker volume plugin can be installed using packages which are
provided for Ubuntu Wily, Ubuntu Xenial, CentOS 7 and Fedora 23.

The easiest way is to use our automated installation script:

```
# Using cURL
$ curl -sSL http://packages.onedata.org/onedata-docker-volume-2002.sh | sh

# Or using wget
$ wget -qO- http://packages.onedata.org/onedata-docker-volume-2002.sh | sh
```

The script will automatically check for Docker and install latest Docker if
none is installed on the host, after a short warning message.

If an older version of Docker than required (1.13) is installed the script
will abort, and a newer Docker version must be installed manually.

After the install script completes, latest `oneclient` version will be
installed on the host, which can be verified using:

```
$ oneclient -V
Oneclient: __ONEDATA_RELEASE__
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

### Usage

Once the Onedata Docker volume plugin service is running, all users in the
`docker` group can create their volumes.

#### Creating volumes
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

#### Using volumes in containers

In order to attach a volume to container, simply start any Docker image and
attach the Onedata volume to some directory within the container, e.g.:

```
$ docker run -v my_volume:/spaces -it alpine ls /spaces

MySpace1
MySpace2
```

Please note, that the Docker image doesn't need any Onedata specific packages
installed.

#### Security

Docker volume plugins do have a serious security limitation, which allows any
user in the `docker` group to access any volumes on the host, regardless of
which user created them. Thus, it is advisable to only use Docker volume plugins
on machines with exclusive access or where only trusted users have access, as
they will be able to access any Onedata volume created on this host.
