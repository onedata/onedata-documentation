# Upgrades & compatibility

This chapter explains how Onedata versions are structured, including the legacy versioning
scheme, and how version changes affect compatibility and upgrades between the system's
core components.

## Versioning

Starting with version 25.0, the versioning scheme of Onedata's main services ([Onezone][],
[Oneprovider][]) and the client ([Oneclient][]) is based on the Calendar Versioning
concept.

A version has the following format: `YY.Minor[.Patch][-Label]`.

* The **major** part of the version, expressed as `YY`, denotes the current year, although
  the release may be published before the corresponding calendar year starts or after a
  new year has started. A change of year does not imply a compatibility break, but
  compatibility may only be broken when the year is incremented.

* **Minor** versions are released when there has been at least one new backward-compatible
  feature.

* **Patch** versions are released when there has been an important bug fix worth
  releasing, but no new features. If the Patch version is `0`, it is omitted from the
  notation, e.g., `25.0`.

* The optional **label** part is used when a version is not stable. It is appended to the
  last component of the version string and consists of an `-alpha`, `-beta`, or `-rc` tag
  followed by a number separated by a dot. For example, it could be `-rc.1`.

Examples of versions include:

* 25.0
* 25.0.1
* 26.1
* 26.1.1
* 27.0-alpha.1
* 27.0.1-beta.2

::: tip LEGACY VERSIONS

Versions lower than 25.0, e.g., 21.02.8, 21.02.7, and 20.02.4, although based on calendar
dates, were structured differently:

* `21.02`, `20.02`, etc. were the **major** part, which denoted a compatibility level;
* the major part was based on the date of the first release in the line, e.g., February
  2020 for `21.02.1`;
* the last part of the version string, e.g., `8` in version `21.02.8`, was the **minor**
  part;
* we did not increment the year number in versions released in years after 2021 to
  emphasize compatibility with subsequent versions;
* `rc`, `beta`, and `alpha` labels did not contain a dot before their number, e.g.,
  `21.02.rc-2`.

:::

## Compatibility

The versions of the services and the client determine whether they can work together, so
we can consider them to be “compatible”. There are three types of compatibility, defined
between:

* **Onezone & Oneprovider** — when a Oneprovider in a certain version can be registered
  with and work under a Onezone in a certain version;

* **Oneprovider & Oneprovider** — when two Oneproviders in certain versions can support
  the same space and communicate with each other to synchronize changes;

* **Oneprovider & Oneclient** — when a Oneclient in a certain version can connect to and
  operate with a Oneprovider in a certain version.

::: tip NOTE

Two providers with incompatible versions can still support the same space, but they will
not synchronize changes, which leads to data inconsistency. Although version
incompatibility can occasionally be tolerated, it is **seriously discouraged** for
long-term use.

:::

You can check the compatibility matrix between specific versions in the [Compatibility reference][]
on our homepage. However, the general rules of compatibility are as follows:

* Onezone can only support a Oneprovider that has the same or an older version, limited by
  a major release which breaks the compatibility. For example, Onezone 21.02.5 supports
  Oneprovider 21.02.4 or 20.02.20, but does not support Oneprovider 21.02.6 or 19.02.5;
* two Oneproviders are always compatible if they have the same major version, e.g.,
  Oneprovider 21.02.6 will cooperate with Oneprovider 21.02.8; however, some major version
  changes do not break compatibility, e.g., Oneprovider 25.0 can cooperate with any
  Oneprovider from the 21.02.x line;
* a Oneclient will always operate with a Oneprovider if their major versions are the same,
  e.g., Oneclient 21.02.1 will connect to Oneprovider 21.02.8.

::: tip NOTE

Starting with version 25.0, some major version changes did not break compatibility. For
example, major version 25 did not break compatibility with the 21.02 line, so Oneprovider
25.0 can cooperate with any Oneprovider from the 21.02.x line. Refer to the [Compatibility
reference][] for details.

:::

You can also get the current compatibility information in JSON format from
[https://onedata.org/compatibility.json][]. The file contains the following mappings under
the `compatibility` key:

* `onezone:oneprovider` — maps Onezone versions to compatible Oneprovider versions;
* `oneprovider:oneprovider` — maps Oneprovider versions to compatible Oneprovider versions;
* `oneprovider:oneclient` — maps Oneprovider versions to compatible Oneclient versions.

::: tip

Besides looking up the compatibility table, you can check the compatibility of a running
service instance using the REST API. For example, making a `GET` request to the
`/api/v3/oneprovider/configuration` endpoint of Oneprovider will return a JSON response
containing `compatibleOnezoneVersions`, `compatibleOneproviderVersions`, and
`compatibleOneclientVersions` arrays with the compatible versions of other products.

You can try the following public endpoints of demo.onedata.org services for reference:

* [https://demo.onedata.org/api/v3/onezone/configuration][]
* [https://krakow.demo.onedata.org/api/v3/oneprovider/configuration][]

Just replace the domain name and try it with your deployment.

:::

Version incompatibility can manifest itself in several ways:

* when Onezone is not compatible with Oneprovider, the provider will be shown as offline;
* when two Oneproviders support the same space but are not compatible with each other,
  they will work independently, leading to data inconsistency between the providers;
* when Oneclient is not compatible with Oneprovider, it will refuse the connection.

::: tip NOTE

Because Onezone can support older versions of Oneprovider than itself, it can show
features in the Web GUI that are not yet available in the version of Oneprovider being
used. For example, Onezone 21.02.1 has a **Space > Automation Workflows** item in the
sidebar, but if the space is browsed using Oneprovider 20.02.20, you will be informed that
you need to upgrade to access that feature.

:::

## Upgrading

Onezone and Oneprovider support upgrades with the following limitations:

<!--
  Using <strong> instead of native Markdown **bold** in version strings, because LTeX
  complains about SENTENCE_WHITESPACE mistake when there is a Markdown-bolded number
  after dot.
-->

* you can upgrade from one minor version to any higher minor version within a single major
  version, e.g.:

  * ✅ 20.02.<strong>1</strong> → 20.02.<strong>6</strong> *(legacy versioning scheme)*,
  * ✅ 25.<strong>0</strong> → 25.<strong>1</strong> *(Calendar Versioning)*,
  * ✅ 25.<strong>1</strong>.1 → 25.<strong>2</strong>.3 *(Calendar Versioning with patch)*,

* you can upgrade from one major version only to the succeeding major version, regardless
  of the minor version, e.g.:

  * ✅ **20.02**.3 → **21.02**.8 *(legacy to legacy)*,

  * ✅ **21.02**.1 → **25**.1 *(legacy to Calendar Versioning)*,

  * ✅ **25**.0 → **26**.1.2 *(Calendar Versioning)*,

  but **not**:

  * ❌ **18.02**.1 → **20.02**.1 *(two legacy majors higher)*,
  * ❌ **19.02**.1 → **25.0** *(three mixed-versioning majors higher)*,
  * ❌ **25**.1.2 → **27**.2 *(two Calendar Versioning majors higher)*.

::: tip NOTE

The 25.x version line is a notable exception to the general rule of breaking
compatibility. It is treated as a compatible continuation of the 21.x line, so you can
upgrade **20.02.x → 25.x** and **21.02.x → 26.x**.

:::

For the upgrading guide, see the [Onezone upgrading][] and [Oneprovider upgrading][]
chapters.

<!-- references -->

[Onezone]: ../intro.md#zones

[Oneprovider]: ../intro.md#providers

[Oneclient]: ../intro.md#oneclient--native-posix-mount

[Compatibility reference]: https://onedata.org/#/home/versions

[Onezone upgrading]: ./onezone/maintenance.md#upgrading

[Oneprovider upgrading]: ./oneprovider/maintenance.md#upgrading

[https://onedata.org/compatibility.json]: https://onedata.org/compatibility.json

[https://demo.onedata.org/api/v3/onezone/configuration]: https://demo.onedata.org/api/v3/onezone/configuration

[https://krakow.demo.onedata.org/api/v3/oneprovider/configuration]: https://krakow.demo.onedata.org/api/v3/oneprovider/configuration
