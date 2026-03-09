# Overview

<!-- @TODO VFS-11766 missing chapter -->

<!-- as needed: link to configuration, compatibility-reference [versions]). We need to decide/discuss. -->

<!-- @TODO VFS-13169 compatibility reference -->

This chapter describes the available [Oneprovider][providers] installation methods.
All of them use our [official Docker images][docker-images] to run Oneprovider on any
[Linux OS that supports Docker][supported-platforms].

<!-- @TODO VFS-11766 docs for multinode deployments 
Oneprovider service can be deployed on multiple hosts for
high-availability purpose. If not mentioned otherwise, we assume that
Oneprovider will be installed on a single host.
-->

Choose your preferred method:

* [Onedatify CLI wizard][] — use a one-liner that can be found in the Onedata UI to run
  a shell script, which will guide you through the installation process using
  command-line interface. This is **the recommended quickstart method**. Under the hood,
  it's a wrapper for the [Batch mode][] that fills in the deployment configuration
  according to your choices.

* [Graphical wizard][] — use Docker Compose to start up a non-deployed Oneprovider node.
  Then, enter the Onepanel Web interface that will guide you through the deployment with
  a user-friendly, graphical wizard. Offers better configurability than the Onedatify CLI
  wizard, but is harder for beginners.

* [Batch mode][] — use Docker Compose and specify the deployment configuration in the
  `docker-compose.yml` file. The deployment will be performed automatically upon service
  start. Useful for automated deployments and skilled administrators.

::: tip NOTE
Regardless of the chosen method, the host should be properly set up — see [prerequisites][].

After a successful installation, you can further configure your Oneprovider — see
[Configuration][].
:::

::: tip NOTE
We do not officially support the traditional package-based installation method, and we
do not recommend it. Our docker images hide away the complexity of dependencies and
ensure smooth maintenance and upgrades — all of which you'd have to do on your own when
installing from packages.

If you desperately need to install Oneprovider from packages, inspect the relevant
[Dockerfile][] and adapt the installation steps to your case.
:::

<!-- references -->

[providers]: ../../../intro.md#providers

[docker-images]: https://hub.docker.com/r/onedata/oneprovider/tags

[supported-platforms]: https://docs.docker.com/engine/installation/#supported-platforms

[prerequisites]: ../prerequisites.md

[configuration]: ../configuration/cluster-members.md

[Onedatify CLI wizard]: onedatify-cli.md

[Graphical wizard]: graphical-wizard.md

[Batch mode]: docker-compose.md

[Dockerfile]: https://github.com/onedata/oneprovider-pkg/blob/develop/docker/Dockerfile
