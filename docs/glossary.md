# Glossary

<!-- short description of each concept with links to proper sections -->

<!-- TODO: VFS-7218 fill missing entries -->

## ACL

Mechanism for granting and denying access to files and directories.
Learn more [here][1].

## Auto-cleaning

Mechanism that automatically maintains storage usage at a certain
level and ensures that there is enough space for new replicas when performing continuous computations.
The mechanism uses the statistics collected by the
[*file popularity*][2] to determine
the least popular file replicas in a [*space*][3] and to evict them.
Learn more [here][4].

## CDMI

Standardized interface for managing Cloud storage and accessing data held in it.
Learn more [here][5].

## Cluster

## Cluster manager

## Couchbase

## Data Discovery

Mechanisms that harvest the user-defined [metadata][6] assigned to
files in multiple [spaces][3] and submit it to indices, which can be
later browsed and queried. Logically divided into separate [harvesters][7]
that can have different configuration and source spaces.
Learn more [here][8].

## File ID

A unique, global identifier associated with a file or directory.
Learn more [here][9].

## File metadata

Information that describes a file or directory. Can be roughly divided into
filesystem metadata, governed by the system, and user defined metadata, i.e.
extended attributes or custom RDF and JSON documents.
Learn more [here][10].

## File path

Uniquely specifies the location of a file or directory.
Learn more [here][11].

## File popularity

Enables tracking of usage statistics for files in a [*space*][3].
Used by [*auto-cleaning*][12] mechanism to clean up the least popular file replicas.
Learn more [here][13].

## File registration

Allows users to register files located on an [imported storage][14] in order to
reflect external datasets in a Onedata space.
Learn more [here][15].

## Group

## Handle

## Handle service

## Harvester

An internal service that implements the mechanisms of [data discovery][16].
Similar to a [group][17] or [space][3] in terms of logical representation
in the system, bringing together users or groups that are entitled to use it with
different privileges. Learn more [here][8].

## Imported storage

[*Storage resource*][18] marked as `Imported storage` in the configuration.
Enables [*Storage import*][19] when used to support a space.
Learn more [here][20].

## Let’s Encrypt

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

OnedataFS is a [PyFilesystem][24] plugin that allows
accessing the user data programmatically using a python API.
Learn more [here][25].

## Onepanel

Service dedicated for administration of a [*cluster*][26] ([*Onezone*][27] or [*Oneprovider*][28]) and,
at the same time, an integral part of the cluster. Referred to as *Onezone panel* or *Oneprovider panel* throughout the documentation.
Offers a GUI, available via Onezone's *Clusters* menu or as an emergency interface (`https://$HOST:9443`)
and a REST API (`https://$HOST:9443/api/v3/onepanel/`).

## Oneprovider

<!-- TODO: VFS-7218 piece of software that is installed at a data provider site -->

## Onezone

## Provider

<!-- TODO: VFS-7218 an entity that handles physical data storage as seen by Onedata users -->

## REST API

## Space

A logical container for data, fundamental for user data organization in Onedata.
Accessible only to its members – users or [groups][17] – that are assigned
fine grained privileges. Learn more [here][29].

<!-- TODO VFS-7218 consider adding a chapter about users and linking it here -->

## Storage

Storage resource recognized by a [*Oneprovider*][28] and used to [*support*][30] Onedata [*spaces*][3].
Storages are registered in the [*Oneprovider panel*][31], using the GUI or REST API.
Learn more [here][32].

## Storage import

Mechanism dedicated for importing files located on a storage by registering them in a [*space*][3] supported by
the [*storage*][18], without copying the data.
Learn more [here][33].

## Support

A [storage][32] quota granted for
a [space][3] on a physical storage backend by a [Oneprovider][28].
Learn more [here][34].

## Token

An alphanumeric string acting as a proof of authorization that can be used
across the system to authenticate (**access token**), prove identity
(**identity token**) or gain access to some resources (**invite token**). Tokens
must be kept secret, just like passwords or private keys/certificates. A token
can look like the following: `MDAxNWxvY2F00aW9uIG9uZXpvbmUKMDAzYmlkZW500H5H...`.
Tokens are a universal way of accessing Onedata interfaces: [*REST API*][35],
[*CDMI*][36] or [*Oneclient*][37]. Learn more [here][38].

<!-- references -->

[1]: user-guide/data.md#access-control-lists

[2]: #file-popularity

[3]: #space

[4]: admin-guide/oneprovider/configuration/auto-cleaning.md

[5]: user-guide/cdmi.md

[6]: #file-metadata

[7]: #harvester

[8]: user-guide/data-discovery.md

[9]: user-guide/data.md#file-id

[10]: user-guide/metadata.md

[11]: user-guide/data.md#file-path

[12]: #auto-cleaning

[13]: admin-guide/oneprovider/configuration/file-popularity.md

[14]: #imported-storage

[15]: user-guide/file-registration.md

[16]: #data-discovery

[17]: #group

[18]: #storage

[19]: #storage-import

[20]: admin-guide/oneprovider/configuration/storages.md#imported-storage

[21]: admin-guide/oneprovider/configuration/luma.md

[22]: https://github.com/libfuse/libfuse

[23]: user-guide/oneclient.md

[24]: https://www.pyfilesystem.org/

[25]: user-guide/onedatafs.md

[26]: #cluster

[27]: #onezone

[28]: #oneprovider

[29]: user-guide/spaces.md

[30]: #support

[31]: #onepanel

[32]: admin-guide/oneprovider/configuration/storages.md

[33]: admin-guide/oneprovider/configuration/storage-import.md

[34]: user-guide/spaces.md#space-support

[35]: #rest-api

[36]: #cdmi

[37]: #oneclient

[38]: user-guide/tokens.md
