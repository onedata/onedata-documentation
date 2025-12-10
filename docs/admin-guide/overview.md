# Overview

Onedata is based on two main services — Onezone and Oneprovider, which cooperate to provide
access to globally distributed storage resources. Onezone serves as a center of authority and
an entry point to the system, while Oneprovider manages the access to the mass storage systems
where the data managed by Onedata is actually stored. Deploying of Onedata from scratch implies deploying
of both services. More details about basic Onedata concepts can be found in the [Introduction][].

The Onedata services are administered separately. When deploying all from scratch, Onezone should be deployed first as 
Oneprovider relies on it. In most cases Onezone has been already set up and the administrator willing to expose his
storage resources with Onedata deploys only the Oneprovider service. Anyway, it should be decided
at this point what are you going to deploy and administer — Onezone and Oneprovider eventually, or just Oneprovider.

## Quickstart

The fastest way to set up a complete running Onedata environment is using the [demo mode][].
However, it should be noted that the demo setup, while fully functional, was not intended to be
used in production.

In order to install Onezone, follow the instructions in the [Onezone installation][] chapter.

In order to install Oneprovider, follow the instructions in the [Oneprovider installation][] chapter.


<!-- references -->

[Introduction]: ../intro.md

[demo mode]: demo-mode.md

[Onezone installation]: onezone/installation.md

[Oneprovider installation]: oneprovider/installation.md
