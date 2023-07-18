## Backing up

If the standard installation procedure was followed, all data essential for 
the {{$frontmatter.serviceUpper}} service is placed in a single, self-contained directory 
(`/opt/onedata/{{$frontmatter.serviceLower}}`). This directory is sufficient to restore the 
service or migrate it to another host. It contains the configuration for 
running the docker container as well as the persistence directory which 
contains database files and service configuration. **Backing up the service
boils down to creating snapshots of the installation directory.**

> **NOTE:** Apart from the {{$frontmatter.serviceUpper}} service persistence that stores file
> metadata, administrators should back up the underlying storage systems 
> that store the physical data exposed via logical Onedata spaces. This guide
> does not cover storage data backups, you should use backup procedures 
> recommended for specific storage backend types.

Below are examples how [offline](./xd.part.md#offline-backups) and [live](#live-backups) 
backups can be performed. 
