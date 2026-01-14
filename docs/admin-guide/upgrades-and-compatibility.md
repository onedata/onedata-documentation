# Upgrades & compatibility

This chapter explains how Onedata versions are structured, including legacy versioning
scheme, and how version changes affect compatibility and upgrades between system core
components.

## Versioning

Starting from the version 25.0, the versioning scheme of Onedata main services
([Onezone][], [Oneprovider][]) and the client ([Oneclient][]) bases on the Calendar
Versioning concept.

A version is built like the following: `YY.Minor[.Patch][-Label]`.

* The **major** part of the version, expressed by `YY`, denotes the current year, although
  the release may be published before the corresponding calendar year starts, or after a
  new year has started. The change of year does not imply breaking of compatibility, but
  it's possible to break the compatibility only when the year is incremented.
* **Minor** versions are released when there has been at least one new feature that is
  backward compatible.
* **Patch** versions are released when there has been an important bug fix worth
  releasing, but no new features. If the Patch version is `0`, it's omitted from the
  notation, e.g., 25.0.
* The optional **label** part is used when version is not stable. It is joined to the last
  component of version string and consists of `-alpha`, `-beta`, or `-rc` tag, and the
  number after the dot. For example, it could be `-rc.1`.

The examples of versions can be:

* 25.0
* 25.0.1
* 26.1
* 26.1.1
* 27.0-alpha.1
* 27.0.1-beta.2

::: tip LEGACY VERSIONS

Versions lower than 25.0, e.g., 21.02.8, 21.02.7, 20.02.4, although having origins in the
calendar, were constructed the different way:

* `21.02`, `20.02`, etc. were a **major** part, which denoted a compatibility,
* the major part had origins in the date of the first release in the line, e.g., February
  2020 for `21.02.1`,
* the last part of the version string, e.g. `8` in a `21.02.8` version, was a **minor**
  part,
* we did not increment the year number in the versions released in years after 2021 to
  emphasize subsequent versions compatibility,
* `rc`, `beta`, and `alpha` labels did not contain a dot before their number, e.g,
* `21.02.rc-2`.
  :::

## Compatibility

Versions of the services and the client determine if they can work together, so we can
consider them as “compatible”. There are three fields of compatibility, defined between:

* **Onezone & Oneprovider** — when a Oneprovider in a certain version can be registered
  and work under a Onezone in a certain version;
* **Oneprovider & Oneprovider** — when two providers of certain versions can support the
  same space and communicate in order to synchronize changes;
* **Oneprovider & Oneclient** — when a Oneclient in a certain version can connect and
  operate with a Oneprovider in a certain version.

::: tip NOTE

Two providers with non-compatible versions can still support the same space,
but they will not synchronize changes, which leads to data inconsistency. Although version
incompatibility can be tolerated occasionally, it is **seriously discouraged** for
long-term use.

:::

You can check the compatibility matrix between specific versions in the [Compatibility
reference][] on our homepage. However, the general rules of compatibility are as follows:

* the Onezone can only support a Oneprovider which has the same or older version, limited
  by a major release which breaks the compatibility, e.g. Onezone 21.02.5 supports
  Oneprovider 21.02.4 or 20.02.20, but does not support Oneprovider 21.02.6 or 19.02.5;
* the Oneprovider is always compatible with other Oneprovider if their major versions are
  the same, e.g. Oneprovider 21.02.6 will cooperate with Oneprovider 21.02.8; however,
  some major updates do not break compatibility, e.g. Oneprovider 25.0 can cooperate with
  any Oneprovider from the 21.02.x line;
* the Oneclient will always operate on a Oneprovider if their major versions are the same,
  e.g., Oneclient 21.02.1 will connect to Oneprovider 21.02.8.

::: tip NOTE

Starting from version 25.0, some major updates did not break the major compatibility.
E.g., major version 25 did not break the compatibility with the 20.02 line, so Oneprovider
25.0 can cooperate with any Oneprovider from the 21.02.x line. Refer to the [Compatibility
reference][] for details.

:::

You can also get the current compatibility information in JSON format from
[https://onedata.org/compatibility.json][]. The file contains the following mappings under
the `compatibility` key:

* `onezone:oneprovider` — maps version of Onezone to compatible versions of Oneprovider,
* `oneprovider:oneprovider` — maps version of Oneprovider to compatible versions of
  Oneprovider,
* `oneprovider:oneclient` — maps version of Oneprovider to compatible versions of
  Oneclient.

::: tip

Beside of looking up the compatibility table, you can check the compatibility of
the running service instance using the REST API. For example, making a `GET` request on
the `/api/v3/oneprovider/configuration` endpoint of Oneprovider will result in a JSON
response containing a `compatibleOnezoneVersions`, `compatibleOneproviderVersions`, and
`compatibleOneclientVersions` arrays with the compatible versions of other products.

You can try out the following public endpoints of demo.onedata.org services for reference:

* [https://demo.onedata.org/api/v3/onezone/configuration][]
* [https://krakow.demo.onedata.org/api/v3/oneprovider/configuration][]

Just replace the domain name, and try it on your deployment.

:::

The incompatibility in versions can be manifested in the various ways:

* when the Onezone is not compatible with the Oneprovider, then the provider would be seen
  as offline;
* when two Oneproviders supports the same space and are not compatible with each other,
  they would work independently, leading to the data inconsistency between providers;
* when the Oneclient is not compatible with the Oneprovider, it would refuse a connection
  to it.

::: tip NOTE

Because the Onezone can support older versions of Oneprovider than itself, it
can show features in the Web GUI that are not available yet in the used version of the
Oneprovider. For example, Onezone 21.02.1 has a **Space > Automation Workflows** item in
the sidebar, but if the space would be browsed by the supporting Oneprovider 20.02.20, you
will be informed that you need an upgrade to access that feature.

:::

## Upgrading

Onezone and Oneprovider support upgrades with the following limitations:

<!--
  Using <strong> instead of native Markdown **bold** in version strings, because LTeX
  complains about SENTENCE_WHITESPACE mistake when there is a Markdown-bolded number
  after dot.
-->

* you can upgrade from one minor version to any other higher minor version in scope of a
  single major, e.g.:

  * ✅ 20.02.<strong>1</strong> → 20.02.<strong>6</strong> *(legacy versioning scheme)*,
  * ✅ 25.<strong>0</strong> → 25.<strong>1</strong> *(calendar versioning)*,
  * ✅ 25.<strong>1</strong>.1 → 25.<strong>2</strong>.3 *(calendar versioning with patch)*,

* you can upgrade from one major version only to the succeeding major (no matter of the
  minor version), e.g.:

  * ✅ **20.02**.3 → **21.02**.8 *(legacy to legacy)*,
  * ✅ **21.02**.1 → **25**.1 *(legacy to calendar versioning)*,
  * ✅ **25**.0 → **26**.1.2 *(calendar versioning)*,

  but **not**:

  * ❌ **18.02**.1 → **20.02**.1 *(two legacy majors higher)*,
  * ❌ **19.02**.1 → **25.0** *(three mixed versioning majors higher)*,
  * ❌ **25**.1.2 → **27**.2 *(two calendar versioning majors higher)*.

::: tip NOTE

Starting from version 25.0, some major updates allow upgrading higher than a single
major. The example of such exception is:

* ✅ 20.02.x → 25.x

:::

For the upgrading guide, see the [Onezone upgrading][] and the [Oneprovider upgrading][] chapters.

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
