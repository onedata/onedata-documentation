# Size statistics

In distributed environments, the concept of **size** may vary depending on whether we refer to the logical view of data,
its physical storage footprint, or its deduplicated representation. Onedata distinguishes between these size types to
accurately reflect how data is stored, replicated, and accessed across providers. Understanding these differences is
important when monitoring storage usage, planning capacity, or analyzing replication completeness.

### Regular files

* `logical_size` — total number of bytes in the file content, from the point of view of the Onedata logical namespace. Independent of the file’s distribution or replication.
* `physical_size` — actual amount of storage consumed to store the file on a given storage backend. May be smaller than the logical size if the file replica is incomplete.

### Directories

* `logical_size` — total size of file data contained in the directory, i.e. the sum of logical sizes of all regular files in its subtree. If a file has multiple hardlinks in the subtree, each hardlink is counted separately.
* `virtual_size` — deduplicated logical size, where hardlinks of the same file in the subtree are counted only once. Represents the storage space required for a complete replica of the directory.
* `physical_size` — actual amount of storage consumed on a given storage backend by all regular files in the directory’s subtree. May be smaller than the virtual size if some file replicas are incomplete.

## Directory size statistics

When the collecting of directory size statistics has been enabled by an [Oneprovider admin][dir-stats-enable-panel] or [space manager][dir-stats-enable-provider], they are collected for
each directory in a space.

Directory size statistics are not calculated instantly. Instead, they are updated in the background, beginning with the
deepest subdirectories and then moving up step by step until the space root directory is updated.

::: tip NOTE
Directory size statistics are updated gradually, with results propagated up to the space root directory.
In actively used spaces, this may cause temporary discrepancies in the reported values.
:::

Different types of statistics can be accessed for a directory, such as its [virtual][data-size-dir], [logical][data-size-dir] and [physical size][data-size-dir] as well as count of regular files and directories in its subtree.

::: warning
If providers are not yet fully synchronized, the reported directory size statistics may temporarily differ between them.
:::

### Web GUI

Open the context menu for the file and choose **Information** and then in **Size stats** tab you will see directory size statistics on all providers supporting a space, as well charts
with its changes over time:

![screen-size-stats][]

### REST API

Directory size statistics can be accessed using the REST API. Refer to the linked
API documentation for detailed information and examples.

| Request                       | Link to API |
| ----------------------------- | ----------- |
| Get directory size statistics | [API][1]    |

::: tip NOTE
Only statistics local to a provider can be accessed via REST, so you won't see physical size on storage
backends of other providers.
:::

### Space directory size statistics

Directory size statistics for the space root directory are broader because they include all data stored in the space. This means
that both [archives][] and the trash are also included in the calculation. The trash contains files that are currently
being deleted, as well as files that have already been deleted while being open but are not yet closed by all users.

You can switch between those statistics in a size stats modal for a space directory:

![screen-stats-special-dirs-space][]

<!-- references -->

[data-size-dir]: #directories

[dir-stats-enable-panel]: ../admin-guide/oneprovider/configuration/space-support.md#space-support-overview

[dir-stats-enable-provider]: ../admin-guide/oneprovider/configuration/accounting-and-dir-stats.md#enabling-directory-size-statistics-as-space-manager

[archives]: ./archives.md

[1]: https://onedata.org/#/home/api/stable/oneprovider?anchor=operation/get_directory_size_stats

[screen-size-stats]: ../../images/user-guide/size-stats/dir-size-stats-modal.png

[screen-stats-special-dirs-space]: ../../images/user-guide/size-stats/stats-special-dirs-space.png
