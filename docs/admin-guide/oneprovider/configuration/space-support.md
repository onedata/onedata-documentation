# Space support

A space can be perceived as a logical container for data — a layer that hides
the complexity of different storage systems and the physical location of files.
As such, it requires at least one physical storage attached to be fully
functional. That attachment to a storage backend is called *supporting* the
space and is done by a data provider. For more information about the space
support concept, refer to [this page][user-guide-space-support].

## Granting space support

To request support for a space, its administrator generates a request token
similar to the one below:

```
MDAxZWxvY2F00aW9uIGRlbW8ub25lZGF00YS5vcmcKMDA5NWlkZW500aWZpZXIgMi900bXAtMS91...
```

It can then be passed to a provider administrator. From this point, the provider
administrator can choose whether the support should be granted and how the
provider should handle it.

When you — the administrator of the provider — receive a request support token
and you want to grant storage to the space behind that token, go to the
Onepanel of your Oneprovider cluster (**Clusters > *Cluster name*** view).

![screen-1-onepanel-gui][]

Navigate to the **Spaces** submenu of your cluster and click on the **Support
space** button at the top of the page. You will see a form with space support
properties.

![screen-2-support-form][]

Now, select a storage backend you would like to use for new support, paste the support
token, and choose how much storage capacity should be granted.

::: tip
It is possible to support space using a storage backend allowing data import.
Read more [here][storage-import].
:::

::: warning
Remember that each provider can grant support for a specific space only once.
Hence you should choose the supporting storage carefully as this decision is
irreversible.
:::

In addition, you can turn on/off accounting and directory statistics. The latter
feature is responsible for collecting information about the logical and physical
size of directories as well as files number in the space. The former uses
directory statistics to provide quota usage over time.

::: tip
The directory statistics feature is enabled by default, but for some scenarios,
it might be suitable to turn it off. That may include cases, when information
about directory size is not required by any space use-case and, at the same
time, very frequent file modifications across many different directories could
cause statistics aggregation to consume a meaningful amount of resources.
:::

In the end, click on the **Support space** button. From now on, the space you have
supported has additional storage, so space users can benefit from the additional
capacity and data transfer possibilities.

## Space support overview

Each space support handled by a particular provider can be found in
the **Clusters > *Cluster name* > Spaces** view.

![screen-3-supports-list][]

Click on a specific space support to see its details grouped into four tabs.

### "Overview" tab

![screen-4-overview][]

This tab contains basic information about the selected space support, including
the name of the space, assigned storage, state of statistics-related features, and
support size. You can also modify some of them up to your preference.

### "Storage import" tab

![screen-5-storage-import][]

This tab shows the current state of the *storage import* mechanism. It allows
registering (importing) data located on the supporting storage directly into the
supported space. You can read more about storage import
[here][storage-import].

It is available only if storage import was enabled during space support
creation.

### "File popularity" tab

![screen-6-file-popularity][]

This tab allows configuring the *file popularity* mechanism. That functionality
enables tracking of usage statistics for files in a space. Read more details
[here][file-popularity].

### "Auto-cleaning" tab

![screen-7-auto-cleaning][]

This tab contains the configuration and execution history of the *auto-cleaning*
mechanism. The purpose of this feature is to automatically maintain storage
usage at a certain level and ensure that there is enough space for new replicas
when performing continuous computations. See [this][auto-cleaning] chapter
for more details.

It is available only when *file popularity* is enabled.

## Revoking space support

Currently, it is not possible to revoke space support once it is granted. The
next Onedata release is intended to provide that option. For now, it is possible
to either:

* [change the size][] of the granted support,
* remove the space (and all related supports).

## REST API

All operations related to space support management can be performed using
the REST API. Refer to the linked API documentation for detailed information and
examples.

| Request                   | Link to API                    |
| ------------------------- | ------------------------------ |
| Support space             | [API][api-support-space]       |
| List supported spaces     | [API][api-get-provider-spaces] |
| Get space support details | [API][api-get-space-details]   |
| Modify space support      | [API][api-modify-space]        |

[user-guide-space-support]: ../../../user-guide/spaces.md#space-support

[storage-import]: storage-import.md

[file-popularity]: file-popularity.md

[auto-cleaning]: auto-cleaning.md

[change the size]: #overview-tab

[api-support-space]: https://onedata.org/#/home/api/latest/onepanel?anchor=operation/support_space

[api-get-provider-spaces]: https://onedata.org/#/home/api/latest/onepanel?anchor=operation/get_provider_spaces

[api-get-space-details]: https://onedata.org/#/home/api/latest/onepanel?anchor=operation/get_space_details

[api-modify-space]: https://onedata.org/#/home/api/latest/onepanel?anchor=operation/modify_space

[screen-1-onepanel-gui]: ../../../../images/admin-guide/oneprovider/configuration/space-support/1-onepanel-gui.png

[screen-2-support-form]: ../../../../images/admin-guide/oneprovider/configuration/space-support/2-support-form.png

[screen-3-supports-list]: ../../../../images/admin-guide/oneprovider/configuration/space-support/3-supports-list.png

[screen-4-overview]: ../../../../images/admin-guide/oneprovider/configuration/space-support/4-overview.png

[screen-5-storage-import]: ../../../../images/admin-guide/oneprovider/configuration/space-support/5-storage-import.png

[screen-6-file-popularity]: ../../../../images/admin-guide/oneprovider/configuration/space-support/6-file-popularity.png

[screen-7-auto-cleaning]: ../../../../images/admin-guide/oneprovider/configuration/space-support/7-auto-cleaning.png
