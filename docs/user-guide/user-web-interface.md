# User Web interface

Onedata features a single, unified GUI for everyone. There is no separate
administrator interface and no fixed administrator role. Instead, every user can
be granted some administrative privileges, and the GUI shows and allows what
their privileges permit. The same person can, for example, manage a Oneprovider
cluster and also work with their spaces and groups in the same interface.

## Access to resources

Access to resources in Onedata is based on user [memberships][Membership model].
These memberships define the set of resources available to a user and which
operations are permitted. The GUI reflects these rules by showing only the
resources available to the given user, as described in the sections below.

## Basic GUI navigation

The main view contains a navigation bar with primary tabs, which give access to
the most important areas of the system. There you can access the resources
available to you or create your own. You can switch between the main tabs using
the collapsible sidebar on the left side of the page.

![screen-main-tabs][]

**Basic functionalities**

| Tab           | Description                                                                                                       |
| ------------- | ----------------------------------------------------------------------------------------------------------------- |
| [Data][]      | Access and manage the [spaces][] you belong to, create new ones, organize data,<br/> and perform file operations. |
| [Shares][]    | View and manage shared files from spaces you have access to.                                                      |
| [Providers][] | View providers supporting your spaces.                                                                            |
| [Groups][]    | View and manage the groups you are a member of.                                                                   |

**Advanced functionalities**

| Tab            | Description                                                                                                                              |
| -------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| [Tokens][]     | Create and manage tokens used for authorization.                                                                                         |
| [Discovery][]  | Explore metadata indexing and perform advanced searches across files.                                                                    |
| [Automation][] | Define and edit workflows (data processing pipelines).                                                                                   |
| Clusters       | Manage the [Onezone][Onezone admin panel] and [Oneprovider][Oneprovider admin panel] deployments that you have privileges to administer. |

## Clusters and administrative privileges

Memberships in Onedata clusters (Onezone and Oneprovider service deployments)
are especially important. If you belong to a cluster, it appears in the
**CLUSTERS** tab, from where you can manage the service within your granted
privileges, which may be limited (for example, to read-only access).

For more information about managing clusters, see [Cluster Administration][].
For details about administrative privileges, see [Administrative Privileges][].

<!-- references -->

[Membership model]: ./groups-memberships.md#membership-model-overview

[Cluster Administration]: ../admin-guide/oneprovider/administration-panel.md

[Administrative Privileges]: ../admin-guide/administrative-privileges.md

[Automation]: automation.md

[Data]: data.md

[Shares]: shares.md

[Groups]: groups-memberships.md#gui-guide

[Providers]: providers.md

[Tokens]: tokens.md

[Discovery]: data-discovery.md

[Onezone admin panel]: ../admin-guide/onezone/administration-panel.md

[Oneprovider admin panel]: ../admin-guide/oneprovider/administration-panel.md

[spaces]: spaces.md

[screen-main-tabs]: ../../images/user-guide/overview/main-tabs.png
