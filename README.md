# ![Onedata](doc/img/heading.png) Documentation
Onedata is a global data management system, providing easy access to distributed storage resources, supporting wide range of use cases from personal data management to data-intensive scientific computations.

With Onedata, users can access, store, process and publish data using global data storage backed by computing centers and storage providers worldwide.

Onedata focuses on instant, transparent access to distributed data sets, without unnecessary staging and migration, allowing access to the data directly from your local computer or worker node.

If this is your first encounter with Onedata, start with the overview of major concepts of the platform to get familiar with overall architecture and basic aspects of the system such as spaces, clients and providers.

- [Overview](doc/overview.md)

### Quickstart


#### For users
Learn how to access, manage and share your data. Create groups of users with fine grained access rights. Share and collaborate on the gathered data.

Read the [quickstart user guide](doc/as_a_user.md) or watch our screencasts:
- [Installation and Use of Onedata Client](doc/tutorial/screencast_oneclient_remote.md)
{% if book.draft %}
- [Use Onedata Client on the Shared Storage]()
{% endif %}

#### For administrators

Setup your own Onedata Provider, connect your storage resources. Allow your team to use you storage via Onedata. Share your storage resources with other scientists.

Read the [Oneprovider overview](doc/provider_overview.md) or watch our screencasts:

- [Single-node Installation of Onedata Provider on Google Cloud Compute Engine]()
{% if book.draft %}
- [Multi-node Installation of Onedata Provider on Google Cloud Compute Engine]()
{% endif %}

### Manuals and tutorials

Tutorials provide step-by-step instructions on how to perform typical data management tasks using Onedata. For a complete list of tutorials, see the [Tutorials page](doc/tutorials.md).

<!--Solutions section provides description of technology behind Onedata, with references to published scientific articles with more in depth description and evaluation. To learn more how Onedata works, check out the Solutions page.-->


Use the left-hand navigation or the list of links below to access the various sets of documentation that cover Onedata features in detail:

{% if book.draft %} - [HPC data transfer between providers](doc/solutions/rtransfer.md)
- [Accessing the data](){% endif %}
- [Sharing](doc/file_management.md) and [Collaboration](doc/space_collaboration.md)
- [Group management](doc/group_management.md) and [Access Control](doc/file_management.md) {% if book.draft %}
- [Uids and Gids Management]()
- [Authentication and authorization](doc/solutions/authentication.md){% endif %}
