# Oneprovider Overview


Oneprovider exposes storage resources to Onedata ecosystem. It is typically deployed in a data or computing center, on the nodes equipped with high speed connections to storage resources.

Oneprovider is a cluster solution composed from three types of services:
* cluster manager - an administrative service that monitors, performs load balancing and manages other cluster nodes
* worker - a service responsible for data transfer
* database - a service providing persistent storage for control data

Each service can be deployed any number of times depending on a performance and reliability requirements. The cluster can be administered from any node, thanks to *onepanel* web application that runs on every node.

<p align="center">
<img src="img/admin/oneprovider_slide.png">
</p>

Oneprovider implements drivers for storages such as NFS, Luster, Ceph (Onedata v3.0) or S3 (Onedata v3.0).

In order to function properly oneprovider needs to communicate with [onedata.org](www.onedata.org) that requirers a public ip and specific ports open to the world.

There are two types of data transfer that oneprovider can engage in:
* control data transfer - originating form clients (ex. FUSE client)
* remote data transfer - happens between two providers when data needed by one provider is not aviable on local storage. This also involves oneprovider access to storage.

While accessing data, depending on a client location data transfer can be:
* direct access - when client is located in a same computing center and has direct access to storage resources, then client exchanges only control communication with oneprovider and accesses storage directly bypassing oneprovider.
* remote access - client is unable to access storage locally and needed data needs to be transferred via. oneproivder nodes.

Data stored in Oneprovider can be accessed using CDMI API, S3 API and using POSIX VFS.
