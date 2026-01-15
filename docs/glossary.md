# Glossary

The glossary provides condensed information about Onedata-specific concepts and other key
terms in the context of our system, with links to the detailed documentation.

## Access control

A set of policies and procedures for granting or denying access to Onedata entities
(e.g., [spaces][space]) and data. For more information about space access control, refer to [this
page][docs-space-members]. In the case of the data access control, Onedata implements a multi-level
approach, as described [here][docs-data-access-control].

## Access-control list (ACL)

A list of permissions associated with a file or directory that is used to precisely grant or deny
access to it. Learn more [here][docs-acl].

## Access token

A [token][] for authentication, being a universal way of accessing Onedata
interfaces: [REST API][], [CDMI][], or [Oneclient][].

## Archive

A snapshot of a [dataset][] created at a certain point in time.
Learn more [here][docs-archives].

## Auto-cleaning

A process that automatically maintains storage usage at a certain level and ensures that
there is enough space for new replicas during continuous computations. Uses statistics
collected by the [file popularity][] to determine the least popular file replicas in a
[space][] and to evict them. Learn more [here][docs-auto-cleaning].

## Automation

A system for managing and running [workflows][workflow]. Learn more [here][docs-automation].

## Automation inventory

An organizational unit for storing [workflow schemas][workflow schema], [lambdas][lambda],
and managing their [members][member]. Learn more [here][docs-automation].

## Caveat

A confinement limiting the context in which a [token][] is valid, inscribed in the token
itself, e.g., limiting the validity of the token to a certain point in time, or target
[services][service]. Learn more [here][docs-token-caveats].

## Cloud Data Management Interface (CDMI)

A standardized interface for managing cloud storage and accessing data held in it.
Learn more [here][docs-cdmi].

## Cluster

A set of hosts that together run an instance of [Onezone][] or [Oneprovider][]. The
cluster can consist of one or more nodes, each running a subset of services, e.g.
[database][Couchbase], [Cluster Worker][], [Cluster Manager][]. Learn more in the
[Onezone cluster nodes][docs-onezone-cluster-nodes] and [Oneprovider cluster
nodes][docs-oneprovider-cluster-nodes] chapters.

## Cluster Manager

A component of Onedata services ([Oneprovider][], [Onezone][]), which coordinates [Cluster
Worker][] instances within a single [cluster][].

## Cluster Worker

A component of Onedata services ([Oneprovider][], [Onezone][]), which enables them to
easily scale on many nodes on a single cluster. Each Cluster Worker can be
configured for different tasks depending on the current needs (data access, metadata
management, etc.) by the [Cluster Manager][] component.

## Couchbase

A highly scalable document-oriented database, used as a crucial component of Onedata
services. Learn more about its role in Onedata in the
[Architecture][docs-architecture-services] chapter or visit the official
[Couchbase website][website-couchbase].

## Data Discovery

A feature that provides harvesting of the user-defined [metadata][] assigned to
files in multiple [spaces][space] and submits it to indices, which can be
later browsed and queried. Logically divided into separate [harvesters][harvester]
that can have different configurations and source spaces.
Learn more [here][docs-data-discovery].

## Data distribution

A layout of the physical data blocks on [storage backends][storage backend] for the file.
Managed automatically by [on-the-fly transfers][on-the-fly transfer], and manually using
data [replication][], [migration][], or [eviction][]. Learn more
[here][docs-data-distribution].

## Data transfer

A process of [replicating][replication], [evicting][eviction], or [migrating][migration]
data between [providers][provider]. Learn more [here][docs-data-transfers].

## Dataset

A file or directory marked by space users as representing data collections
relevant to them. They can be used to organize data in a space systematically and provide
an ability to create persistent snapshots — [archives][]. Learn more [here][docs-datasets].

## Digital Object Identifier (DOI)

A standardized [persistent identifier][], defined by the International Organization for
Standardization (ISO), used to uniquely identify digital objects such as academic
publications, datasets, and official documents.

## Direct member

A [member][] who has assigned privileges to the resource ([space][], [group][],
[harvester][], etc.) without an intermediate group.

## Effective privileges

A sum of all resources' privileges assigned [directly][direct member] and those inherited
via [group][] [membership][member] path.

## Emergency interface

A [Web GUI][] of [Onepanel][] accessible from the special `9443` port on the [service][] host.
Learn more in the [Oneprovider administration panel][docs-oneprovider-emergency-panel] and
the [Onezone administration panel][docs-onezone-administration-panel] chapters.

## Eviction (data)

A user-triggered action that changes the [data distribution][] of files in order to
remove replicated data blocks from a specific [provider][].

## Extended attributes

Custom key-value pairs that can be assigned to any file/directory and are compatible with
POSIX extended file attributes. Learn more [here][docs-metadata-xattrs].

## File ID

A unique, global identifier associated with a file or directory.
Learn more [here][docs-file-path-and-id].

## File metadata

Information that describes a file or directory. Can be roughly divided into
filesystem metadata, governed by the system, and user-defined metadata, i.e.,
extended attributes or custom RDF and JSON documents.
Learn more [here][docs-file-metadata].

## File path

A string specifying the location of a file or directory in the Onedata filesystem.
Learn more [here][docs-file-path-and-id].

## File popularity

A feature that provides tracking of usage statistics for files in a [space][].
Used by the [auto-cleaning][] process to clean up the least popular file replicas.
Learn more [here][docs-file-popularity].

## File registration

A feature that allows users to register files located on an [imported storage][] in order to
reflect external data collections in a Onedata space.
Learn more [here][docs-file-registration].

## Group

An abstract entity that organizes together a subset of users and other groups. Helps manage
users' access and privileges to resources like [spaces][space]. Learn more
[here][docs-groups].

## Handle

A representation of an [Open Access][] [persistent identifier][] and metadata,
assigned to the [share][]. Created by registering the share in a [handle service][] and
exposing it for discovery by [Public Data][] indexes via the OAI PMH protocol, making
the data collection and metadata publicly available and findable.
Learn more [here][docs-public-data].

## Handle service

A mediator used to register the [share][] in the Public Data indexing services, which results
in creating a [handle][]. Learn more [here][docs-public-data].

## Harvester

An internal service that provides the implementation of [data discovery][] by harvesting the
user-defined [metadata][] across the files from the designated [spaces][space].
Available to users or groups with appropriate privileges. Learn more
[here][docs-data-discovery].

## Identity provider (IdP)

A system that authenticates users and manages their digital identities. Enables single sign-on
(SSO) by allowing trusted applications, such as [Onezone][], to rely on the IdP for
authentication instead of handling credentials themselves. Onedata supports a
wide range of IdPs based on OIDC & SAML. Learn more [here][docs-oidc-saml].

## Identity token

A [token][] proving the identity.

## Imported storage

A [storage backend][] that enables the [storage import][] feature on supported
[spaces][space]. Learn more [here][docs-imported-storage].

## Invite token

A [token][] for gaining access to some Onedata resource, e.g., [space][],
[group][], [harvester][], etc.

## Lambda (workflows)

A contract between custom-defined operations and the automation system that serves as a
bridge for integrating custom logic into [workflows][workflow]. Encapsulates
specifications for operation interface, resource requirements, execution details, and
metadata.

## Lane (workflows)

A distinct processing stage within a [workflow][] that orchestrates data processing by routing
items from a source [store][] through parallel boxes containing tasks. Executes sequentially,
forming a processing pipeline.

## Let's Encrypt (LE)

A non-profit certificate authority run by the Internet Security Research Group (ISRG) that
provides web certificates without charging fees. Using the built-in LE client, Onedata can
obtain and renew web certificates on its nodes automatically. Learn more in the [Onezone
web certificate][docs-onezone-web-certificate] and [Oneprovider web
certificate][docs-oneprovider-web-certificate] chapters.

## Local User Mapping (LUMA)

A database that stores mappings between Onedata user accounts and local user
accounts/credentials on storage resources. It establishes a relation between members of a
Onedata space and user accounts recognized by different storage providers. Learn more
[here][docs-luma].

## Member

A [user][] or [group][] that has assigned specific privileges for a [space][], group,
[harvester][], [automation inventory][], or [cluster][]. Can be [direct][direct member] or
indirect (when a user or group gains privileges to the resource by being a member of another
group).

## Migration (data)

A user-triggered action that changes the [data distribution][] of files in order to
move data blocks between specific [providers][provider].

## Oneclient

A command-line interface based on [FUSE][website-fuse]
for mounting the Onedata distributed virtual filesystem on local machines.
Learn more [here][docs-oneclient].

## OnedataFileRestClient

A Python client to the Onedata file REST API, offering basic operations on files as a
concise, low-level library. Learn more [here][docs-onedata-file-rest-client].

## OnedataFS

A [PyFilesystem2][website-pyfilesystem2] plugin that allows
accessing the user data programmatically using a Python API.
Learn more [here][docs-onedatafs].

## OnedataRestFS

A [PyFilesystem2][website-pyfilesystem2] plugin that allows
accessing the user data programmatically using a Python API,
based on Onedata [REST API][].
Learn more [here][docs-onedata-rest-fs].

## Onepanel

A [service][] dedicated to the administration of a [cluster][] and, itself, an integral part
of the cluster. Accessible through the [Web GUI][] or [REST API][]. Learn more in the
[Architecture][docs-architecture-services], [Onezone administration
panel][docs-onezone-administration-panel], and [Oneprovider administration
panel][docs-oneprovider-administration-panel] chapters.

## Oneprovider

A [service][] dedicated to managing the data, installed at a data [provider][] site as a
[cluster][], and gets registered in a [Onezone][]. Oneproviders cooperate in a
peer-to-peer manner, synchronizing information about commonly supported [spaces][space].
Accessible through the various [interfaces][docs-interfaces], i.a., the [Web GUI][], [REST API][],
and [Oneclient][]. Learn more [here][docs-intro-provider].

## Oneprovider panel

A [Onepanel][] instance dedicated for administration of a [Oneprovider][] [cluster][].

## Onezone

A [service][] implementing the Onedata [zone][] concept, serving as a center of authority
(using [identity providers][identity provider]), and an entry point to the system.
Allows registration of multiple [Oneproviders][Oneprovider]
to provide their storage resources to users. Manages the core resources
of Onedata, e.g., [spaces][space], [groups][group], [shares][share] Accessible through
the various interfaces, i.a., the [Web GUI][] and [REST API][]. Learn more
[here][docs-intro-onezone].

## Onezone panel

A [Onepanel][] instance dedicated to the administration of a [Onezone][] [cluster][].

## On-the-fly transfer

A [transfer][] triggered by remote data access. Performed in the background by
Oneproviders when they are requested to serve file fragments that reside in a remote
location.

## Open Access (OA)

A publishing model that provides free, immediate, and unrestricted online access to
research outputs without financial, legal, or technical barriers.

## Persistent identifier

A long-lasting, globally unique reference to a digital or physical object that remains
stable over time, even if the object's location or metadata changes. It can be, e.g., a
[DOI][]. Onedata supports assigning a persistent identifier to the [share][] using a
[handle][].

## Provider

An entity that handles data storage as seen by Onedata users. Providers deploy
[Oneprovider][] services near physical storage resources, i.e., in computing and data
centers or even personal computers. Learn more [here][docs-intro-provider].

## Public Data

An extended [share][] that has been assigned a [persistent identifier][] (e.g., [DOI][])
and descriptive metadata. Learn more [here][docs-public-data].

## Quality of Service (QoS)

A feature that provides management of file replica [distribution][data distribution] and
redundancy between [providers][provider] supporting a [space][]. Learn more
[here][docs-qos].

## Replication (data)

A user-triggered action that changes the [data distribution][] of files in order to
copy data blocks to a specific [provider][].

## REST API

An interface to various Onedata [services][service], accessible through the HTTPS
protocol, following the RESTful API guidelines. You can browse the Onedata REST API
documentation [here][website-onedata-api].

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

## Space owner

A designated [user][], who is authorized to perform all operations, regardless of the
assigned privileges, in the [space][]. A space must always have at least one owner, but
there may be more. Learn more [here][docs-space-owner].

## Share

An entity that represents a semi-public link assigned to a file or directory, allowing
anyone on the Internet to read the data. Shares in Onedata may have an optional
description and can be promoted to the [Public Data][] using a [handle][]. Read more
[here][docs-shares].

## Storage backend

A storage resource recognized by a [Oneprovider][] and used to [support][] Onedata [spaces][space].
Storage backends are registered in the [Oneprovider panel][], using the [Web GUI][] or [REST API][].
Learn more [here][docs-storage-backends].

## Storage import

A feature dedicated to importing files located on a storage by registering them in a
[space][] supported by the [storage backend][], without copying the data. Learn more
[here][docs-storage-import].

## Store (workflows)

A container for data used and manipulated during a [workflow][] execution. Defined by a
store schema and created as a store instance. There are several types, such as a list store
or a tree forest store.

## Support

A [storage backend][] quota granted to a [space][] on a physical storage by [Oneprovider][].
Learn more [here][docs-space-support].

## Token

An alphanumeric string, like e.g. `MDAxNWxvY2F00aW9uIG9uZXpvbmUKMDAzYmlkZW500H5H...`,
acting as a proof of authorization, that can be used across the system to
[authenticate][access token], [prove identity][identity token], or [gain access][invite token]
to some resources. Must be kept secret. Learn more [here][docs-tokens].

## Transfer

See [data transfer][].

## User

An account in the Onedata, managed by a [Onezone][], with assigned authentication
methods ([identity providers][identity provider]), mostly created for a single
person. Could become a [member][] of Onedata resources.

## View

A result of continuous indexing of [file metadata][], mapped using a user-defined
function, and optionally reduced using a reduce function. Learn more [here][docs-views].

## Web GUI

A graphical user interface of Onedata, accessible via a web browser. Learn more [here][docs-web-gui].

## Workflow

A user-defined process for orchestrating complex data processing through a series of
sequential [lanes][lane] and shared global [stores][store]. Consists of a
[schema][workflow schema], and an execution (the runtime instance). Stored in
[inventories][automation inventory]. Learn more [here][docs-automation].

## Workflow schema

A blueprint that defines how the [workflow][] should operate, specifying sequential
processing stages ([lanes][lane]), shared data storage ([stores][store]), and metadata
required to orchestrate complex data processing pipelines. Learn more [here][docs-automation].

## Xattrs

See [extended attributes][].

## Zone

A central entity of a single Onedata ecosystem instance, which constitutes an independent
data management platform, bringing together multiple data centers — [providers][provider].
Serves as a center of authority and an entry point to the system. Managed
by the [Onezone][] service. Learn more [here][docs-intro-zone].

<!-- references -->

[access token]: #access-token

[archives]: #archive

[auto-cleaning]: #auto-cleaning

[automation inventory]: #automation-inventory

[CDMI]: #cloud-data-management-interface-cdmi

[Cluster Manager]: #cluster-manager

[Cluster Worker]: #cluster-worker

[cluster]: #cluster

[Couchbase]: #couchbase

[data discovery]: #data-discovery

[data distribution]: #data-distribution

[data transfer]: #data-transfer

[dataset]: #dataset

[direct member]: #direct-member

[DOI]: #digital-object-identifier-doi

[eviction]: #eviction-data

[extended attributes]: #extended-attributes

[file metadata]: #file-metadata

[file popularity]: #file-popularity

[group]: #group

[handle service]: #handle-service

[handle]: #handle

[harvester]: #harvester

[identity provider]: #identity-provider-idp

[identity token]: #identity-token

[imported storage]: #imported-storage

[invite token]: #invite-token

[lambda]: #lambda-workflows

[lane]: #lane-workflows

[member]: #member

[metadata]: #file-metadata

[migration]: #migration-data

[on-the-fly transfer]: #on-the-fly-transfer

[Oneclient]: #oneclient

[Onepanel]: #onepanel

[Oneprovider panel]: #oneprovider-panel

[Oneprovider]: #oneprovider

[Onezone]: #onezone

[Open Access]: #open-access-oa

[persistent identifier]: #persistent-identifier

[provider]: #provider

[Public Data]: #public-data

[replication]: #replication-data

[REST API]: #rest-api

[service]: #service

[share]: #share

[space]: #space

[storage backend]: #storage-backend

[storage import]: #storage-import

[store]: #store-workflows

[support]: #support

[token]: #token

[transfer]: #transfer

[user]: #user

[Web GUI]: #web-gui

[workflow schema]: #workflow-schema

[workflow]: #workflow

[zone]: #zone

[docs-acl]: user-guide/data.md#access-control-lists

[docs-architecture-services]: admin-guide/architecture.md#services

[docs-archives]: user-guide/archives.md

[docs-auto-cleaning]: admin-guide/oneprovider/configuration/auto-cleaning.md

[docs-automation]: user-guide/automation.md

[docs-cdmi]: user-guide/interfaces/cdmi.md

[docs-data-access-control]: user-guide/data.md#data-access-control

[docs-data-discovery]: user-guide/data-discovery.md

[docs-data-distribution]: user-guide/data-distribution-and-metrics.md

[docs-data-transfers]: user-guide/data-transfers.md#overview

[docs-datasets]: user-guide/datasets.md

[docs-file-metadata]: user-guide/metadata.md

[docs-file-path-and-id]: user-guide/data.md#file-path-and-id

[docs-file-popularity]: admin-guide/oneprovider/configuration/file-popularity.md

[docs-file-registration]: user-guide/file-registration.md

[docs-groups]: user-guide/groups.md

[docs-imported-storage]: admin-guide/oneprovider/configuration/storage-backends.md#imported-storage

[docs-interfaces]: user-guide/interfaces/overview.md

[docs-intro-onezone]: user-guide/quickstart.md#introduction--onezone-service

[docs-intro-provider]: intro.md#providers

[docs-intro-zone]: intro.md#zones

[docs-luma]: admin-guide/oneprovider/configuration/luma.md

[docs-metadata-xattrs]: user-guide/metadata.md#extended-attributes

[docs-oidc-saml]: admin-guide/onezone/configuration/oidc-saml.md

[docs-oneclient]: user-guide/interfaces/oneclient.md

[docs-onedata-file-rest-client]: user-guide/interfaces/onedata-file-rest-client.md

[docs-onedata-rest-fs]: user-guide/interfaces/onedata-rest-fs.md

[docs-onedatafs]: user-guide/interfaces/onedata-fs.md

[docs-oneprovider-administration-panel]: admin-guide/oneprovider/administration-panel.md

[docs-oneprovider-cluster-nodes]: admin-guide/oneprovider/configuration/cluster-nodes.md

[docs-oneprovider-emergency-panel]: admin-guide/oneprovider/administration-panel.md#access-via-emergency-interface

[docs-oneprovider-web-certificate]: admin-guide/oneprovider/configuration/web-certificate.md

[docs-onezone-administration-panel]: admin-guide/onezone/administration-panel.md

[docs-onezone-cluster-nodes]: admin-guide/onezone/configuration/cluster-nodes.md

[docs-onezone-web-certificate]: admin-guide/onezone/configuration/web-certificate.md

[docs-public-data]: user-guide/public-data.md

[docs-qos]: user-guide/rule-based-replication-qos.md

[docs-shares]: user-guide/shares.md

[docs-space-members]: user-guide/spaces.md#space-members

[docs-space-owner]: user-guide/spaces.md#space-owner

[docs-space-support]: user-guide/spaces.md#space-support

[docs-spaces]: user-guide/spaces.md

[docs-storage-backends]: admin-guide/oneprovider/configuration/storage-backends.md

[docs-storage-import]: admin-guide/oneprovider/configuration/storage-import.md

[docs-token-caveats]: user-guide/tokens.md#token-caveats

[docs-tokens]: user-guide/tokens.md

[docs-views]: user-guide/views.md

[docs-web-gui]: intro.md#web-gui

[website-couchbase]: https://www.couchbase.com/

[website-fuse]: https://github.com/libfuse/libfuse

[website-onedata-api]: https://onedata.org/#/home/api

[website-pyfilesystem2]: https://github.com/PyFilesystem/pyfilesystem2
