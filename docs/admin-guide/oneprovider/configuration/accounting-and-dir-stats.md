# Accounting & directory size statistics

Accounting enables [directory size statistics][dir-stats] and prevents space members from disabling them, making sure that
accounting data is always available. Only Oneprovider admins can manipulate this option.

Accounting and directory size statistics can be enabled/disabled when granting a [new support][space-support] to a space
and later in a [space support overview][dir-stats-enable-panel] in Onepanel.

Directory size statistics need to be enabled so [data distribution][data-distribution] view is possible for directories.

### Enabling directory size statistics as space manager

In navigation bar go to `Data`, then select a space you want to modify and click on `Providers`.

![screen-data-sidebar-provider-selected][]

In top row select a provider on which you want to make a modification. There you can enable/disable
directory size statistics for a selected space.

To enable/disable directory size statistics for a space, you need the `Modify space` privilege in that space.

![screen-enable-dir-stats-provider][]

::: tip NOTE
This method is not available when [accounting][] has been enabled in this space by Oneprovider admin.
:::

<!-- references -->

[dir-stats]: ../../../user-guide/size-stats.md#directory-size-statistics

[data-distribution]: ../../../user-guide/data-distribution-and-metrics.md

[space-support]: ./space-support.md#granting-space-support

[dir-stats-enable-panel]: ./space-support.md#space-support-overview

[accounting]: #accounting--directory-size-statistics

[screen-data-sidebar-provider-selected]: ../../../../images/admin-guide/oneprovider/configuration/accounting-and-dir-stats/data-sidebar-providers-selected.png

[screen-enable-dir-stats-provider]: ../../../../images/admin-guide/oneprovider/configuration/accounting-and-dir-stats/enable-dir-stats-provider.png
