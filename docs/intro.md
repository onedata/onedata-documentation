---
title: 'Introduction'
---

# <img src="../images/intro/logo-dark.svg" class="intro-header" width="210">

<div style="text-align: left; font-weight: normal; font-style: italic; margin-bottom: 1cm;">Version: xRELEASExVERSIONx</div>

<!-- TODO VFS-6805:
INTRODUCTION  (landing page)
    - a couple of words about Onedata
    - are you a user? — go here: [USER GUIDE]
    - are you an admin? — go here: [ADMIN GUIDE]
      <these three should fit onto one screen>
    - broader description of Onedata
        - architecture
     - rework user interfaces, move them somewhere else (data management interfaces are already on the data page, but
       what about general overview on the GUI, login methods, basic navigation, oneproviders and onepanels?)
    -->

Onedata is a global data management system that provides easy access to distributed
storage resources, supporting a wide range of use cases from personal data management to
data-intensive scientific computations.

In Onedata, users can store, access, process, and publish their data using a global
virtual file system spanning computing centers and storage providers worldwide.

Onedata focuses on performant, transparent access to distributed data sets, without
burdensome manual staging and migration, allowing access to the data directly from your
personal computer or a worker node within a data center.

## Quickstart

Read on to get familiar with the basic Onedata concepts, or take a look at the
[glossary][] for condensed information and cross-references.

To start with Onedata as **an end-user**, go to the [user quickstart][].

If you are familiar with `docker`, you may set up a [demo (sandbox) environment][] to see
Onedata in action, even with a multi-provider environment. It takes less than 5 minutes to
get it running!

If you are about to deploy Onedata services on your infrastructure, go the [admin guide][]
or the relevant quickstart for [Onezone][] or [Oneprovider][] service.

## Basic concepts

The most important concepts in Onedata are:

<!-- TODO VFS-11766 links to different sections, consider being more concise or moving some information -->

* **Spaces** — distributed virtual volumes, where users can organize their data,
* **Providers** — entities who support user spaces with actual storage resources exposed via *Oneprovider* services,
* **Zones** — federations of providers that enable the creation of closed or
  interconnected communities, managed by *Onezone* services.

### Spaces

All data stored in Onedata is organized into *Spaces*. Spaces can be seen as virtual
directories or volumes, which can contain an arbitrary directory and file hierarchy while
being distributed across multiple storage providers. Each space has to be supported by at
least one provider, which means that this provider reserved a certain storage quota for
this particular space. In case a space is supported by more providers, the total quota is
the sum of storage space provisioned by all providers supporting it.

After registering in a specific zone using the Onezone web interface, a new space has to
be created. Onedata is not a storage provider, and it does not provide any free or paid
storage resources. That is why, the newly created *space* has a quota size set to 0. To be
able to use this *space*, you have to request storage from some provider.

You can do that by sending the provider a support request token, which can be generated
using the Onezone interface. Provider uses this token to easily enable support for your
*space* with a specified quota. The actual storage size and provisioning time depend on
your agreement with the storage provider. You can request more storage for your *space*
from multiple geographically distributed providers. Onedata will unify access to these
storage resources automatically.

<img src="../images/intro/spaces_model1.svg" width="580">

Each user can have any number of *spaces*. *Spaces* can be easily shared with other users
and even exposed to the public. If you want to create a *space* for a community of users,
Onedata supports user *groups*, which enable multiple users to access a single *space*
sharing common authorization rules.

Data in spaces can be managed through a web interface as well as from command line. Each
space can be easily mounted to a local filesystem and accessed directly from a laptop, a
cluster node, or a virtual machine deployed in the cloud.

For more information about *Spaces* and *Groups* see [Space Management][] and [Group Management][].

### Providers

Each zone is composed of a network of providers who provision their storage resources to
users. Anyone can become a Onedata provider by installing the *Oneprovider* service,
attaching storage resources, and registering it in a particular Onezone service.

A user can use several providers simultaneously to manage his/her data. Onedata exposes
the combined storage space of all providers to the user and ensures that access to the
user's data is performant and transparent.

<img src="../images/intro/overview-3d-map-with-users.png" width="580">

Providers deploy *Oneprovider* services near physical storage resources, i.e. in computing and data centers or even personal computers. Providers have full control over which users can use their storage resources and in what amount.

Users use *Onezone* web interfaces (like the one at [onedata.org][]) to authenticate with
Onedata and access the data located on the providers' storage resources.

For more information about Onedata's provider service, check out [Oneprovider Overview][] documentation.

### Zones

Onedata is a distributed system divided into zones that are created by deploying a
dedicated service called *Onezone*. Any organization, community, or user group can deploy
its own *Onezone* service with a customized login page and either connect it to the
distributed network of *Onezone* services or run it as an isolated private deployment.

*Onezone* is responsible for the authentication and authorization of users and makes it
possible for users from different zones to communicate with each other and share data. It
allows providers from different zones to interact with each other, i.e., allowing users
from different zones to get support for their spaces regardless of the zone in which the
particular provider is located.

<img src="../images/intro/onezone101.svg" width="580">

As *onedata.org* is a main public zone, any provider registered there allows the users to
access their data through *onedata.org* user interface.

For more information about Onedata's *Onezone* service, check out [Onezone Overview][] documentation.

## User interfaces

Onedata provides 4 ways to manage and access your data:

### User Web interface

The Onedata Web Interface provides a web-based, graphical user interface that you can use to manage your spaces, control access rights and manage your user account.

![screen-web-gui-example][]

### User command-line interface

If you prefer to work from the terminal, "Onedata" provides the *oneclient* command-line
tool, which allows you to mount your spaces in a Linux filesystem and access your data
directly from the console. See the [Oneclient][] reference for the complete list of
available features.

### Administrator Web interface

Dedicated web interface for installation and management of *Oneprovider* and *Onezone* services.

### API

Currently, Onedata exposes a CDMI (Cloud Data Management Interface) [interface][CDMI interface] and RESTful [interface][REST interface] for integration with other services, which allows developers to directly access and manage spaces, groups, authorization rights and data.

## Architecture

### 🚧 Under construction! 🚧

<!-- TODO VFS-6805: description of architecture: Onezones, Oneproviders, Onepanels, glossary -->

<!-- TODO VFS-6805: describe the concept of Oneprovider being a service deployed in a data provider institution 
                    and offering storage space for users -->

<!-- references -->

[glossary]: glossary.md

[user quickstart]: user-guide/quickstart.md

[demo (sandbox) environment]: admin-guide/demo-mode.md

[Onezone]: admin-guide/onezone/quickstart.md

[Oneprovider]: admin-guide/oneprovider/quickstart.md

[admin guide]: admin-guide/overview.md

[Space Management]: user-guide/spaces.md

[Group Management]: user-guide/groups.md

[onedata.org]: https://onedata.org

[Oneprovider Overview]: admin-guide/oneprovider/overview.md

[Onezone Overview]: admin-guide/onezone/overview.md

[oneclient]: user-guide/oneclient.md

[CDMI interface]: user-guide/cdmi.md

[REST interface]: https://onedata.org/#/home/api

[screen-web-gui-example]: ../images/intro/web-gui-example.png
