# Administration panel

[toc][]

## Overview

The administration panel, provided by the Onepanel service, is responsible for
managing the Oneprovider cluster. Examples of tasks performed with Onepanel
include:

* installing Oneprovider using the [graphical wizard][],
* [managing certificates][],
* adding new [storage backends][],
* [supporting spaces][] with existing storage backends,
* and others in the [Configuration][] subsection.

All of these tasks are available both as a web application and through a
[REST API][]. Their usage is described in the *Configuration* subsection.

## Accessing the administration panel

The administration panel is part of the unified [User Web interface][], so you
use it in the same way as the rest of the GUI. There are two ways to access it:

1. through the Onezone service interface (the default),
2. through the Emergency Interface (for emergencies only).

### Access via Onezone service interface

This is the default and recommended method. Log in to Onezone with your user
account as usual, open the **CLUSTERS** tab and select the Oneprovider cluster
you want to manage.

When you open a cluster in the **CLUSTERS** tab, the GUI connects behind the
scenes to the Onepanel service deployed in that cluster. You still work in the
unified Onezone interface, which only serves the UI files. Onepanel contacts
Onezone in the background to validate your credentials, so it does not need a
separate account for you. Your access is governed by your cluster membership and
privileges (see [Managing access to the administration panel][1]).

![screen-onepanel-hosted][]

This method may be unavailable if there are problems with the system, for
example when the Onezone service is down. In such cases, use the emergency
interface.

### Access via Emergency Interface

The emergency interface is intended only for emergencies in which logging in
through Onezone is not possible, for example when the Onezone service is
unavailable or you have lost access because of incorrect membership or privilege
settings. Do not use it for everyday administration.

The emergency interface is usually located at `https://my.provider.domain.org:9443`,
where `my.provider.domain.org` is the Oneprovider domain. You can also open it
using the IP address of one of the cluster nodes. This is useful if port 9443 is
not exposed publicly and you must connect from a VPN or an intranet.

Click **Sign in to emergency interface** and provide the [emergency passphrase][].

::: tip NOTE
In this mode, your session is not related to any Onezone user. You act as the `root`
account of Onepanel, which has all rights. Each Onepanel (Oneprovider and Onezone)
has its own `root` account.

Because you are not in the unified Onezone GUI, the interface is limited to the
administration panel of this cluster. You cannot navigate to other Onedata
resources, such as spaces or groups.
:::

![screen-onepanel-emergency-login][]

#### Emergency passphrase

The emergency passphrase is a secret that was set during the installation of the
Oneprovider cluster. It lets you enter the administration panel when you cannot
use your Onezone user account.

::: warning
Avoid using the emergency interface and keep the passphrase secret. Anyone who
knows it gets full control of the cluster, so leaking it can lead to
unauthorized access by third parties and data loss.
:::

::: tip NOTE
Do not confuse the `root` account with the `admin` user. A Onezone deployment
creates a special `admin` user whose password initially equals the Onezone
emergency passphrase, but it can be changed independently. This is an ordinary
Onezone user account with privileges assigned to it, unlike `root`, which is not a
Onezone user. See [Administrative privileges][] for details.
:::

#### Changing the emergency interface passphrase

You can change the emergency passphrase if you suspect that the current one is
no longer secure. This is possible only through the emergency interface of the
administration panel, in the **Clusters > *Cluster name* > Emergency passphrase**
view.

![screen-change-emergency-passphrase][]

## Managing access to the administration panel

Access to the administration panel works like access to any other resource in
Onedata and follows the [Membership model][]. Users who are members of a
Oneprovider cluster can access its administration panel, and what they can do
there depends on the privileges assigned to them in the cluster.

The list of members is available in the **Clusters > *Cluster name* > Members**
view. There you can add and remove members and change their privileges. Learn
more in the [cluster members][] chapter.

::: tip
Member settings do not apply to the emergency interface. Signing in with the
emergency passphrase always grants full management rights to the cluster.
:::

<!-- references -->

[toc]: <>

[Emergency Passphrase]: #emergency-passphrase

[Administrative privileges]: ../administrative-privileges.md#the-default-admin-user

[cluster members]: configuration/cluster-members.md

[graphical wizard]: ./installation/graphical-wizard.md

[managing certificates]: ./configuration/web-certificate.md

[storage backends]: ./configuration/storage-backends.md

[supporting spaces]: ./configuration/space-support.md

[Configuration]: ./configuration/cluster-members.md

[REST API]: ./configuration/rest-api.md

[User Web interface]: ../../user-guide/user-web-interface.md

[Membership model]: ../../user-guide/groups-memberships.md#membership-model-overview

[screen-onepanel-hosted]: ../../../images/admin-guide/oneprovider/administration-panel/onepanel-hosted.png

[screen-onepanel-emergency-login]: ../../../images/admin-guide/oneprovider/administration-panel/onepanel-emergency-login.png

[screen-change-emergency-passphrase]: ../../../images/admin-guide/oneprovider/administration-panel/change-emergency-passphrase.png

[1]: #managing-access-to-the-administration-panel
