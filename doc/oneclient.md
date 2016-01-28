# Oneclient Fuse Client

Onedata supplies a command line based client that is able to mount your spaces in your local file system tree.
Oneclient can be downloaed form [onedata.org](https://onedata.org/download).

Upon installing ensure that you are a member of a `fuse` group by using the `id` command. If not, use command `gpasswd -a <username> fuse` to add your user to fuse group.

## Authentication

In order to be able to mount your spaces you need to be able to authenticate with

~~~
[onedata@provider ~]$ oneclient -h
Usage: oneclient [options] mountpoint
General options:
  -h [ --help ]           print help
  -V [ --version ]        print version
  --config arg            path to user config file
  --authentication arg    authentication type to use for connection with a
                          Provider. Accepted values are 'token' and
                          'certificate'.
  -d [ --debug ]          enable debug output (implies -f)
  --debug-gsi             enable GSI debug output
  --groups                list system groups user needs to join for optimal
                          performance and exit
  --no-check-certificate  disable remote certificate validation
FUSE options:
  -o opt,...            mount options
  -f                    foreground operation
  -s                    disable multi-threaded operation
~~~
