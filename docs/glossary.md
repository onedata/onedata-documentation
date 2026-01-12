# Glossary

<!-- short description of each concept with links to proper sections -->

<!-- TODO VFS-12857 fill missing entries -->

## Access control

A set of safety rules and procedures for granting or denying access to Onedata entities
(e.g. spaces) and data. For more information about spaces access control, refer to [this
page][space-members]. In case of the data access control, Onedata implements a multi-level
approach, as described [here][data access control].

## Access-control list (ACL)

A list of permissions associated with file or directory used for precisely grant or deny
access to it. Learn more [here][ACL].

## Archive

Snapshot of a [dataset][] created at a certain point in time.
Learn more [here][archive-more].

## Auto-cleaning

A process that automatically maintains storage usage at a certain level and ensures that
there is enough space for new replicas during continuous computations. The
process uses statistics collected by the [file popularity][] to determine the least
popular file replicas in a [space][] and to evict them. Learn more [here][auto-cleaning].

## Cloud Data Management Interface (CDMI)

Standardized interface for managing cloud storage and accessing data held in it.
Learn more [here][CDMI].

## Cluster

A set of hosts which together runs a single instance of [Onezone][] or [Oneprovider][]. The
cluster can consist of single or more nodes, each running with a subset of services like
[database][Couchbase], [Cluster Worker][], [Cluster Manager][], etc., to allow load balancing within a single
Onezone/Oneprovider. Learn more in the [Onezone cluster nodes][] and [Oneprovider cluster
nodes][] chapters.

## Cluster Manager

A component of Onedata services ([Oneprovider][], [Onezone][]), which coordinates [Cluster
Worker][] instances within a single [cluster][].

## Cluster Worker

A component of Onedata services ([Oneprovider][], [Onezone][]), which enables them to
easily scale on large number of nodes on a single cluster. Each Cluster Worker can be
configured for different tasks depending on the current needs (data access, metadata
management, etc.) by [Cluster Manager][] component.

## Couchbase

A highly scalable document-oriented database, which can be scaled to several nodes. It is
a crucial component of Onedata services. Learn more about its role in Onedata in the
[Architecture > Services][architecture services] chapter or visit the official [Couchbase website][].

## Data Discovery

Mechanisms that harvest the user-defined [metadata][6] assigned to
files in multiple [spaces][space] and submit it to indices, which can be
later browsed and queried. Logically divided into separate [harvesters][7]
that can have different configuration and source spaces.
Learn more [here][8].

## Dataset

File or directory marked by space users as representing data collections
relevant to them. They can be used to organize data in a space systematically and provide
an ability to create persistent snapshots — [archives][]. Learn more [here][dataset-more].

## File ID

A unique, global identifier associated with a file or directory.
Learn more [here][file-path-and-id].

## File metadata

Information that describes a file or directory. Can be roughly divided into
filesystem metadata, governed by the system, and user defined metadata, i.e.
extended attributes or custom RDF and JSON documents.
Learn more [here][10].

## File path

A string specifying the location of a file or directory in the Onedata filesystem.
Learn more [here][file-path-and-id].

## File popularity

Enables tracking of usage statistics for files in a [space][].
Used by [auto-cleaning][12] mechanism to clean up the least popular file replicas.
Learn more [here][13].

## File registration

Allows users to register files located on an [imported storage][14] in order to
reflect external datasets in a Onedata space.
Learn more [here][15].

## Group

<!-- TODO VFS-12857 fill missing entries -->

<!-- ## Handle -->

<!-- ## Handle service -->

## Harvester

An internal service that implements the mechanisms of [data discovery][16].
Similar to a [group][17] or [space][] in terms of logical representation
in the system, bringing together users or groups that are entitled to use it with
different privileges. Learn more [here][8].

## Imported storage

[Storage resource][18] marked as `Imported storage` in the configuration.
Enables [Storage import][19] when used to support a space.
Learn more [here][20].

<!-- ## Let’s Encrypt -->

## LUMA

LUMA (Local User Mapping) is a database that stores mappings between Onedata user accounts and local user
accounts/credentials on storage resources. It establishes a relation between members of a Onedata space and user
accounts recognized by different storage providers.
Learn more [here][21].

## Oneclient

Oneclient is a command line interface based on [FUSE][22]
for mounting the Onedata distributed virtual filesystem on local machines.
Learn more [here][23].

## OnedataFS

OnedataFS is a [PyFilesystem2][24] plugin that allows
accessing the user data programmatically using a python API.
Learn more [here][25].

## Onepanel

Service dedicated for administration of a [cluster][] ([Onezone][] or [Oneprovider][]) and,
at the same time, an integral part of the cluster. Referred to as *Onezone panel* or *Oneprovider panel* throughout the documentation.
Offers a GUI, available via Onezone's *Clusters* menu or as an emergency interface (`https://$HOST:9443`)
and a REST API (`https://$HOST:9443/api/v3/onepanel/`).

## Oneprovider

<!-- TODO VFS-12857 piece of software that is installed at a data provider site -->

## Onezone

<!-- TODO VFS-12857 fill missing entries -->

<!-- ## Provider -->

<!-- TODO VFS-12857 an entity that handles physical data storage as seen by Onedata users -->

## REST API

<!-- TODO VFS-12857 fill missing entries -->

## Service

## Space

A logical container for data, fundamental for organizing user data in Onedata.
Accessible only to its members — users or [groups][17] — that are assigned
fine-grained privileges. Learn more [here][29].

<!-- TODO VFS-12857 consider adding a chapter about users and linking it here -->

## Storage

Storage resource recognized by a [Oneprovider][] and used to [support][30] Onedata [spaces][space].
Storage backends are registered in the [Oneprovider panel][31], using the GUI or REST API.
Learn more [here][32].

## Storage import

Mechanism dedicated for importing files located on a storage by registering them in a [space][] supported by
the [storage][18], without copying the data.
Learn more [here][33].

## Support

A [storage][32] quota granted for
a [space][] on a physical storage backend by a [Oneprovider][].
Learn more [here][34].

## Token

An alphanumeric string acting as a proof of authorization that can be used
across the system to authenticate (**access token**), prove identity
(**identity token**) or gain access to some resources (**invite token**). Tokens
must be kept secret, just like passwords or private keys/certificates. A token
can look like the following: `MDAxNWxvY2F00aW9uIG9uZXpvbmUKMDAzYmlkZW500H5H...`.
Tokens are a universal way of accessing Onedata interfaces: [REST API][35],
[CDMI][36] or [Oneclient][37]. Learn more [here][38].

<!-- references -->

[data access control]: user-guide/data.md#data-access-control

[ACL]: user-guide/data.md#access-control-lists

[file popularity]: #file-popularity

[space]: #space

[auto-cleaning]: admin-guide/oneprovider/configuration/auto-cleaning.md

[CDMI]: user-guide/interfaces/cdmi.md

[6]: #file-metadata

[7]: #harvester

[8]: user-guide/data-discovery.md

[file-path-and-id]: user-guide/data.md#file-path-and-id

[10]: user-guide/metadata.md

[12]: #auto-cleaning

[13]: admin-guide/oneprovider/configuration/file-popularity.md

[14]: #imported-storage

[15]: user-guide/file-registration.md

[16]: #data-discovery

[17]: #group

[18]: #storage

[19]: #storage-import

[20]: admin-guide/oneprovider/configuration/storage-backends.md#imported-storage

[21]: admin-guide/oneprovider/configuration/luma.md

[22]: https://github.com/libfuse/libfuse

[23]: user-guide/interfaces/oneclient.md

[24]: https://github.com/PyFilesystem/pyfilesystem2

[25]: user-guide/interfaces/onedata-fs.md

[cluster]: #cluster

[Onezone]: #onezone

[Oneprovider]: #oneprovider

[29]: user-guide/spaces.md

[30]: #support

[31]: #onepanel

[32]: admin-guide/oneprovider/configuration/storage-backends.md

[33]: admin-guide/oneprovider/configuration/storage-import.md

[34]: user-guide/spaces.md#space-support

[35]: #rest-api

[36]: #cloud-data-management-interface-cdmi

[37]: #oneclient

[38]: user-guide/tokens.md

[archives]: #archive

[dataset]: #dataset

[archive-more]: user-guide/archives.md

[dataset-more]: user-guide/datasets.md

[space-members]: user-guide/spaces.md#space-members

[Onezone cluster nodes]: admin-guide/onezone/configuration/cluster-nodes.md

[Oneprovider cluster nodes]: admin-guide/oneprovider/configuration/cluster-nodes.md

[Cluster Manager]: #cluster-manager

[Cluster Worker]: #cluster-worker

[Couchbase]: #couchbase

[architecture services]: admin-guide/architecture.md#services

[Couchbase website]: https://www.couchbase.com/
