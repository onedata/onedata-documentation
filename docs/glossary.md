# Glossary
<!-- short description of each concept with links to proper sections -->

## Auto-cleaning
Mechanism that automatically maintains storage usage at a certain 
level and ensures that there is enough space for new replicas when performing continuous computations.
The mechanism uses the statistics collected by the 
[*file popularity*](#file-popularity) to determine
the least popular file replicas in a [*space*](#space) and to evict them.
Learn more [here](admin-guide/oneprovider/configuration/auto-cleaning.md).

## CDMI

Standardized interface for managing Cloud storage and accessing data held in it. 
Learn more [here](user-guide/cdmi.md).

## Cluster

## Cluster manager

## Couchbase

## File Id
A unique, global identifier associated with a file or directory.
Learn more [here](user-guide/data.md#file-id).

## File path
Uniquely specifies the location of a file or directory.
Learn more [here](user-guide/data.md#file-path).

## File popularity
Enables tracking of usage statistics for files in a [*space*](#space).
Used by [*auto-cleaning*](#auto-cleaning) mechanism to clean up the least popular file replicas.
Learn more [here](admin-guide/oneprovider/configuration/file-popularity.md).

## File registration
Allows users to register files located on an [imported storage](#imported-storage) in order to 
reflect external datasets in a Onedata space.
Learn more [here](user-guide/file-registration.md).

## Group

## Handle

## Handle service

## Harvester

## Imported storage
[*Storage resource*](#storage) marked as `Imported storage` in the configuration. 
Enables [*Storage import*](#storage-import) when used to support a space.
Learn more [here](admin-guide/oneprovider/configuration/storages.md#imported-storage).

## Let’s Encrypt

## LUMA
LUMA (Local User Mapping) is a database that stores mappings between Onedata user accounts and local user 
accounts/credentials on storage resources. It establishes a relation between members of a Onedata space and user 
accounts recognized by different storage providers.
Learn more [here](admin-guide/oneprovider/configuration/luma.md).

## Oneclient
(Oneclient)[./user-guide/oneclient.md] is the Onedata command line interface
for mounting distributed virtual filesystem on local machines.


## Onepanel
Service dedicated for administration of a [*cluster*](#cluster) ([*Onezone*](#onezone) or [*Oneprovider*](#oneprovider)) and, 
at the same time, an integral part of the cluster. Referred to as *Onezone panel* or *Oneprovider panel* throughout the documentation. 
Offers a GUI, available via Onezone's *Clusters* menu or as an emergency interface (`https://$HOST:9443`) 
and a REST API (`https://$HOST:9443/api/v3/onepanel/`).

## Oneprovider

## Onezone

## REST API

## Space

## Storage
Storage resource recognized by a [*Oneprovider*](#oneprovider) and used to [*support*](#support) Onedata [*spaces*](#space).
Storages are registered in the [*Oneprovider panel*](#onepanel), using the GUI or REST API. 
Learn more [here](admin-guide/oneprovider/configuration/storages.md).

## Storage import
Mechanism dedicated for importing files located on a storage by registering them in a [*space*](#space) supported by
the [*storage*](#storage), without copying the data. 
Learn more [here](admin-guide/oneprovider/configuration/storage-import.md).

# Support

# Token
An alphanumeric string acting as a proof of authorization that can be used 
across the system to authenticate (**access token**), prove identity 
(**identity token**) or gain access to some resources (**invite token**). Tokens
must be kept secret, just like passwords or private keys/certificates. A token 
can look like the following: `MDAxNWxvY2F00aW9uIG9uZXpvbmUKMDAzYmlkZW500H5H...`.
Tokens are a universal way of accessing Onedata interfaces: [*REST API*](#rest-api), 
[*CDMI*](#cdmi) or [*Oneclient*](#oneclient). Learn more [here](user-guide/tokens.md).
