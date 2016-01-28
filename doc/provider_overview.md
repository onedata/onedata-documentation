# Oneprovider Overview


Oneprovider is a service that exposes storage resources to Onedata ecosystem. It is typically deployed in a computing center, on the nodes equipped with high speed connection to storage resources. Scalable and re

Oneprovider is a cluster solution composed from three types of services:
* Cluster Manager - an administrative services that provides user interface for installing oneprovider services
* Worker - a services responsible for computation and data transfer
* Database - a services providing persistent storage for control data

Each service can be deployed any number of times depending on a performance and reliability requirments.

<p align="center">
<img src="img/admin/oneprovider_slide.png">
</p>

Oneprovider needs ports `:443` and `:53` in order to communicate properly with Onedata ecosystem.

There are two types of data transfer that oneprovider can engage in:
* control data transfer - originating form clients (ex. FUSE client)
* remote data transfer - happens between two providers when data needed by one provider is not aviable on local storage. This also involves oneprovider access to storage.


While accessing data, depending on a client location data transfer can be:
* direct access - when client is located in a same computing center and has direct access to storage resources, then client exchanges only control communication with oneprovider and accesses storage directly bypassing oneprovider.
* remote access - client is unable to access storage locally and needed data needs to be transferred via. oneproivder nodes.

Oneprovider is responsible for providing access to data for CDMI, S3 and POSIX VFS protocols.
