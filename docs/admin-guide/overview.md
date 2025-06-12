# Overview

Onedata is based on two main services — Onezone and Oneprovider, which cooperate to provide
access to globally distributed storage resources. Onezone serves as a center of authority and
an entry point to the system, while Oneprovider manages the access to the mass storage systems
where the data managed by Onedata is actually stored. Deploying of Onedata from scratch implies deploying
of both services. More details about basic Onedata concepts can be found in the [Introduction][].

The Onedata services are administered separately. When deployng all from scratch Onezone should be deployed first as Oneprovider
relies on it. In most cases Onezone has been already set up and the administrator willing to expose his
storage resources with Onedata deploys only the Oneprovider service. Anyway, it should be decided
at this point what are you going to deploy and administer - Onezone and Oneprovider eventually, or just Oneprovider.

## Quickstart

The fastest way to setup a complete running Onedata environment is using the [demo mode][demo-mode].
However, it should be noted that the demo setup while fully functional was not intended to be
used in production.

In order to install Onezone follow the instruction in [onezone-installation][].
In order to install Oneprovider follow the instruction in [oneprovider-installation][]

## 🚧 Under construction! 🚧

The overview section is coming soon. For now, see the counterpart in the [legacy docs][1].

**Use the panel on the left to navigate to subsections.**

<!-- @TODO VFS-11766 
    include a simplified quistart here, shortly describing what
    is Onezone, Oneprovider and providing links to their quickstarts.
-->

<!-- @TODO VFS-11766 missing chapter -->

<!-- references -->

[1]: https://onedata.org/#/home/documentation/20.02/doc/admin_guide.html

[Introduction]: ../intro.md

[demo-mode]: demo-mode.md

[onezone-installation]: onezone/installation.md

[oneprovider-installation]: oneprovider/installation.md
