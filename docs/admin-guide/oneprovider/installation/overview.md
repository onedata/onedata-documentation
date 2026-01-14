# Overview

<!-- @TODO VFS-11766 missing chapter -->

This chapter describes the available [Oneprovider][providers] installation methods.
All supported installation methods use our [official Docker images][docker-images]
to run Oneprovider on any [Linux OS supporting Docker][supported-platforms].

Oneprovider service can be deployed on multiple hosts for
high-availability purpose. If not mentioned otherwise, we assume that
Oneprovider will be installed on a single host.

There are few installation methods shortly described further to help you choose which one is best for you:

* [Onedatify CLI wizard][] — this method uses our convenient script integrated with Onedata UI which
  guides you through the installation process.
  This is the recommended quickstart method.
* [Graphical wizard][] — the installation is done by first running an empty instance of Oneprovider
  which later is being configured by clicking through some forms. It offers better configurability than the Onedata CLI
  wizard, but still user-friendly.
* [Batch mode][] — useful for more skilled administrators wanting a specifically configured deployment.
  The deployment happens in batch mode, which does not require manual steps. It is useful for automated deployments.
  The installation is done by preparing a YAML configuration file for Oneprovider and then running the service.

::: tip PREREQUISITES
Regardless of the chosen method, the host should be initially prepared — see [prerequisites][].
:::

::: tip CHOOSING THE VERSION
The newly deployed Oneprovider must be compatible with its [Onezone][zones], and with
cooperating Oneproviders (if applicable). Thus, we recommend reading the [Upgrades &
compatibility][] chapter first, to choose the proper version or upgrade other services.
:::

::: tip NOTE
We do not officially support the traditional package installation method. If you desperately need to install it
from packages, inspect the relevant Dockerfile and adapt the installation steps to your case.
:::

<!-- references -->

[providers]: ../../../intro.md#providers

[zones]: ../../../intro.md#zones

[docker-images]: https://hub.docker.com/r/onedata/oneprovider/tags

[supported-platforms]: https://docs.docker.com/engine/installation/#supported-platforms

[prerequisites]: ../prerequisites.md

[Onedatify CLI wizard]: onedatify-cli.md

[Graphical wizard]: graphical-wizard.md

[Batch mode]: docker-compose.md

[Upgrades & compatibility]: ../../upgrades-and-compatibility.md
