# Architecture

[toc][1]

This section provides a high-level view of Onedata platform from the administrators'
perspective, including a brief overview of each of the components.

## Overview

The following diagram shows an example Onedata deployment including all major
functional components.

![image][architecture]

## Services

### Onezone
Onezone is a main component of Onedata enabling federated authentication and
authorization.
Onezone acts as an intermediary in a network of cooperating Oneproviders. It
stores metadata of system entities, i.e. users, groups, spaces and providers,
manages relations between them and informs all Oneproviders about any changes
that are in their region of interest.
As such, Onezone does not handle any actual data transfers and does not need
high-performance connectivity to any storage resources.

#### OnezoneWorker
OnezoneWorker serves as a worker process of Onezone service. The main
objective of OnezoneWorker is to provide logic for coordinating the Oneprovider
instances. Onezone service requires at least one OnezoneWorker instance. Adding
more nodes scales the cluster allowing for processing more requests in
parallel. OnezoneWorker instances are coordinated by **ClusterManager**
process, which should be deployed at least in one instance per entire cluster.
Adding cluster-manager nodes increases the fault tolerance of the Onezone
service.

It can be found in the process tree under the name `oz_worker`.

#### OnezonePanel

The main goal of Onepanel is to enable the configuration of Onezone cluster
components in a distributed environment. It provides a web GUI, which allows
for the configuration and management of ClusterManager, OnezoneWorker and
Couchbase database components.

It can be found in the process tree under the name `oz_panel`.

#### ClusterManager

ClusterManager is a background service, that is responsible for the proper
operation of other Onezone processes on a given host, support load-balancing of
internal requests and coordination of communication between processes.

ClusterManager can be found in the process tree under the name `cluster_manager`.

#### Couchbase

[Couchbase][couchbase] is a highly scalable JSON database,
which can be scaled to several nodes. This component is necessary for running
Onezone service, and it is responsible for storing all information about user
spaces, registered providers, etc. When deploying Onedata using a Docker
container or Kubernetes, Couchbase is started automatically.

#### Elasticsearch

Deployment of [Elasticsearch][elasticsearch] along with
Onezone, enables an Onedata feature called `Harvesters`, which allows performing
data and metadata queries on user spaces.
Elasticsearch is used to transparently index all data and metadata in an Onedata
space, which can then be queried using Onedata REST API.

#### Handle Proxy

Onedata supports Open Access identifier registration services based on Handle
systems such as [DOI][doi]. Since different identifier minting 
services provide different API's, Onezone administrator has to deploy and
register a handle proxy service, which implements a bridge between Onezone handle
API and an actual handle minting service, such as [DataCite][datacite].

An example implementation for B2HANDLE is available [here][hpsb2handle].

### Oneprovider
The main objective of Oneprovider service as a whole, is to unify access to
files stored at heterogeneous data storage systems that belong to
geographically distributed organizations.

#### OneproviderWorker

OneproviderWorker provides a self-scalable cluster, which manages the Onedata
system in a single data center, i.e. it stores meta-data about actual users'
data from the data center, provides several interfaces for data I/O operations
such as CDMI, REST and internal protocol enabling [Oneclient][0] POSIX-style access. Furthermore executes QoS data management rules, which can be defined by
administrators and users.

OneproviderWorker requires direct access to the storage resources it manages, so
it has to be deployed accordingly.

It can be found in the process tree under the name `op_worker`.

#### OneproviderPanel

The main goal of Onepanel is to enable the configuration of Oneprovider cluster
components in a distributed environment. It provides a web GUI, which allows
for configuration and management of ClusterManager, OneproviderWorker and Couchbase
database components as well as adding storage resources to the Oneprovider cluster
and supporting user spaces.

It can be found in the process tree under the name `op_panel`.

#### ClusterManager

ClusterManager is a background service, which is responsible for the proper
operation of other Oneprovider processes on a given host, support load-balancing of
internal requests and coordination of communication between processes.

ClusterManager can be found in the process tree under the name `cluster_manager`.

#### RTransferLink

RTransferLink is a high-performance data transfer service, managed directly by
OneproviderWorker. It is responsible for handling all data transfers between
Oneprovider services, including scheduled transfers, QoS transfers as well as
on-the-fly transfers triggered by data access requests.

RTransferLink is deployed and managed automatically, it can be found in the
process tree under the name `link`.

#### Couchbase

[Couchbase][couchbase] is a highly scalable JSON database,
which can be scaled to several nodes. This component is necessary for running
Oneprovider service, and it is responsible for storing all filesystem-related metadata.
It has to be ensured that sufficient disk space is available for this database,
especially in systems where large numbers of files and directories are added.
When deploying Onedata using Docker container or Kubernetes, Couchbase is
started automatically.

#### OpenFaaS

[OpenFaaS][openfaas] is a serverless Docker-based function
management and execution service, which enables seamless integration of custom
data or metadata processing logic. In Onedata, OpenFaaS is used to execute
user-defined workflows over their data spaces. Each function can run on top of a
mounted virtual POSIX filesystem provisioned by Oneclient, using native
POSIX-based API or use any of the other data access APIs provided by Onedata
including REST API, CDMI or S3.

### Oneclient

Oneclient is a command line Onedata client. It provides a POSIX interface to
the user's files in Onedata system based on [FUSE][fuse].

Oneclient can be deployed by the users on their local resources, as well as
administrators for instance on HPC access or worker nodes.

For optimal performance, Oneclient should have direct access to storage
resources (for instance in case of Ceph network access to Ceph Monitor or in
case of POSIX-like storages they need to be mounted on the Oneclient nodes).
However if not possible, Oneclient can also work in proxy mode, in which case
all data transfers will go via Oneprovider.

### OnedataFS

OnedataFS is a Python library, which provides high-performance access to
Onedata virtual filesystem directly from Python. OnedataFS implements the
[PyFilesystem2][pyfilesystem2] API.

> **NOTE:** OnedataFS can be preinstalled on user worker nodes using distribution
> packages, however it cannot be installed using `pip` due to native library
> dependencies.

### OneS3

OneS3 is a scalable S3 implementation based on Oneclient, which exposes storage
resources managed by Oneprovider via AWS S3 interface.

OneS3 requires direct access to the storage resources, thus it should be preferably
deployed in the same network as Oneprovider, however, it can be scaled to any number
of nodes, in which case it will handle data transfers, while Oneprovider instances
will only handle metadata management.


<!-- references -->

[0]: #oneclient

[architecture]: ../../images/admin-guide/architecture/onedata-architecture-overview.png

[couchbase]: https://www.couchbase.com

[elasticsearch]: https://www.elastic.co/elasticsearch/

[doi]: https://www.doi.org/

[datacite]: https://doi.datacite.org/

[hpsb2handle]: https://github.com/onedata/hps-b2handle

[openfaas]: https://www.openfaas.com/

[fuse]: https://github.com/libfuse/libfuse

[pyfilesystem2]: https://github.com/PyFilesystem/pyfilesystem2
