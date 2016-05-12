# Downloading Onedata

You can either build a release from sources, download a pre-built release or use ready-to-go docker images. If you do not plan on developing Onedata itself, we suggest a pre-built release. 


## Download and Install Onedata
### Docker
Currently the best way to install Onedata is using Docker. We provide a complete set of Docker images covering all Onedata services.

#### Using Oneclient from Docker
If you already have an account at [onedata.org](onedata.org) or some other Onedata zone, you can simply mount your spaces to any folder using single docker command:
```
docker run ???
```

#### Installing Onedata storage provider services
We prepared a [Onedata Admin 101]() tutorial which explains how to quickly setup a complete Onedata installation on a local machine. 

For more advanced tutorials on running Onedata with Docker, see [Running Onedata with Docker]() and [Docker Quickstart Scenarios]() sections. 



### Building from source

Onedata build process is completely contained in a Docker environment. To build complete Onedata platform from sources simply follow these steps:

```
git clone https://github.com/onedata/onedata.git
cd onedata
make
```

### Pre-built Linux packages

*As of now we only support: Fedora => 23*

The bash script at https://get.onedata.org, which can be run with wget or curl, automatically downloads Onedata packages and installs them on your machine. 

```
# wget version
wget --no-check-certificate -q -O - https://get.onedata.org/oneclient.sh | bash    # for oneclient
wget --no-check-certificate -q -O - https://get.onedata.org/oneprovider.sh | bash  # for oneprovider
wget  --no-check-certificate -q -O - https://get.onedata.org/onezone.sh | bash      # for onezone

# curl version
curl --insecure -sS  https://get.onedata.org/oneclient.sh | bash       # for oneclient
curl --insecure -sS  https://get.onedata.org/oneprovider.sh | bash     # for oneprovider
curl --insecure -sS  https://get.onedata.org/onezone.sh | bash         # for onezone
```






