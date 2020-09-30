# Glossary
<!-- short description of each concept with links to proper sections -->

## Auto-cleaning
Mechanism that automatically maintains storage usage at a certain 
level and ensures that there is enough space for new replicas when performing continuous computations.
The mechanism uses the statistics collected by the 
[*file popularity*](#file-popularity) to determine
the least popular file replicas in the [*space*](#space) and to evict them.
Read more [here](docs/admin-guide/oneprovider/configuration/auto-cleaning.md).

## Cluster

## Cluster manager

## Couchbase

## File popularity
Mechanism that enables tracking of usage-statistics for files in the selected [*space*](#space).
Used by [*auto-cleaning*](#auto-cleaning) mechanism to cleanup the least popular file replicas.
Read more [here](docs/admin-guide/oneprovider/configuration/file-popularity.md).

## File registration
Mechanism dedicated for reflecting external datasets in a Onedata space.
Read more [here](docs/user-guide/file-registration.md).

## Group

## Handle

## Handle service

## Harvester

## Imported storage
[*Storage resource*](#storage) with enabled option `Imported storage` which allows enabling [*Storage import*](#storage-import).
Read more [here](docs/admin-guide/oneprovider/configuration/storages.md#imported-storage).

## Let’s Encrypt

## LUMA
LUMA is a database that stores mappings between Onedata user accounts and local user accounts/credentials on storage 
resources. It establishes a relation between members of a Onedata space and user accounts recognized by different 
storage providers.
Read more [here](docs/admin-guide/oneprovider/configuration/luma.md).

## Oneclient

## Onepanel

## Oneprovider

## Onezone

## Space

## Storage
Storage resource, exposed by [*Oneprovider*](#oneprovider) to support the [*space*](#space). 
Read more [here](docs/admin-guide/oneprovider/configuration/storages.md).

## Storage import
Mechanism dedicated for importing files located on a storage by registering them in the [*space*](#space) supported by
the [*storage*](#storage), without copying the data. 
Read more [here](docs/admin-guide/oneprovider/configuration/storage-import.md).
