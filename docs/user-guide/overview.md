# Overview

## Collaborative data sharing

Collaborative data sharing is a core feature of Onedata.
Users can collaborate by joining to the Onedata resources directly or via group membership:

* Groups allow members to access and manage shared resources with specified privileges.
* Each group can define custom privileges for every group member (user or other group), assigned by a group owner (or a user with a right to grant permissions).
* Resource owner can grant specific access rights to member users or groups.

A user's access to a resource is determined by:

* Their group memberships.
* Any direct access rights granted to them.

![image-access-to-resources][]

Let`s consider following example to better understand access model.

![image-effective-privs][]

The User can see all 3 spaces, but with different granted privileges.
If the user was removed from group C, they still would have access to Space Z (and X),
but not to Space Y.

Effective members are those who effectively have access to a resource, 
either by direct memberships or those inherited via groups.
All effective members of a group inherit the group's effective 
memberships and privileges. A user's effective privileges are a sum of 
all privileges inherited through all their membership paths 
(last segment only!).

Some users also hold administrative privileges with extended capabilities.
Learn more about admin roles in [Onezone Panel][7] and [Oneprovider Panel][8].

## Basic GUI navigation

In the main view you can see navigation bar containing primary sections which allow you to interact
with the most important areas of the system. There, you can access
resources available to you or create your own.
You can switch between the main sections using the collapsible sidebar
on the left side of the page.

![screen-main-tabs][]

Onedata main tabs:

* Data — in this tab, you can access and manage the Spaces
  you belong to, as well as create new ones. This is where you can
  organize your data and perform operations on files. For more
  details see [Data][1].

* Shares — in this tab, you can view and manage files
  that have been shared (shares). Those files come from all your
  accessible spaces. For more details see [Shares][2].

* Providers — in this tab, you can view providers
  supporting your spaces. For more details see [Providers][3].

* Groups — in this tab, you can view and manage groups
  you are a member of. For more details see [Groups][4].

* Tokens — in this tab, you can create and manage
  tokens used for authorization. For more details see [Tokens][5].

> Following tabs are intended for advanced users.

* Discovery — in this tab, you can explore metadata indexing
  and perform advanced searching across files. For more details
  see [Data Discovery][6].

* Automation — in this tab, you can define and edit workflows
  (data processing pipelines).

* Clusters — this tab provides an administrative interface
  for managing Onezone and Oneprovider instances. For more details see
  [Onezone Panel][7] and [Oneprovider Panel][8].

<!-- references -->

[1]: data.md

[2]: shares.md#listing-all-shares-in-all-your-spaces

[3]: providers.md

[4]: groups.md#gui-guide

[5]: tokens.md

[6]: data-discovery.md

[7]: ../admin-guide/onezone/administration-panel.md

[8]: ../admin-guide/oneprovider/administration-panel.md

[screen-main-tabs]: ../../images/user-guide/overview/main-tabs.png

[image-access-to-resources]: ../../images/user-guide/overview/access-to-resources.png

[image-effective-privs]: ../../images/user-guide/overview/effective-privs.png