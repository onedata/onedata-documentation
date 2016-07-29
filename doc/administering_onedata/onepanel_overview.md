# Onepanel Overview

Onepanel is a Onedata component responsible for management of other Onedata components, namely Oneprovider and Onezone.

Onedata services are distributed applications which can be scaled from a single node to a large data center, and as such are composed of 3 types of components:
* **Cluster managers** - responsible for communication and monitoring between worker instances of a particular Onedata service,
* **Workers** - actual worker processes handling user requests,
* **Database instances** - [Couchbase](http://www.couchbase.com/) backend instances storing control and metadata information, .

Onepanel eases the deployment of these components among the nodes assigned to Onedata in a site. Currently this is possible using a GUI web interface as well as [REST API](../advanced/rest/onepanel/overview.md).

Detailed instructions on how to setup each of these services using Onepanel graphical interface are available here:
* [Onezone](onezone_installation.md)
* [Onepanel](oneprovider_installation.md)

Furthermore, Onepanel enables easy creation of user accounts allowing access to Onedata service using HTTP basic authentication.
