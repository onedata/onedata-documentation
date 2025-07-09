# Overview

## Collaborative data sharing

Collaborative data sharing is a core feature of Onedata.
Users can collaborate by joining to the Onedata resources directly or via group membership:

* Groups allow members to access and manage with specified privileges shared resources.
* Each group can define custom privileges for every group member (user or other group), assigned by a group owner (or a user with a right to grant permissions).
* Resource owner can grant specific access rights to member users or groups.

A user's access to a resource is determined by:

* Their group memberships.
* Any direct access rights granted to them.

![image-access-to-resources][]

Some users also hold administrative privileges with extended capabilities.
Learn more about admin roles in [Onezone Panel][7] and [Oneprovider Panel][8].

## Basic GUI navigation

The main view contains the primary sections that allow you to interact
with the most important areas of the system. There, you can access
resources available to you or create your own.
You can switch between the main sections using the collapsible sidebar
on the left side of the page.

![image-main-tabs][]

Onedata main sections:

* Data — in the Data section, you can access and manage the Spaces
  you belong to, as well as create new ones. This is where you can
  organize your data and perform operations on files. For mor
  details see [Data][1].

* Shares — in the Shares section, you can view and manage files
  that have been shared (shares). Those files come from all your
  accessible spaces. For more details see [Shares][2].

* Providers — in the Providers section, you can view providers
  supporting your spaces. For more details see [Providers][3].

* Groups — in the Groups section, you can view and manage groups
  you are a member of. For more details see [Groups][4].

* Tokens — in the Tokens section, you can create and manage
  tokens used for authorization. For more details see [Tokens][5].

* Discovery — in the Discovery section, you can explore metadata indexing
  and perform advanced searching across files. For more details
  see [Data Discovery][6].

* Automation — in the Automation section, you can define and edit workflows
  (data processing pipelines).

* Clusters — the Clusters section provides an administrative interface
  for managing Onezone and Oneprovider instances. For more details see
  [Onezone Panel][7] and [Oneprovider Panel][8].

<!-- references -->

[1]: data.md#onedata-virtual-filesystem

[2]: shares.md#listing-all-shares-in-all-your-spaces

[3]: providers.md

[4]: groups.md#gui-guide

[5]: tokens.md

[6]: data-discovery.md

[7]: ../admin-guide/onezone/administration-panel.md

[8]: ../admin-guide/oneprovider/administration-panel.md

[image-main-tabs]: ../../images/user-guide/overview/main-tabs.png

[image-access-to-resources]: ../../images/user-guide/overview/access-to-resources.png
