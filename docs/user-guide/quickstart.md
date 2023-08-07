# Quickstart

[toc]()

Onezone consists of multiple zones, each specific to your organization,
which should provide you with its domain.

This tutorial is based on an example of a publicly accessible zone:
[onezone.onedata.org](https://onezone.onedata.org/), which you can use to
familiarize yourself with the system if your organization does not have its zone.

## Log in

![log in](../../images/user-guide/quickstart/log_in.png#screenshot)

To access Onedata, follow these steps for logging in through Identity Providers
(IdPs) configured by the zone administrators:

1. Select your IdP and get redirected to its page.
2. Accept the authentication request to log in.
3. Once logged in, access your data based on the zone's setup.
4. To manage your account, refer to the [account-management](account-management.md) subsection.

If the IdPs from [onezone.onedata.org](https://onezone.onedata.org/) don't suit you,
contact us at *<info@onedata.org>* for a test account.

::: tip NOTE
The green key icon is reserved for the administrator login.
:::

## First steps

In Onedata, all user data is organized into spaces. Spaces are containers
that streamline data organization, providing unified storage space and access control
for users or groups. Each space requires at least one supporting physical storage
backend provided by data providers. For details, see the [spaces](spaces.md) chapter.

This comprehensive guide will assist you in creating your initial data space
and uploading your first files.

1. If your organization already has preconfigured spaces for users, proceed to step 4.
2. To create your first space, follow the instructions in the
   [creating new space](spaces.md#create-or-join-a-new-space) guide.
3. There are two methods for obtaining support for your space:
   * Request support from a provider with the
     [request support for the space](spaces.md#request-support-for-space) guide.
   * Set up your provider (advanced).
4. To upload data navigate to **DATA > *Space name* > Files** and follow the
   [uploading data](web-file-browser.md#uploading-data) guide. After uploading
   your data, you can explore various options by left-clicking on a file.
   Double-clicking on a file will initiate the download.

## Useful links

The table below presents some of the high-level concepts of Onedata.

| Concept            | Description                                                     | Link                                                      |
| ------------------ | --------------------------------------------------------------- | --------------------------------------------------------- |
| Archives           | Preserve your data for long-term access.                        | [archives](archives.md)                                   |
| Data discovery     | Index metadata from files, perform queries, or browse metadata. | [data discovery](data-discovery.md)                       |
| Datasets           | Organize related files together.                                | [datasets](datasets.md)                                   |
| Metadata           | Describe and assign custom attributes to files and directories. | [metadata](metadata.md)                                   |
| Migration          | Replicate and remove file replicas from the source provider.    | [replication-and-migration](replication-and-migration.md) |
| Quality of Service | Manage file replica distribution based on your requirements.    | [quality of service](quality-of-service.md)               |
| Replication        | Replicate file blocks to the target provider.                   | [replication-and-migration](replication-and-migration.md) |
| Shares             | Share your data using publicly accessible links.                | [shares](shares.md)                                       |
| Deploy Onedata     | Deploy your own Onedata services for administration purposes.   | [admin guide](../admin-guide/overview.md)                 |
