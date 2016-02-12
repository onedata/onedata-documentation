# Oneclient

Onedata provides a command-line based client that is able to mount your spaces in your local file system tree. Oneclient is based on [Fuse](https://github.com/libfuse/libfuse) and can be downloaded from [onedata.org](https://onedata.org/download). Please follow installation instructions that can be found there for your particular platform.

*After installing ensure that you are able to access `fusermount` tool, by running `fusermount -h`. In case you are not allowed to execute `fusermount`, ask your administrator to make you a member of a `fuse` group. If you have administrator rights to your machine, use command `gpasswd -a <username> fuse` to add your account to `fuse` group.*

## Authentication


In order to be able to mount your spaces you need to authenticate with [onedata.org](onedata.org). You can either use a certificate based authentication or an authentication token.

*NOTE: If you are connecting to a provider service which does not have a globally trusted certificate, you will have to use `--no-check-certificate` on every `oneclient` invocation.*

#### Authentication token
In order to get an authentication token, go to [onedata.org](onedata.org) Web user interface, press **Tokens** in the top menu and press **Authorization token** button. Copy the displayed token and type the following command:
~~~
> oneclient --authentication token MOUNT_POINT
Authorization Code: PASTE_TOKEN_HERE
~~~
Then simply paste the token into the command line.

#### X.509 Certificate
In case you have a valid X.509 certificate you can use it to mount your spaces without getting the access token.

The certificate has to be located in one of the following locations: 
* Environment variable **X509_USER_PROXY**
* Active Grid proxy certificate in `/tmp/x509up_u0`
* Environment variable **X509_USER_CERT**
* `$HOME/.globus/usercert.pem`
* `$HOME/.globus/usercred.p12`
* `$HOME/.globus/*.p12`
* `$HOME/.globus/*.pem + .key`

. In order to connect it to your account, go to *Manage account* page in Web user interface and click on your login name on the top menu. Next, select add certificate DN and paste the contents of your PEM certificate (without the private key).

Web interface will show a warning that this certificate is not verified yet, verification is done on first login using this certificate.


~~~
> oneclient --authentication certificate ./mnt/
Enter GRID pass phrase for your identity:
Warning ! You are trying to connect using unconfirmed certificate as: 'internal_Unknown_052b9069deba4fefc86c2904e60e9bc4'. Is it your account? (y/n): y
WARNING: For optimal performance, add user `USER` to following system groups and remount the filesystem:
	GID: 590774, space: `USER space`
oneclient has been successfully mounted in ./mnt
~~~

If this is the first time you are using this certificate to mount your spaces, `oneclient` will present a warning that the certificate is unverified and that this operation has to be confirmed.

For optimal performance, such as direct use of storage IO for local data, ask your administrator to add you to the group identified by GID presented by `oneclient` and remount your spaces.

In order to unmount your spaces, type:
~~~
> fusermount -u MOUNT_POINT
~~~

## Options

To see full set of `oneclient` command line options checkout the man page `man oneclient` or print help information `oneclient -h`.

~~~
> oneclient -h
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
