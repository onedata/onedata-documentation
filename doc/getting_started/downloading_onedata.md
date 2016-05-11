# Downloading Onedata

You can either build a release from sources, download a pre-built release or use ready-to-go docker images. If you do not plan on developing Onedata itself, we suggest a pre-built release.


## Download and Install Onedata

The bash scripts at `https://get.onedata.org/` that can be run with wget or curl, automatically download Onedata packages and installs them on your machine. 

### On Linux

```bash=
# wget version
wget -q -O - https://get.onedata.org/oneclient.sh | bash    # for oneclient
wget -q -O - https://get.onedata.org/oneprovider.sh | bash  # for oneprovider 
wget -q -O - https://get.onedata.org/onezone.sh | bash      # for onezone

# curl version
curl -sS  https://get.onedata.org/oneclient.sh | bash       # for oneclient
curl -sS  https://get.onedata.org/oneprovider.sh | bash     # for oneprovider
curl -sS  https://get.onedata.org/onezone.sh | bash         # for onezone
```

As of now we only support:

* Fedora => 23

### With Docker 
If your Linux distribution is not supported you may run Onedata in Docker containers. We prepared a [Onedata Admin 101](admin_onedata_101.md) tutorial that will allow you to quickly setup a complete Onedata installation in your local machine. 

For more advanced tutorials on running Onedata with Docker, see [Running Onedata with Docker](../running_onedata/with_docker.md) and [Docker Quickstart Scenarios](../quickstart.md) sections. 

## Building from source

Get the Onedata source. If you are simply building a release from source there is no need to set up a full environment as all building happens in a Docker container.
Building a release is simple.

```bash=
# To build onezone package
git clone https://github.com/onedata/onedata.git
cd onedata
make

# To build oneclient and oneprovider packages
git clone https://github.com/onedata/onedata.git
cd onedata
make
```

<!--For more details on the release process see the [build/]() directory
-->
