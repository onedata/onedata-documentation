# Running Onedata Locally via Docker

To help you get up to speed with Onedata we provide a number of tutorials that allow you to deploy your own complete Onedata installation or just Oneprovider environment and become a part of Onedata worldwide ecosystem. 

Scenarios vary in complexity (&#x1F4D7; easy,  &#x1F4D8; medium, &#x1F4D5; hard) and some of them requirers &#x1F30D; public ip address to work.

You can either follow this quickstart or jump streight to onedata-quickstart [github repo](https://github.com/onedata/getting-started) where you will find source files for all scenarios presented here.

## Requirments
This tutorial uses docker images of Onedata components, to follow it you need [Docker](www.docker.com) 1.11+ and [docker-compose](https://docs.docker.com/compose/) installed on your machine. Onedate does provide *rpm* and *deb* packages, however they are not covered by this tutorial.

## Quickstart Git Repository
All the source files presented in this quickstart are aviable in Onedta quicstart repository on [github](https://github.com/groundnuty/onedata-getting-started). If you know docker and want to quickly get your hands on Onedata, you can follow a readme [github](https://github.com/groundnuty/onedata-getting-started) and use this document as a reference guide.

## Scenarios
You can start using Onedata by either installing Oneprovider and registering with [onedata.org](onedata.org) or by deploying your own isolated Onedata installation. The first although easier, requirers your machine to have a &#x1F30D; public ip address and a number of [open ports](../administering_onedata/provider_installation.md#Step 1&2: Connection check and Ports configuration).

At the moment we provide three setup scenarios:
- [pre-configured Oneprovider using onedata.org](docker/pre_oneprovider_docker.md) &#x1F4D7; &#x1F30D;
- [pre-configured complete Onedata Setup](docker/pre_onedata_docker.md) &#x1F4D8;
<!-- [setting up Onedata and configuring Onedata](docker/onedata_docker.md) &#x1F4D5;-->

In the all scenarios we will need three Onedata components and three `docker-compose.yaml` files, each designed to set up a particular service. We will call them:

- `docker-compose-onezone.yaml` for Onezone service
- `docker-compose-oneprovider.yaml` for Oneprovider service
- `docker-compose-oneclient.yaml` for Oneclient 

each of them can be started using a docker-compose command:

```bash=
docker-compose -f "docker-compose-<component_name>.yaml" up
```

- 
