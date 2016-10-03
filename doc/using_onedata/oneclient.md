# Oneclient

<!-- toc -->

Onedata provides a command-line based client that is able to mount your spaces in your local file system tree. Oneclient is based on [Fuse](https://github.com/libfuse/libfuse) and can be downloaded from [onedata.org](https://onedata.org/download). Please follow installation instructions that can be found there for your particular platform.

*After installing ensure that you are able to access `fusermount` tool, by running `fusermount -h`. In case you are not allowed to execute `fusermount`, ask your administrator to make you a member of a `fuse` group. If you have administrator rights to your machine, use command `gpasswd -a <username> fuse` to add your account to `fuse` group.*

## Authentication

In order to be able to mount your spaces you need to authenticate with [onedata.org](onedata.org). You can either use a certificate based authentication or an authentication token.

*NOTE: If you are connecting to a provider service which does not have a globally trusted certificate, you will have to use `--no_check_certificate` on every `oneclient` invocation.*

#### Authentication token
In order to get an authentication token, go to [onedata.org](onedata.org) Web user interface, press **Tokens** in the top menu and press **Authorization token** button. Copy the displayed token and type the following commands:
~~~
export ONECLIENT_AUTHORIZATION_TOKEN=<CLIENT_TOKEN> 

export PROVIDER_HOSTNAME=<DEFAULT_PROVIDER>

oneclient --authentication token <MOUNT_POINT>
~~~
Then simply paste the token into the command line.

For optimal performance, such as direct use of storage IO for local data, ask your administrator to add you to the group identified by GID presented by `oneclient` and remount your spaces.

In order to unmount your spaces, type:
~~~
fusermount -u MOUNT_POINT
~~~

## Options

To see full set of `oneclient` command line options checkout the man page `man oneclient` or print help information using `oneclient -h`.

~~~
> oneclient -h
Usage: oneclient [options] mountpoint
General options:
  -h [ --help ]           print help
  -V [ --version ]        print version
  --config arg            path to user config file
  --authentication arg    authentication type to use for connection with a
                          Provider. Currently only 'token' method is supported.
  -d [ --debug ]          enable debug output (implies -f)
  --debug-gsi             enable GSI debug output
  --groups                list system groups user needs to join for optimal
                          performance and exit
  --no_check_certificate  disable remote certificate validation

FUSE options:
  -o opt,...            mount options
  -f                    foreground operation
  -s                    disable multi-threaded operation
~~~


## Using Oneclient from Docker
If you already have an account at [onedata.org](onedata.org) or some other Onedata zone, you can simply mount your spaces to any folder using single docker command:

```
docker run  --privileged -e ONECLIENT_AUTHORIZATION_TOKEN=$USER_ACCESS_TOKEN \
 -e PROVIDER_HOSTNAME=$ONEPROVIDER_HOSTNAME \
 onedata/oneclient:3.0.0-rc9
```

This will start a Docker container with mounted spaces in `/mnt/oneclient` folder (inside container). They can be accessed from another terminal, for instance using:
```
docker exec -it <docker_container_name> ls /mnt/oneclient
```
