# Upgrades & compatibility

<!-- FIXME: usunąć didaskalia -->

<!-- Opisać ideę wersjonowania i założeń kompatybilności -->

<!-- FIXME: wstęp -->

## Versioning

Onedata main services ([Onezone][], [Oneprovider][]) and the client ([Oneclient][]) are versioned using the major and minor numbers. For example, in the `21.02.8` version, the `21.02` is the major and `8` is the minor component. The major component consists of two numbers with a dot separator for the historical reasons. The minor version is a number starting from `1` for the stable release, or can be a beta or release-candidate tag with leading `0` — e.g. `19.02.0-beta1` or `21.02.0-rc2`.

Versions of the services and the client determine if they can work together, so we can consider them as “compatible”. There are three fields of compatibility, defined between:

- **Onezone & Oneprovider** — when a Oneprovider in the certain version can be registered and work under a Onezone in the certain version;
- **Oneprovider & Oneprovider** — when two providers of certain versions can support the same space and communicate in order to synchronize changes;
- **Oneprovider & Oneclient** — when a Oneclient in the certain version can connect and operate with a Oneprovider in the certain version.

::: tip NOTE
Two providers with non-compatible versions can still support the same space, but they will not synchronize changes, which leads to data inconsistency. Although version incompatibility can be tolerated occasionally, it is **seriously discouraged** for long-term use.
:::

<!-- Dać link do tabelki kompatybilności -->

The general rules of compatibility are as follows:

- the Onezone supports a Oneprovider which has the same or older version, limited by the same and the previous major, e.g. Onezone 21.02.5 supports Oneprovider 21.02.4 or 20.02.20, but does not support Oneprovider 21.02.6 or 19.02.5;
- the Oneprovider is compatible with other Oneprovider if their major versions are the same, e.g. Oneprovider 21.02.6 will cooperate with Oneprovider 21.02.8, but 21.02.1 will not work properly with 20.02.5;
- the Oneclient will operate on a Oneprovider if their major versions are the same, e.g. Oneclient 21.02.1 will connect to Oneprovider 21.02.8, but the Oneclient 21.02.1 or 19.02.1 will not be able to operate on Oneprovider 20.02.1.

You can check the compatibility matrix between specific versions in the [Compatibility reference][] on our homepage.

The incompatibility in versions can be manifested in the various ways:
- when the Onezone is not compatible with the Oneprovider, then the provider would be seen as offline;
- when two Oneproviders supports the same space and are not compatible with each other, they would work independently, leading to the data inconsistency between providers;
- when the Oneclient is not compatible with the Oneprovider, it would refuse a connection to it.

::: tip NOTE
As the Onezone supports older versions of Oneprovider than itself, it can show features in the Web GUI that are not available yet in the used version of the Oneprovider. For example, Onezone 21.02.1 has a **Space > Automation Workflows** item in the sidebar, but if the space would be browsed by the supporting Oneprovider 20.02.20, you will be informed that you need an upgrade to access the feature. 
:::

## Upgrading

Onezone and Oneprovider support the upgrades with the following limitations:

- you can upgrade from one minor version to any other higher minor version in scope of a single major, e.g. version 20.02.1 to 20.02.6;
- you can upgrade from one major version only to the succeeding major (no matter of the minor version), e.g. from **20.02**.3 to **21.02**.8, but **not** from **18.02**.1 to **21.02**.1. 

<!-- Jak upgradować w świetle wersji, nawiązać tutaj z oraz do guide upgradowania w op i oz -->

For the upgrading guide, see the [Onezone upgrading][] and the [Oneprovider upgrading][] chapters.

<!-- FIXME: sprawdzać kompatybilność można robić także pobierając curl -k --silent https://krakow.demo.onedata.org/api/v3/oneprovider/configuration, gdzie mamy klucze "compatibleOnezoneVersions":["21.02.8"],"compatibleOneproviderVersions":["21.02.1","21.02.2","21.02.3","21.02.4","21.02.5","21.02.6","21.02.7","21.02.8"],"compatibleOneclientVersions":["21.02.1","21.02.2","21.02.3","21.02.4","21.02.5","21.02.6","21.02.7","21.02.8"] -->

<!-- Dać link do jsona z compat-ref -->

<!-- Dodatkowo uleszpenie Glossary; uzupełnienie brakujących, przegląd wszystkich zakładek i dopisanie brakujących pojęć, porobienie linków -->

<!-- references -->

[Onezone]: ../intro.md#zones

[Oneprovider]: ../intro.md#providers

[Oneclient]: ../intro.md#oneclient--native-posix-mount

[Compatibility reference]: https://onedata.org/#/home/versions

<!-- FIXME: do obecnego upgrading dodać link do wersji dokumentacji 20.02, dla onezone na pewno jest, dla oneprovider? -->

[Onezone upgrading]: ./onezone/maintenance.md#upgrading

[Oneprovider upgrading]: ./oneprovider/maintenance.md#upgrading