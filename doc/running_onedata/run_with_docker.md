# Running Onedata via Docker

This section explains in detail the Onedata installation, using as example Docker Compose recipes implementing various deployment scenarios.

Scenarios vary in complexity (&#x1F4D7; easy,  &#x1F4D8; medium, &#x1F4D5; hard) and some of them require &#x1F30D; public IP address to work.

You can either follow this quickstart or jump straight to onedata-quickstart [github repo](https://github.com/onedata/getting-started) where you will find source files for all scenarios presented here.

## Requirements
This tutorial uses Docker images of Onedata components, to follow it you need [Docker](www.docker.com) 1.11+ and [docker-compose](https://docs.docker.com/compose/) 1.7+ installed on your machine.

## Quickstart Git Repository
All the source files presented in this quickstart are available in Onedata quickstart repository on [github](https://github.com/onedata/getting-started). If you know Docker and want to quickly get your hands on Onedata, you can follow a readme [github](https://github.com/onedata/getting-started) and use this document as a reference guide.

## Scenarios
You can start using Onedata by either installing Oneprovider and registering with [onedata.org](onedata.org) or by deploying your own isolated Onedata installation. The first although easier, requires your machine to have a &#x1F30D; public IP address and a number of [open ports](../administering_onedata/provider_installation.md#Step 1&2: Connection check and Ports configuration).

At the moment we provide 3 setup scenarios:
- [pre-configured Oneprovider using onedata.org](docker/pre_oneprovider_docker.md) &#x1F4D7; &#x1F30D;
- [pre-configured complete Onedata Setup](docker/pre_onedata_docker.md) &#x1F4D8;
<!-- [setting up Onedata and configuring Onedata](docker/onedata_docker.md) &#x1F4D5;-->

In all scenarios we will need three Onedata components and three `docker-compose.yaml` files, each designed to set up a particular service. We will call them:

- `docker-compose-onezone.yaml` for Onezone service
- `docker-compose-oneprovider.yaml` for Oneprovider service
- `docker-compose-oneclient.yaml` for Oneclient 

each of them can be started using a docker-compose command:

```bash=
docker-compose -f "docker-compose-<component_name>.yaml" up
```

- 
