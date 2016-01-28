# Overview of Onedata Paltform

{% if book.draft %}
> It is true
{% endif %}

Before you start using Onedata, it's helpful to understand the overall landscape. Knowing what's available and how the parts work together can help you make decisions about how to proceed. This overview is designed to help you down that path. Here, we'll take a brief look at some of the commonly used features and provide pointers to documentation that can help you go deeper. We'll also point out some tutorials that you can use to try out Onedata in various scenarios.

## Onedata Concpets

Onedata is composed of a global network of *Providers* that unify access to geographical distributed storage resources and provide access to physical storage devices. Those resources in turn can be accessed transparently with Onedata.

![Text if not rendered...](img/overview_3d_map_with_users.png "Onedata something")

Providers are deployed near physical storage resources i.e. a computing centers. They exposes a dedicated storage in a computing center to Onedata. Providers chooses which Onedata users can use it's storage resources e.g. they can dedicate it storage resources to a group of Onedata users working in particular computing center.

[Onedata.org](onedata.org) provides access to Onedata system for users. It coordinates interactions between Providers, governes information about distribution of user files across Providers, stores metadata of every files governed by Onedata and provides a single point of authentication in the system.

For more information about Onedata's  *Provider*, see [Oneprovider Overview](provider_overview.md) documentation pages.

## Data Access

Onedata uses quite unique concepts, compared to what you might be familiar, and they are the key to understanding how Onedata works.

All the files you upload to onedata must belong to a *space*. You can think of a *space* as a virtual directory with some quota restrictions. Upon registering on [onedata.org](onedata.org) a default *space* is created for you. Onedata is a data access solution, not a storage provider, and it does not give you any free or paid storage resources. That is why, the newly created *space* has a quota size set to zero. In order to be able to use a *space*, you have to request some storage from a Provider. You can do that by sending to the provider a unique access token. Provider uses this token to support your *space* with a dedicated amount of storage. How much storage is actually provided it depends on your agreement with the Provider. You can request more storage for your *space* from multiple geographical distributed Providers. Onedata will distribute your data across them accordingly.

![Spaces model](img/spaces_model1.png "Spaces model")

You can can create multiple *spaces*, share them with your colleagues and even expose them to the public. If you want to create a *space* for a community of users, Onedata support *group* to make collaboration and access control to shared spaces easier.

For more information about *Groups* and *Access Control*, see [Group Management](group_management.md) and  [Access Control](access_control.md) documentation pages.



For more information about *spaces* and *group spaces* see [Space Managment]() and [Group Managment]().

## Ways to interact with the services

Onedata gives you three basic ways to interact with Onedata and to access your data.

### Provider's Web Interface

![Provider GUI screen](img/provider_gui_screen.png "Provider GUI screen")

The Onedata Provider's Web Interface provides a web-based, graphical user interface that you can use to govern your spaces, control access rights and manage your user account.


### Command-line interface

If you prefer to work in a terminal window, Onedata provides the *oneclient* command-line tool, which allows you to mount your spaces in a linux filesystem and access your data directly from console. See the [oneclient](oneclient.md) reference for the complete list of available features.

### The API-s

As of now Onedata exposes who kinda of APSi.

- [REST API](rest.md)
- [CDMI API](cdmi.md)

Both allow user to access and manage their data.
