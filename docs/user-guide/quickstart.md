# Quickstart

[toc][1]

## Before you begin

If you are new to Onedata, we recommend starting with the [Introduction][] section, which
explains the basic concepts used throughout this guide.

## Onezone service

The Onedata software can be used to build different ecosystems. Each Onedata ecosystem
constitutes an independent data management platform made up of multiple data centers. At
the heart of each ecosystem lies the **Onezone service**, which serves as the entry point
to the system and coordinates the work of the underlying data providers.

To get started, make sure you can identify your Onezone service:

* If your institution is part of a Onedata ecosystem, they should direct you to the
  proper website.

* If you have access to [EGI][] services, or your Identity Provider is federated in
  [EGI Check-In][] for identity management, you may get access to the [EGI DataHub][]
  Onezone. All users there are granted access to the **PLAYGROUND** space for testing
  purposes. You can also use it to follow the Sandbox tutorial below, using the
  **PLAYGROUND** space on **datahub.egi.eu** instead of the **Sandbox** space on
  **demo.onedata.org**.

* If you are new to Onedata and don't have an account yet, you can log in to
  [demo.onedata.org][] to access the **Sandbox** environment, and follow the rest of
  this guide there.

* If you are a developer or sysadmin, consider setting up your own local deployment using
  the [demo mode][].

## Log in

Open the website of your Onezone service. A login screen offers a choice of Identity
Providers.

Each Onezone service may be configured differently. This tutorial uses a publicly
accessible zone, [demo.onedata.org][], which you can use to familiarize yourself with the
system if you don't have access to any Onedata service. You will need an [EGI][] or Google
account for that purpose. If you don't have one, [contact us][] and we will create a test
account for you.

![screen-log-in][]

Click your chosen Identity Provider and follow the steps to log in. You will need to
accept releasing your user information so that the Onezone service can authenticate you.

::: tip NOTE
The green key icon is reserved for the login of special users created through the
Onepanel administrative interface (see [Administrative Privileges][] for details).
Regular users should use social or institutional accounts to sign in.
:::

## Sandbox

All users logging in to [demo.onedata.org][] are granted access to the **Sandbox** space,
a good place to try out Onedata and test its features.

::: warning
The **Sandbox** space is a testing environment and comes with no guarantees. It is
cleaned if it becomes cluttered.

Do not store any private or sensitive data there, as it is available to all logged-in
users.
:::

If you have logged in and don't see the **Sandbox** space in the **DATA** tab, you may
not belong to the **All users** group. This can happen if you opted out of the group, or
if you first logged in before the Sandbox was set up. To fix it, join the group manually
by [consuming the token][] below:

```
MDAxZWxvY2F00aW9uIGRlbW8ub25lZGF00YS5vcmcKMDA3NmlkZW500aWZpZXIgMi9ubWQvdXNyLWMwNWU3M2EwZmE4NzQzOTI1NDE3ZGRjMDMzZTEwZWExY2g4NzQzL3VqZzphbGxfdXNlcnM6LzAyZDRmYTA3NGEwYTNlYTIzNTYwZDc00Yzg00YTA1Mjk1Y2gyYzE5CjAwMmZzaWduYXR1cmUgzFtuZQ5JPZ1KH1d8FhoNNy4bA1ToeILElN1F3FDwt0000K
```

### Create your own directory in the Sandbox

Navigate to the **DATA > Sandbox > Files** tab and create a new directory using the action
in the top right corner or the right-click menu. Give it a meaningful name:

![screen-create-directory][]

Right-click the new directory and choose **Permissions** from the context menu. Switch to
the **ACL** permission type and add a single entry for yourself that allows all
operations:

![screen-set-acl][]

Click **Save**, and you now have your own directory in the Sandbox space that no one else
can access ([ACLs][] implicitly deny access when no entry explicitly allows it). You can
use this directory to [upload some data][] and test Onedata features. If you want others
to see the results of your experiments, place your data in a location not secured by an
ACL.

## Next steps

To better understand Onedata and its features, we recommend the following chapters:

* [User Web interface][] — introduces the main sections of the GUI and explains how your
  memberships and privileges determine what you see and can do.
* [Spaces][] — gives an overview of this fundamental concept in Onedata.
* [Data][] — describes how data is organized and accessed.
* [Web file browser][] — guides you through all the features of the file browser in the
  Onedata web UI.
* [Account management][] — shows how to manage your Onedata account.
* Further reading — use the menu on the left to dive deeper into different aspects of
  Onedata.

## Explore further

The features behind the main GUI tabs (for example Shares, Tokens, Discovery and
Automation) are described in [User Web interface][]. Other topics worth knowing about:

| Topic                         | Description                                                           |
| ----------------------------- | --------------------------------------------------------------------- |
| [Replication and migration][] | Manage the distribution and replication of data.                      |
| [Metadata][]                  | Assign custom metadata to files and directories (JSON / RDF / xattr). |
| [Datasets][]                  | Organize related files together.                                      |
| [Archives][]                  | Preserve your data for long-term access.                              |
| [Quality of Service][]        | Manage file replica distribution based on declarative rules.          |
| [Deploy Onedata][]            | Deploy your own Onedata services.                                     |

## Want more?

If you have tested Onedata and would like the real thing, [contact us][]. We will see
what can be done to organize a fully-fledged Onedata ecosystem for your use cases.

<!-- references -->

[1]: <>

[Introduction]: ../intro.md

[Administrative Privileges]: ../admin-guide/administrative-privileges.md

[demo.onedata.org]: https://demo.onedata.org/

[EGI]: https://www.egi.eu/services/

[EGI Check-In]: https://www.egi.eu/service/check-in/

[EGI DataHub]: https://datahub.egi.eu

[demo mode]: ../admin-guide/demo-mode.md

[consuming the token]: tokens.md#consuming-invite-tokens

[ACLs]: data.md#access-control-lists

[upload some data]: interfaces/web-file-browser.md#uploading-data

[contact us]: https://onedata.org/#/home/contact

[User Web interface]: user-web-interface.md

[Spaces]: spaces.md

[Data]: data.md

[Web file browser]: interfaces/web-file-browser.md

[Account management]: account-management.md

[Datasets]: datasets.md

[Archives]: archives.md

[Metadata]: metadata.md

[Replication and migration]: data-transfers.md

[Quality of service]: rule-based-replication-qos.md

[Deploy Onedata]: ../admin-guide/overview.md

[screen-log-in]: ../../images/user-guide/quickstart/log-in.png

[screen-create-directory]: ../../images/user-guide/quickstart/create-directory.png

[screen-set-acl]: ../../images/user-guide/quickstart/set-acl.png
