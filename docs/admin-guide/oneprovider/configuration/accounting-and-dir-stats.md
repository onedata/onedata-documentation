# Accounting & directory size statistics

This guide is dedicated to admin users that would like to understand and interpret file
and directory size statistics in a space. Consider reading the [counterpart documentation
for users][user-doc].

Accounting enables [directory size statistics][dir-stats] and prevents space members from disabling them, making sure that
accounting data is always available. Only Oneprovider admins can manipulate this option.

Accounting and directory size statistics can be enabled/disabled when granting a [new support][space-support] to a space
and later in a [space support overview][dir-stats-enable-panel] in Onepanel.

::: tip NOTE
Directory size statistics must be enabled to provide aggregated information about directories.
They are also required for features such as viewing directory [data distribution][data-distribution].
:::

<!-- references -->

[user-doc]: ../../../user-guide/dir-stats.md

[dir-stats]: ../../../user-guide/dir-stats.md#directory-size-statistics

[data-distribution]: ../../../user-guide/data-distribution-and-metrics.md

[space-support]: ./space-support.md#granting-space-support

[dir-stats-enable-panel]: ./space-support.md#space-support-overview
