# Space support

A space can be perceived as a logical container for data — a layer that hides
the complexity of different storage systems and the physical location of files.
As such, it requires at least one physical storage attached to be fully
functional. That attachment to a storage is called **supporting** the space and
is done by a data provider. For more information about the space support
concept, refer to [this page](../../../user-guide/spaces.md#space-support).

## Granting space support

To request a support for a space, its administrator generates a request token
similar to the one below:
```
MDAxZWxvY2F00aW9uIGRlbW8ub25lZGF00YS5vcmcKMDA5NWlkZW500aWZpZXIgMi900bXAtMS91...
```
It then can be passed to a provider administrator. From this point, the provider
administrator can choose whether the support should be granted and how the
provider should handle it.

When you — the administrator of the provider — receive a request support token
and you want to grant a storage to the space behind that token, go to the
Onepanel of your Oneprovider.

![Onepanel GUI](../../../../images/admin-guide/oneprovider/configuration/space-support/1-onepanel-gui.png#screenshot)

Navigate to "Spaces" and click on "Support space" button at the top of the page.
You will see a form with space support properties.

![Support form](../../../../images/admin-guide/oneprovider/configuration/space-support/2-support-form.png#screenshot)

Now, select a storage you would like to use for a new support, paste the support
token and choose how much storage capacity should be granted.

::: tip
It is possible to support space using a storage allowing data import.
Read more [here](storage-import.md).
:::

::: warning
Remember that each provider can support a specific space only once. Hence you
should choose the supporting storage carefully as this decision is irreversible.
:::

In addition, you can turn on/off accounting and directory statistics. The latter
feature is responsible for collecting information about the logical and physical
size of directories as well as file count in the space. The former uses
directory statistics to provide quota usage over time.

::: tip
The directory statistics feature is enabled by default, but for some scenarios,
it might be suitable to turn it off. That may include cases, when information
about directory size is not required by any space use-case and, at the same
time, very frequent file modifications across many different directories could
cause statistics aggregation to consume a meaningful amount of resources.
:::

In the end, click on "Support space". From now, the space you have supported has
an additional storage and space users can benefit from the additional capacity
and data transfer possibilities.

## Space support overview

Each space support handled by a particular provider can be found in "Spaces"
menu in its Oneprovider Panel GUI.

![Supports list](../../../../images/admin-guide/oneprovider/configuration/space-support/3-supports-list.png#screenshot)

Click on a specific space support to see its details grouped into four tabs.

### "Overview" tab

![Overview](../../../../images/admin-guide/oneprovider/configuration/space-support/4-overview.png#screenshot)

This tab contains basic information about the selected space support, including
name of the space, assigned storage, state of statistics-related features and
support size. You can also modify some of them up to your preference.

### "Storage import" tab

![Storage import](../../../../images/admin-guide/oneprovider/configuration/space-support/5-storage-import.png#screenshot)

This tab shows current state of the *storage import* mechanism. It allows to
register (import) data located on the supporting storage directly into the
supported space. You can read more about storage import
[here](storage-import.md).

It is available only when storage import was enabled during space support
creation.

### "File popularity" tab

![File popularity](../../../../images/admin-guide/oneprovider/configuration/space-support/6-file-popularity.png#screenshot)

This tab allows to configure the *file popularity* mechanism. That functionality
enables tracking of usage statistics for files in a space. Read more details
[here](file-popularity.md).

### "Auto-cleaning" tab

![Auto-cleaning](../../../../images/admin-guide/oneprovider/configuration/space-support/7-auto-cleaning.png#screenshot)

This tab contains configuration and execution history of the *auto-cleaning*
mechanism. The purpose of this feature is to automatically maintain storage
usage at a certain level and ensure that there is enough space for new replicas
when performing continuous computations. See [this](auto-cleaning.md) chapter
for more details .

It is available only when *file popularity* is enabled.

## Revoking space support

Currently, it is not possible to revoke space support once it was granted. The
next Onedata release is intended to provide that option. For now, it is possible
to either:
* [change size](#overview-tab) of the granted support or
* remove space (and so all related supports).

## REST API

All operations related to the space support management can be performed using
the REST API. Refer to the linked API documentation for detailed information and
examples.

| Request                     | Link to API                                                                                |
|---------------------------- |--------------------------------------------------------------------------------------------|
| Support space               | [API](https://onedata.org/#/home/api/latest/onepanel?anchor=operation/support_space)       |
| List supported spaces       | [API](https://onedata.org/#/home/api/latest/onepanel?anchor=operation/get_provider_spaces) |
| Get space support details   | [API](https://onedata.org/#/home/api/latest/onepanel?anchor=operation/get_space_details)   |
| Modify space support        | [API](https://onedata.org/#/home/api/latest/onepanel?anchor=operation/modify_space)        |
