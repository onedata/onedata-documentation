# Oneprovider Overview


Oneprovider is a service that exposes storage resources to Onedata ecosystem. It is typically deployed in a computing center, on the nodes equipped with high speed connection to storage resources. Scalable and re

Oneprovider is a cluster solution composed from 3 types of services:
* Cluster Manager - an administrative service that provides user interface for installing Oneprovider services
* Worker - a service responsible for managing data transfers
* Database - a services providing persistent storage for control data

Each service can be deployed multiple times depending on the performance and reliability requirements.

<p align="center">
<img src="img/admin/oneprovider_slide.png">
</p>

Oneprovider requires ports `:443` and `:53` in order to communicate properly with other Onedata providers and registry.

There are two types of data transfer that Oneprovider can engage in:
* control data transfer - originating from clients (e.g. FUSE client),
* remote data transfer - takes place between two providers when data needed by one provider is not avaiable on local storage. 


While accessing data, depending on a client location data transfer can be:
* direct access - when client is located in the same computing center and has direct access to storage resources, the client exchanges only control communication with oneprovider and accesses storage directly bypassing oneprovider for actual data transfer,
* remote access - client is unable to access storage locally and data needs to be transferred via oneprovider nodes.

Oneprovider is responsible for providing access to data for CDMI, S3 and POSIX VFS protocols.
