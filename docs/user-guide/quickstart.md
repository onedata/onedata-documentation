# Quickstart

[toc][1]

Onezone consists of multiple zones, each specific to the organization,
which provides you with its domain. There can be multiple Onezone instances
operated by various organizations. As a user, you have the flexibility to
choose the instance with which you intend to collaborate, among the available options.

This tutorial is based on an example of a publicly accessible zone:
[onezone.onedata.org][], which you can use to
familiarize yourself with the system if your organization does not have its zone.

## Log in

![screen-log-in][]

To access Onedata, follow these steps for logging in through Identity Providers
(IdPs) configured by the zone administrators:

1. Select your IdP and get redirected to its page.
2. Accept the authentication request to log in.
3. Once successfully logged in, you'll be able to access your data.
4. To manage your account, refer to the [account-management][] subsection.

As an alternative to using the provided IdPs from [onezone.onedata.org][],
you can also log in using your username and password, with the process being overseen by the
administrators of your zone. For more information or to request a test account,
contact the administrators at [info@onedata.org][].

::: tip NOTE
The green key icon is reserved for the login of administrators and special users created through
the Onepanel administrative interface. Regular users should use social or institutional accounts
to sign in.
:::

## First steps

In Onedata, all user data is organized into spaces. Spaces are containers
that streamline data organization, providing unified storage space and access control
for users or groups. Access management at the space level is through tokens, which serve various
purposes such as connecting to an existing space, inviting someone to a space, or requesting support.
Each space requires at least one supporting physical storage backend provided by data providers.
For details, see the [spaces][] chapter.

This comprehensive guide will assist you in creating your initial data space
and uploading your first files.

1. If your organization already has preconfigured spaces for users, proceed to step 4.
2. To create your first space, follow the instructions in the
   [creating new space][] guide.
3. There are two methods for obtaining support for your space:
   * Request support from a provider with the
     [request support for the space][] guide.
   * Set up your provider (advanced).
4. To upload data navigate to **DATA > *Space name* > Files** and follow the [uploading
   data][] guide. After uploading your data, you can explore various options by
   left-clicking on a file. Double-clicking on a file will initiate the download.

## Useful links

The table below presents some of the high-level concepts of Onedata.

| Concept            | Description                                                     | Link                          |
| ------------------ | --------------------------------------------------------------- | ----------------------------- |
| Tokens             | Authorize various actions across the system.                    | [tokens][]                    |
| Datasets           | Organize related files together.                                | [datasets][]                  |
| Archives           | Preserve your data for long-term access.                        | [archives][]                  |
| Metadata           | Describe and assign custom attributes to files and directories. | [metadata][]                  |
| Data discovery     | Index metadata from files, perform queries, or browse metadata. | [data discovery][]            |
| Migration          | Replicate and remove file replicas from the source provider.    | [replication and migration][] |
| Replication        | Replicate file blocks to the target provider.                   | [replication and migration][] |
| Quality of Service | Manage file replica distribution based on your requirements.    | [quality of service][]        |
| Shares             | Share your data using publicly accessible links.                | [shares][]                    |
| Deploy Onedata     | Deploy your own Onedata services for administration purposes.   | [admin guide][]               |

<!-- references -->

[1]: <>

[onezone.onedata.org]: https://onezone.onedata.org/

[screen-log-in]: ../../images/user-guide/quickstart/log-in.png

[account-management]: account-management.md

[info@onedata.org]: mailto:info@onedata.org

[spaces]: spaces.md

[creating new space]: spaces.md#create-or-join-a-new-space

[request support for the space]: spaces.md#request-support-for-space

[uploading data]: web-file-browser.md#uploading-data

[tokens]: tokens.md

[datasets]: datasets.md

[archives]: archives.md

[metadata]: metadata.md

[data discovery]: data-discovery.md

[replication and migration]: data-transfer.md

[quality of service]: qos.md

[shares]: shares.md

[admin guide]: ../admin-guide/overview.md
