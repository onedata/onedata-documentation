# Onezone Overview

Onezone is a cluster solution that divides Onedata distributed system into zones. There can be only one Onezone service in a zone. Providers register with/join Onezone service in order to communicate with each other and expose their resources to users.

*Onezone* is a gateway for users to Onedata system. It is responsible for authentication and authorization of users using *open id* services such as: Github, Facebook, Goodgle and Drobpox.

It allows users to:
- generate space support tokens, that can be used to support your space with sotrage from a dedicated Provider.
- monitor availability of Providers that support your spaces
- see the geographical distribution of Providers on a map
- choose which Provider you want to choose to access your files

Onezone  is a cluster solution that is composed of 3 types of services:
* Cluster Manager - an administrative service that monitors the health of the cluster, performs load balancing and manages other cluster nodes
* Worker - a service for data management
* Database - a service providing persistent storage for metadata and tranfer control

Each service can be deployed multiple times depending on the performance and reliability requirements. The cluster can be administered from any node, thanks to *onepanel* web application that runs on every node.

