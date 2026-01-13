# Glossary

<!-- short description of each concept with links to proper sections -->

<!-- TODO VFS-12857 fill missing entries -->

## Access control

A set of policies and procedures for granting or denying access to Onedata entities
(e.g. [spaces][space]) and data. For more information about spaces access control, refer to [this
page][space-members]. In case of the data access control, Onedata implements a multi-level
approach, as described [here][data access control].

## Access-control list (ACL)

A list of permissions associated with file or directory used to precisely grant or deny
access to it. Learn more [here][ACL].

## Access token

See [token][].

## Archive

A snapshot of a [dataset][] created at a certain point in time.
Learn more [here][archive-more].

## Auto-cleaning

A process that automatically maintains storage usage at a certain level and ensures that
there is enough space for new replicas during continuous computations. The
process uses statistics collected by the [file popularity][] to determine the least
popular file replicas in a [space][] and to evict them. Learn more [here][docs-auto-cleaning].

## Cloud Data Management Interface (CDMI)

A standardized interface for managing cloud storage and accessing data held in it.
Learn more [here][docs-cdmi].

## Cluster

A set of hosts that together run a single instance of [Onezone][] or [Oneprovider][]. The
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

A highly scalable document-oriented database, used as a crucial component of Onedata
services. Learn more about its role in Onedata in the [Architecture > Services][docs-architecture-services] chapter or visit the official [Couchbase website][].

## Data Discovery

A feature that offers harvesting the user-defined [metadata][] assigned to
files in multiple [spaces][space] and submitting it to indices, which can be
later browsed and queried. Logically divided into separate [harvesters][harvester]
that can have different configurations and source spaces.
Learn more [here][docs-data-discovery].

## Dataset

A file or directory marked by space users as representing data collections
relevant to them. They can be used to organize data in a space systematically and provide
an ability to create persistent snapshots — [archives][]. Learn more [here][dataset-more].

## Digital Object Identifier (DOI)

A standardized [persistent identifier][], defined by International Organization for Standardization (ISO), used to uniquely identify digital objects such as academic publications, datasets, and official documents.

## File ID

A unique, global identifier associated with a file or directory.
Learn more [here][file-path-and-id].

## File metadata

Information that describes a file or directory. Can be roughly divided into
filesystem metadata, governed by the system, and user defined metadata, i.e.
extended attributes or custom RDF and JSON documents.
Learn more [here][docs-file-metadata].

## File path

A string specifying the location of a file or directory in the Onedata filesystem.
Learn more [here][file-path-and-id].

## File popularity

A feature that provides tracking the usage statistics for files in a [space][].
Used by the [auto-cleaning][] process to clean up the least popular file replicas.
Learn more [here][docs-file-popularity].

## File registration

A feature that allows users to register files located on an [imported storage][] in order to
reflect external data collections in a Onedata space.
Learn more [here][docs-file-registration].

## Group

An abstract entity that groups together a subset of users and other groups. Helps to manage
users' access and privileges to resources like [spaces][space]. Learn more
[here][docs-groups].

## Handle

An entity that represents an Open Access [persistent identifier][] (e.g. [DOI][]) and metadata
assigned to the [share][]. It is created by registering the share in a [handle service][] and
exposing it for discovery by [Public Data][] indexes via the OAI PMH protocol. This process makes
the data collection and metadata publicly available (without an account in Onedata) and
enables anyone to look it up in the Public Data indexes. Learn more
[here][docs-public-data].

## Handle service

A mediator that is used to register the [share][] in the Public Data indexing services, which results
in creating a [handle][]. Learn more [here][docs-public-data].

## Harvester

An internal service that provides implementation of [data discovery][] by harvesting the
user-defined [metadata][] across the files from the designated [spaces][space].
It is available to users or groups with appropriate privileges. Learn more
[here][docs-data-discovery].

## Identity provider (IdP)

A system that authenticates users and manages their digital identities by verifying
credentials and issuing identity information to other services. It enables single sign-on
(SSO) and secure access by allowing trusted applications to rely on the IdP for
authentication instead of handling credentials themselves. [Onezone][] provides support for
wide range of identity providers based on OIDC & SAML.

## Identity token

See [token][].

## Imported storage

A [storage backend][] that enables the [storage import][] feature on supported
[spaces][space]. Learn more [here][docs-imported-storage].

## Invite token

See [token][].

## Let's Encrypt

A non-profit certificate authority run by Internet Security Research Group (ISRG) that
provides X.509 certificates for Transport Layer Security (TLS) encryption without charging
fees. Thanks to the built-in Let's Encrypt client, Onedata can obtain and renew web
certificates on its nodes automatically. Learn more in the [Onezone web certificate][docs-onezone-web-certificate] and [Oneprovider web certificate][docs-oneprovider-web-certificate] documentation chapters, or visit the official [Let's Encrypt website][].

## Local User Mapping (LUMA)

A database that stores mappings between Onedata user accounts and local user
accounts/credentials on storage resources. It establishes a relation between members of a Onedata space and user
accounts recognized by different storage providers.
Learn more [here][docs-luma].

## Oneclient

A command line interface based on [FUSE][]
for mounting the Onedata distributed virtual filesystem on local machines.
Learn more [here][docs-oneclient].

## OnedataFS

A [PyFilesystem2][] plugin that allows
accessing the user data programmatically using a python API.
Learn more [here][docs-onedatafs].

## Onepanel

A [service][] dedicated for administration of a [cluster][] ([Onezone][] or [Oneprovider][])
and, itself, an integral part of the cluster. Referred to as *Onezone panel* or
*Oneprovider panel* throughout the documentation. It is accessible through the [Web GUI][] or
[REST API][]. For information about role of the Onepanel in Onedata architecture, see the
[Architecture > Services][docs-architecture-services] chapter of documentation. For
information about the Web GUI of Onepanel, see the [Onezone administration panel][] and
[Oneprovider administration panel][] chapters of documentation.

## Oneprovider

A [service][] dedicated for managing the data, installed at a data [provider][] site, and
registered in a [Onezone][]. Oneproviders cooperate in a peer-to-peer manner,
synchronizing information about commonly supported [spaces][space]. Like the Onezone,
Oneprovider can be deployed as a multi-node [cluster][]. It is accessible through the
various [interfaces][], i.a., the [Web GUI][], [REST API][] and [Oneclient][]. Learn more
[here][docs-intro-provider].

## Oneprovider panel

See [Onepanel][].

## Onezone

A [service][] implementing the Onedata [zone][] concept, which serves as a center of authority
and an entry point to the system, integrating with the [identity providers][identity provider].
A single Onezone allows registration of multiple [Oneproviders][Oneprovider],
to provide their storage resources to users. The Onezone also manages the core resources
of Onedata like [spaces][space], [groups][group], [shares][share], and more. It is
accessible through the various interfaces, i.a., the [Web GUI][] and [REST API][]. Learn more
[here][docs-intro-onezone].

## Onezone panel

See [Onepanel][].

## Persistent identifier

A long-lasting, globally unique reference to a digital or physical object that remains
stable over time, even if the object's location or metadata changes. It can be, e.g., a [DOI][]. Onedata supports assigning a persistent identifier to the [share][] using a [handle][].

## Provider

An entity that handles data storage as seen by Onedata users. Providers deploy
[Oneprovider][] services near physical storage resources, i.e. in computing and data
centers or even personal computers. Learn more [here][docs-intro-provider].

## Public Data

An extended [share][] that has been assigned a [persistent identifier][] (e.g. [DOI][]) and descriptive metadata. Learn more [here][docs-public-data].

## REST API

An interface to various Onedata [services][service], accessible through the HTTPS protocol, following
the RESTful API guidelines. You can browse Onedata REST API documentation 
[here][onedata-api].

## Service

A software that realizes certain roles in the Onedata software stack, communicating with other
services, to provide a complete ecosystem. There are three main services in Onedata:
[Onezone][], [Oneprovider][], and [Onepanel][].

## Space

A logical container for data, fundamental for organizing user data in Onedata.
Accessible only to its members — users or [groups][group] — that are assigned
fine-grained privileges. The actual data storage of a space is realized by the
[storage backends][storage backend] using [Oneproviders][Oneprovider].
Learn more [here][docs-spaces].

<!-- TODO VFS-12857 consider adding a chapter about users and linking it here -->

## Share

An entity that represents a semi-public link assigned to a file or directory allowing
anyone on the Internet to read the data. Shares in Onedata may have an optional
description and can be promoted to the Public Data using [handle][]. Read more
[here][docs-shares].

## Storage backend

A storage resource recognized by a [Oneprovider][] and used to [support][] Onedata [spaces][space].
Storage backends are registered in the [Oneprovider panel][], using the [Web GUI][] or [REST API][].
Learn more [here][docs-storage-backends].

## Storage import

A feature dedicated to importing files located on a storage by registering them in a
[space][] supported by the [storage backend][], without copying the data. Learn more
[here][docs-storage-import].

## Support

A [storage backend][] quota granted to a [space][] on a physical storage by [Oneprovider][].
Learn more [here][docs-space-support].

## Token

An alphanumeric string acting as a proof of authorization that can be used
across the system to authenticate (**access token**), prove identity
(**identity token**) or gain access to some resources (**invite token**). Tokens
must be kept secret, just like passwords or private keys/certificates. A token
can look like the following: `MDAxNWxvY2F00aW9uIG9uZXpvbmUKMDAzYmlkZW500H5H...`.
Tokens are a universal way of accessing Onedata interfaces: [REST API][],
[CDMI][] or [Oneclient][]. Learn more [here][docs-tokens].

## Web GUI

A graphical user interface of Onedata accessible via the web browser. Learn more [here][docs-web-gui].

## Zone

A central entity of a single Onedata ecosystem instance, which constitutes independent
data management platform, bringing together multiple data centers — [providers][provider].
The zone serves as a center of authority and an entry point to the system. It is managed
by the [Onezone][] service. Learn more [here][docs-intro-zone].

<!-- references -->

[ACL]: user-guide/data.md#access-control-lists
[archive-more]: user-guide/archives.md
[archives]: #archive
[auto-cleaning]: #auto-cleaning
[CDMI]: #cloud-data-management-interface-cdmi
[Cluster Manager]: #cluster-manager
[Cluster Worker]: #cluster-worker
[cluster]: #cluster
[Couchbase website]: https://www.couchbase.com/
[Couchbase]: #couchbase
[data access control]: user-guide/data.md#data-access-control
[data discovery]: #data-discovery
[dataset-more]: user-guide/datasets.md
[dataset]: #dataset
[docs-architecture-services]: admin-guide/architecture.md#services
[docs-auto-cleaning]: admin-guide/oneprovider/configuration/auto-cleaning.md
[docs-cdmi]: user-guide/interfaces/cdmi.md
[docs-data-discovery]: user-guide/data-discovery.md
[docs-file-metadata]: user-guide/metadata.md
[docs-file-popularity]: admin-guide/oneprovider/configuration/file-popularity.md
[docs-file-registration]: user-guide/file-registration.md
[docs-groups]: user-guide/groups.md
[docs-imported-storage]: admin-guide/oneprovider/configuration/storage-backends.md#imported-storage
[docs-intro-onezone]: user-guide/quickstart.md#introduction--onezone-service
[docs-intro-provider]: intro.md#providers
[docs-intro-zone]: intro.md#zones
[docs-luma]: admin-guide/oneprovider/configuration/luma.md
[docs-oneclient]: user-guide/interfaces/oneclient.md
[docs-onedatafs]: user-guide/interfaces/onedata-fs.md
[docs-oneprovider-web-certificate]: admin-guide/oneprovider/configuration/web-certificate.md
[docs-onezone-web-certificate]: admin-guide/onezone/configuration/web-certificate.md
[docs-public-data]: user-guide/public-data.md
[docs-shares]: user-guide/shares.md
[docs-space-support]: user-guide/spaces.md#space-support
[docs-spaces]: user-guide/spaces.md
[docs-storage-backends]: admin-guide/oneprovider/configuration/storage-backends.md
[docs-storage-import]: admin-guide/oneprovider/configuration/storage-import.md
[docs-tokens]: user-guide/tokens.md
[docs-web-gui]: intro.md#web-gui
[DOI]: #digital-object-identifier-doi
[file popularity]: #file-popularity
[file-path-and-id]: user-guide/data.md#file-path-and-id
[FUSE]: https://github.com/libfuse/libfuse
[group]: #group
[handle service]: #handle-service
[handle]: #handle
[harvester]: #harvester
[identity provider]: #identity-provider-idp
[imported storage]: #imported-storage
[interfaces]: user-guide/interfaces/overview.md
[Let's Encrypt website]: https://letsencrypt.org/
[metadata]: #file-metadata
[Oneclient]: #oneclient
[onedata-api]: https://onedata.org/#/home/api
[Onepanel]: #onepanel
[Oneprovider administration panel]: admin-guide/oneprovider/administration-panel.md
[Oneprovider cluster nodes]: admin-guide/oneprovider/configuration/cluster-nodes.md
[Oneprovider panel]: #oneprovider-panel
[Oneprovider]: #oneprovider
[Onezone administration panel]: admin-guide/onezone/administration-panel.md
[Onezone cluster nodes]: admin-guide/onezone/configuration/cluster-nodes.md
[Onezone]: #onezone
[persistent identifier]: #persistent-identifier
[provider]: #provider
[Public Data]: #public-data
[PyFilesystem2]: https://github.com/PyFilesystem/pyfilesystem2
[REST API]: #rest-api
[service]: #service
[share]: #share
[space-members]: user-guide/spaces.md#space-members
[space]: #space
[storage backend]: #storage-backend
[storage import]: #storage-import
[support]: #support
[token]: #token
[Web GUI]: #web-gui
[zone]: #zone
