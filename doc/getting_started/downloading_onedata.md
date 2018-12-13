# Downloading Onedata

Onedata platform is composed of 3 basic components:
 * **Oneprovider** - service which manages actual storage resources contributed by storage providers
 * **Onezone** - service which enables federation of multiple storage providers into zones (*onedata.org* is an example of a zone)
 * **Oneclient** - command line tool for accessing and managing user spaces via virtual file system

The selection of components to install depends on the particular requirements.
End users typically only need to install *Oneclient* command-line tool.

The storage providers need to install at least one *Oneprovider* service in their datacenter on machines which have access to the storage resources. Since each *Oneprovider* service must be registered in some *Onezone* service, the storage provider has a choice to join existing zone (such as *onedata.org*) or establish their own, by setting up *Onezone* service.

Onedata components can be built from sources, installed from a pre-built release package or deployed by using ready-to-go docker images. If you do not plan on developing Onedata itself, we suggest using docker images.

## Download and install Onedata

### Docker
Currently the best way to install Onedata services is using Docker. We provide a complete set of [Docker images](https://hub.docker.com/u/onedata/) covering all Onedata services.

We prepared an [Administrator quickstart](admin_onedata_101.md) tutorial, which explains how to quickly setup a complete Onedata installation on a local machine.

For more advanced tutorials on running Onedata with Docker, see our [Getting Started](https://github.com/onedata/getting-started) repository on GitHub, which contains sample configuration files for various deployment types.


### Pre-built Linux packages

We provide packages *Oneprovider* and *Onezone* for:
- Ubuntu 16.04
- CentOS 7

and *Oneclient* packages for:
- Ubuntu 14.04, 16.04
- CentOS 7

The bash script at https://get.onedata.org, which can be downloaded with `wget` or `curl`, automatically downloads Onedata packages and installs them on your machine, provided that the operating system version is supported.

```
# wget version
wget -q -O - http://get.onedata.org/oneclient.sh | bash    # for oneclient
wget -q -O - http://get.onedata.org/oneprovider.sh | bash  # for oneprovider
wget -q -O - http://get.onedata.org/onezone.sh | bash      # for onezone

# curl version
curl -sS  http://get.onedata.org/oneclient.sh | bash       # for oneclient
curl -sS  http://get.onedata.org/oneprovider.sh | bash     # for oneprovider
curl -sS  http://get.onedata.org/onezone.sh | bash         # for onezone
```

For detailed instructions on installing Oneclient see [here](../using_onedata/oneclient.md).

For detailed instructions on installing Onezone see [here](../administering_onedata/onezone_tutorial.md) and for Oneprovider see [here](../administering_onedata/oneprovider_tutorial.md).

### Building from source

Onedata is composed of several components, to find instruction on building each of them from source please checkout our main README at our [GitHub repository](https://github.com/onedata/onedata).
