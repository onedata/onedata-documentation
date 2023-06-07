# Quickstart

[toc]

Onezone consists of multiple zones, each specific to your organization, which should provide you with its domain.

This tutorial is based on an example of a publicly accessible zone:
[onezone.onedata.org](https://onezone.onedata.org/), which you can use to 
familiarize yourself with the system if your organization does not have its own zone.

## Log in

![log_in](../../images/user-guide/quickstart/log_in.png#screenshot)

As an end user, you can log in to Onedata only through Identity Providers (IdPs) determined by the zone administrators'
configuration. After selecting your IdP, you will be redirected to its page. Accept the authentication 
request to log in to Onedata. Once logged in, you will see the page with your data, depending on the zone's 
configuration. For managing your account, please refer to the [account-management](account-management.md) subsection.

If none of the IdPs from [onezone.onedata.org](https://onezone.onedata.org/) are suitable for you, you can contact 
us at *info@onedata.org* for a test account. 

> **NOTE:**  The green key icon is reserved for administrator login.

## First steps

In Onedata, all user data is organized into spaces. Spaces are logical containers that simplify 
data organization, providing a unified storage space and access control for users or groups. Each space requires at
least one supporting physical storage backend provided by data providers. For detailed information, refer to the
[spaces](spaces.md) chapter.

This comprehensive guide will assist you in creating your initial data space and uploading your first files.

1. If your organization already has preconfigured spaces for users, proceed to step 4.
2. To create your first space, follow the instructions in the 
[creating new space](spaces.md#create-or-join-a-new-space) guide. 
3. There are two methods for obtaining support for your space:
   * Request support from a provider by following the instructions in the 
   [requesting support for space](spaces.md#request-support-for-space) guide.
   * Set up your own provider (advanced).
4. To upload data navigate to **DATA > _Space name_ > Files**  and follow the instructions provided in the 
[uploading data](web-file-browser.md#uploading-data) guide. After uploading your data, you can explore various
options by left-clicking on a file. Double-clicking on a file will initiate the download.


## Useful links

The table below presents some of high-level concepts of Onedata.

| Concept             | Description                                                       | Link                                                      |
|---------------------|-------------------------------------------------------------------|-----------------------------------------------------------|
| Replication         | Replicate file blocks to the target provider.                     | [replication-and-migration](replication-and-migration.md) |
| Migration           | Replicate and remove the file replica from the source provider.   | [replication-and-migration](replication-and-migration.md) |
| Metadata            | Describe, assign custom attributes to files, directories.         | [metadata](metadata.md)                                   |
| Shares              | Share your data using publicly accessible links.                  | [shares](shares.md)                                       |
| Quality of Service  | Manage file replica distribution based on your requirements.      | [quality of service](quality-of-service.md)               |
| Datasets            | Organize related files together.                                  | [datasets](datasets.md)                                   |
| Archives            | Preserve your data for long-term access.                          | [archives](archives.md)                                   |
| Data discovery      | Index metadata from files, perform queries or browse metadata.    | [data discovery](data-discovery.md)                       |
| Deploy Onedata      | Deploy your own Onedata services for administration purposes.     | [admin guide](../admin-guide/overview.md)                 |
