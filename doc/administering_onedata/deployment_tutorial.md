# Installation tutorial

This section contains tutorials for installing and setting up production deployments of Onedata services. Before you start, please make sure that you have the necessary prerequisites.

## Hardware
Onedata services have some certain hardware requirements, which need to be met in order to deploy them without issues. For production deployments we recommend the following [system requirements](../system_requirements.md).

For test deployments these requirements can be lower, however make sure that the machines have at least 8GB of RAM and 4 vCPUs.

In case you want to connect a new Oneprovider instance to an existing Onezone instance, minimum 1 machine for the Oneprovider service is necessary.

In case you want to deploy a separate Onezone service and a Oneprovider instance, you will need minimum 2 separate machines.

## Software
Onedata can be deployed either using our official Docker images, or directly using packages.

In case of Docker deployments the only prerequisites are:
- [Docker](https://www.docker.com/) => 1.11
- [Docker Compose](https://docs.docker.com/compose/) => 1.7

In case of installation using packages, please make sure that you will be installing Onedata services on one of our supported platforms:
- Fedora 23
- Ubuntu 16.04


To install a complete Onedata deployment, start with [Onezone setup tutorial](onezone_tutorial.md).

To install only a Oneprovider service and connect it to an existing Onezone service, proceed to [Oneprovider setup tutorial](oneprovider_tutorial.md).
