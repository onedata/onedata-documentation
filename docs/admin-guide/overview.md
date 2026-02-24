# Overview

Onedata is based on two main services — **Onezone** and **Oneprovider**, which cooperate to provide
access to globally distributed storage resources. Onezone serves as a center of authority and
an entry point to the system, while Oneprovider manages the access to the mass storage systems
where the data managed by Onedata is actually stored. More details about basic Onedata concepts 
can be found in the [Introduction][].

### Join an existing Onedata ecosystem as a provider

The simpler and most common case is [deploying a new Oneprovider][Oneprovider installation] 
service and registering to a [pre-existing Onezone][], and hence joining a broader Onedata 
ecosystem. Make sure that **you trust** the owners of the selected Onezone service, as it
handles authentication and authorization. Typically, this works for federated environments 
such as [EGI DataHub][], where EGI oversees the ecosystem, and its partners provide storage 
resources and operate the Oneprovider services.

### Deploy your own Onedata ecosystem

You may want to create a new Onedata ecosystem from scratch. This scenario is more complex, 
but you will have full control over all services, sensitive information, and data:

1. [Deploy the Onezone service][Onezone installation] first, as Oneproviders rely on it.
2. [Deploy a Oneprovider][Oneprovider installation] — one or more instances — and register
   them to your Onezone.

### Demo mode — dockerized sandbox / test deployment

The fastest way to set up a complete, **sandbox Onedata ecosystem** is to use the 
[demo mode][]. You will get minimal-setup **Onezone** and **Oneprovider(s)**, which will
let you see most functionalities in action and test the system. While fully functional,
this setup is not intended to be used in production.

<!-- references -->

[Introduction]: ../intro.md

[pre-existing Onezone]: ../user-guide/quickstart.md#introduction--onezone-service

[demo mode]: demo-mode.md

[Onezone installation]: onezone/installation.md

[Oneprovider installation]: oneprovider/installation/overview.md

[EGI DataHub]: https://datahub.egi.eu