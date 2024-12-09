# Public Data

[toc][1]

<!-- FIXME: zostawiłem Open Data (bo jest link i "commnity use cases") -->

To support [Open Data][] access community use
cases, Onedata provides means for exposing [Shares][] as Public Data
collections. Such collections can have assigned Open Access identifiers such as
[DOI][] or [PID][].

<!-- TODO: VFS-12541 Add EDM documentation -->

The Share is assigned [Dublin Core][] metadata
(which is a standard for describing such collections), registered in an external handle
service, and advertised by [OAI-PMH][] protocol — so that
Public Data indexing services can add the dataset to their searchable databases.

<!-- FIXME: czy może być nadal open-access? -->

Open-access identifiers can be generated and assigned to Shares by users who have access
to a [Handle][handle-www] system-based service within the current Onezone.

::: tip NOTE
Handle services can be registered in Onezone by users who have access rights to specific
Handle registers. For more information about registering and managing handle-based
services in Onedata, see the [Handle services][]
chapter of the Admin guide.
:::

## Exposing via Web GUI

First, you need to create a Share of a file or directory and visit its Share management
view — see the [Shares][] chapter for the guide.

<!-- TODO: VFS-12541 Write about publishing using share modal -->

In the [Share management view][], open an
**Expose as Public Data** tab, where you can see a selector allowing you to choose a Handle
service available in the current Onezone, to expose your dataset in.

![Expose as Public Data tab][screen-tab-expose]

After choosing the Handle service, click on **Proceed** button below the dropdown to start
filling in a Dublin Core Metadata for your Public Data collection. You can switch between
the default **Visual** editor or the **XML** editor, which supports
[DCMES Version 1.1][dublin-core-DCES-www] specification.
In both editors, you can describe your collection using properties from a set of 15
predefined types, such as Creator, Title, or Description.

![Dublin Core metadata visual editor][screen-expose-dublin-core-visual]

![Dublin Core metadata XML editor][screen-expose-dublin-core-xml]

After you complete filling in the metadata, click on the **Expose as Public Data** button
at the end of the form to perform collection publication. When the process of exposing
completes, the current tab of a Share management view will change its name to **Public Data**
and you could see a preview of your metadata as it can be viewed by anonymous users.

![Preview of Dublin Core metadata after collection exposing][screen-expose-public-data-preview]

::: tip NOTE
Please keep in mind that once exposed, your dataset should not be removed.
:::

Now you can find a link to the public Handle in the box where a Share link was
presented before, choosing **Public handle link** options from the dropdown.

![Public handle link][screen-expose-public-handle-link]

::: tip NOTE
Although the **Public handle link** is displayed by default in the link box, you
can still use the **Share link** by choosing it in the dropdown.
:::

Visit the public Handle URL to open your Public Data collection, available publicly on the
Internet.

![Public Data view: Public Data tab][screen-tab-public-data]

![Public Data view: files tab][screen-tab-files]

::: tip NOTE
You can still add the description of the Share besides the Public Data Dublin
Core metadata as described in the [Share Description][]
section of the documentation.
:::

## Exposing via REST API

::: tip
For full API reference, see the [Handle][Handle API] and the
[Handle Service][Handle Service API] chapters of the Onedata REST API documentation.
:::

First, obtain Handle service and target Share IDs. You can get available Handle services
registered in the current Onezone using the following command line:

```shell
curl -u username:password https://$ONEZONE_HOST/api/v3/onezone/user/effective_handle_services
```

which can result in:

```json
{"handle_services":["054900fc799a7f14451e99fac94f351ach7099"]}
```

The Share ID can, for example, be obtained from Web GUI's Share link, which is in the following format:

```
https://dev-onezone.default.svc.cluster.local/share/$SHARE_ID
```

For our example:

```
https://dev-onezone.default.svc.cluster.local/share/0c2f0b363b8e681746d315025e971b5cch0846
```

the ID is `0c2f0b363b8e681746d315025e971b5cch0846`.

Handles for Shares can be also generated using the REST API using the following command
line:

```shell
curl -u admin:password -X POST -H "Content-type: application/json" \
-d '{"handleServiceId": "'"$HANDLE_SERVICE_ID"'", "resourceType": "Share", "resourceId": "'"$SHARE_ID"'", "metadata": "'"$METADATA"'" }' \
https://${ONEZONE_HOST}/api/v3/onezone/handles
```

with previously obtained `$HANDLE_SERVICE_ID` and `$SHARE_ID`. `$METADATA` must be
[Dublin Core][dublin-core-DCES-www] compatible
metadata in escaped XML, for example:

```shell
METADATA='<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n<metadata xmlns:xsi=\"http:\/\/www.w3.org\/2001\/XMLSchema-instance\" xmlns:dc=\"http:\/\/purl.org\/dc\/elements\/1.1\/\"><dc:title>Public two<\/dc:title><dc:creator>Unnamed User<\/dc:creator> <dc:description>My description<\/dc:description><dc:date>2023-06-14<\/dc:date><\/metadata>'
```

which is the one-liner version of the following metadata:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<metadata
   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
   xmlns:dc="http://purl.org/dc/elements/1.1/"
>
   <dc:title>Public two</dc:title>
   <dc:creator>Unnamed User</dc:creator>
   <dc:description>My description</dc:description>
   <dc:date>2023-06-14</dc:date>
</metadata>
```

After successful publication, you can get created Handle ID (`handleId` property) using
the following command line:

```shell
curl -u user:password https://${ONEZONE_HOST}/api/v3/onezone/shares/${SHARE_ID}
```

which could result in:

```json
{
   "spaceId":"d908ebabf0e268722986f828295f1e73ch1269",
   "shareId":"0c2f0b363b8e681746d315025e971b5cch0846",
   "rootFileId":"00000000007E9B8B736861726547756964233866363465616530303433353763333461663661363538393264336630353961636834616236236439303865626162663065323638373232393836663832383239356631653733636831323639233063326630623336336238653638313734366433313530323565393731623563636830383436",
   "publicUrl":"https://dev-onezone.default.svc.cluster.local/share/0c2f0b363b8e681746d315025e971b5cch0846",
   "publicRestUrl":"https://dev-onezone.default.svc.cluster.local/api/v3/onezone/shares/0c2f0b363b8e681746d315025e971b5cch0846/public",
   "name":"Public two",
   "handleId":"3e000b055c3d0709097fd2dbfd96f9fech0280",
   "fileType":"dir",
   "description":"",
   "creator":{
      "type":"user",
      "id":"18315530b102ae46e5890f301b72e151ch19c1"
   },
   "creationTime":1686741221
}
```

In the example, created Handle ID is `3e000b055c3d0709097fd2dbfd96f9fech0280`.

Now you can get detailed information about the Handle using:

```shell
HANDLE_ID="3e000b055c3d0709097fd2dbfd96f9fech0280"
curl -u user:password https://${ONEZONE_HOST}/api/v3/onezone/handles/${HANDLE_ID}
```

which could result in:

```json
{
   "timestamp":"2023-06-14T11:35:30Z",
   "resourceType":"Share",
   "resourceId":"0c2f0b363b8e681746d315025e971b5cch0846",
   "publicHandle":"https://dev-onezone.default.svc.cluster.local/share/0c2f0b363b8e681746d315025e971b5cch0846",
   "metadata":"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n<metadata xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:dc=\"http://purl.org/dc/elements/1.1/\"><dc:title>Public two</dc:title><dc:creator>Unnamed User</dc:creator> <dc:description>My description</dc:description><dc:date>2023-06-14</dc:date></metadata>",
   "handleServiceId":"054900fc799a7f14451e99fac94f351ach7099",
   "handleId":"3e000b055c3d0709097fd2dbfd96f9fech0280",
   "creator":{
      "type":"user",
      "id":"a807cb71fd4524f3bbbd1dbc6c51292fch4524"
   },
   "creationTime":1686742530
}
```

<!-- references -->

[1]: <>

[Open Data]: https://en.wikipedia.org/wiki/Open_data

[Shares]: ./shares.md

[DOI]: http://www.doi.org/

[PID]: http://www.pidconsortium.eu/

[Dublin Core]: https://en.wikipedia.org/wiki/Dublin_Core

[OAI-PMH]: https://www.openarchives.org/pmh/

[handle-www]: http://handle.net/

[Handle services]: ../admin-guide/onezone/configuration/handle-services.md

[Share management view]: ./shares.md#share-management-view

[dublin-core-DCES-www]: https://www.dublincore.org/specifications/dublin-core/dces/

[Share description]: ./shares.md#share-description

[Handle API]: https://onedata.org/#/home/api/stable/onezone?anchor=tag/Handle

[Handle Service API]: https://onedata.org/#/home/api/stable/onezone?anchor=tag/Handle-Service

[screen-tab-expose]: ../../images/user-guide/public-data/tab-expose.png

[screen-expose-dublin-core-visual]: ../../images/user-guide/public-data/expose-dublin-core-visual.png

[screen-expose-dublin-core-xml]: ../../images/user-guide/public-data/expose-dublin-core-xml.png

[screen-expose-public-data-preview]: ../../images/user-guide/public-data/expose-public-data-preview.png

[screen-expose-public-handle-link]: ../../images/user-guide/public-data/expose-public-handle-link.png

[screen-tab-public-data]: ../../images/user-guide/public-data/tab-public-data.png

[screen-tab-files]: ../../images/user-guide/public-data/tab-files.png
