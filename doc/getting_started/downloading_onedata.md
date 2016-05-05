# Downloading Onedata

You can either build a release from sources, download a pre-built release or use ready-to-go docker images. If you do not plan on developing Onedata itself, we suggest a pre-built release.


## Download and Install Onedata

The bash script at https://get.onedata.org, which can be run with wget or curl, automatically downloads Onedata packages and installs them on your machine. 

### On Linux

```
# wget version
export ONEDATA_SERVICES="onezone,oneprovier,oneclient"; wget -q -O - https://get.onedata.org | bash

# curl version
export ONEDATA_SERVICES="onezone,oneprovier,oneclient"; curl -sS https://get.onedata.org | bash
```

As of now we only support:

* Fedora => 23

### With Docker 
If your Linux distribution is not supported you may run Onedata in Docker containers. We prepared a [Onedata Admin 101]() tutorial that will allow you to quickly setup a complete Onedata installation in your local machine. 

For more advanced tutorials on running Onedata with Docker, see [Running Onedata with Docker]() and [Docker Quickstart Scenarios]() sections. 

## Building from source

Get the Onedata source. If you are simply building a release from source there is no need to set up a full environment as all building happens in a Docker container.
Building a release is simple.

```
git clone https://github.com/onedata/onedata.git
cd onedata
make
```
For more details on the release process see the [build/]() directory

