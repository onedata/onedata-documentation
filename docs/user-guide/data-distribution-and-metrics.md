# Data distribution & metrics

[toc][]

## Overwiev

The data in spaces may be arbitrarily distributed among the storage backends of the
supporting providers.

![screen-distribution-diagram][]

On the physical level, Onedata organizes files into blocks of various sizes.  These file
blocks can then be distributed across different storage backends that support the space
in which the files are stored. Each provider contains a list of local file blocks, forming
what we call a `file replica`.  Information about the mapping between logical and physical
files is stored in the file metadata, which is replicated and synchronized between all
supporting providers.

Single file can have many replicas on different storage backends. This has the following
benefits:

* Improved performance — when interacting with the data available locally on the provider
  where it is needed.
* Data loss prevention — data copies distributed across multiple physical locations
  provide redundancy.
* Compliance with policies — ensuring the data is stored in particular geographical locations.
* Better collaboration — users can collaborate and modify shared files on different
  sites, knowing that the changes will be synchronized.

### File modification impact on replica

When you read a whole file or its part, and some blocks are not present in the provider
you're connected to, the missing blocks will be replicated on the fly from other providers.

When you write to a file in a given provider, the overlapping blocks replicated to other
providers are invalidated. To read the file, the provider with invalidated blocks must
once again replicate missing blocks from the provider with the newest version of the blocks.

Simultaneous modifications of a file may occur when many users access it.  If the ranges
of simultaneous modifications do not overlap, all modifications are safely applied. In
case of a conflict, a conflict resolution algorithm is used.  This allows all supporting
providers to determine a consistent, final version of the file. Conflict resolution is
performed independently by each provider without the need to coordinate the resolution
with other supporting providers, which allows it to be fast.

## Distribution management

Data distribution is about controlling the physical location of data fragments and is
applicable for spaces with at least two provider supports. You can manage the data
distribution using:

### Data transfers

[Data transfer][] is a process of moving physical data between providers within a Onedata
space. It is used to control the data distribution of a logical file/directory.

Transfers can be initiated:

* automatically (on the fly) — when a data read is requested, but the provider does not
  have the corresponding blocks. The missing data is replicated from other providers in the
  background, while the read operation is blocking (see [File modification impact on replica][])
* manually — upon the explicit request of a user with sufficient privileges.

### Rule based replication (QoS)

[Quality of Service (QoS)][qos] is used to manage file replica distribution and redundancy
between providers supporting a space in an automated manner.
Allows specifying requirements that may ensure that file replicas in certain providers are
automatically updated and protected from eviction.

### Auto-cleaning

[Auto-cleaning][] automatically maintains storage usage at a predefined level, creating
freeing storage capacity for new replicas during continuous computations.

::: tip NOTE
Auto-cleaning can only be configured by a space admin.
:::

## Discovering data distribution

You can discover how the data is distributed among storage backends supporting the space
in which it is stored like below:

### Web GUI

Open the context menu for the file and choose **Data distribution**:
![screen-data-distribution-gui][]

and you will see **Data distribution** modal, representing the distribution of file blocks:
![screen-file-distribution][]

The view of data distribution for directories differs slightly from the view for files;
instead of the layout of blocks, the replication ratio is shown:

<!-- fixme dir distribution screen -->

<!-- fixme storage locations explain -->

::: tip NOTE
To view distribution for directories directory statistics have to be enabled by the
space administrator. You can see where to do it in [admin guide][dir-stats-enable].
:::

Directory statistics are explained in more detail [below][dir-stats].

### REST API

Data distribution can be accessed using the REST API. Refer to the linked
API documentation for detailed information and examples.

| Request                    | Link to API |
| -------------------------- | ----------- |
| Get data distribution      | [API][1]    |
| Get file storage locations | [API][2]    |

### Oneclient

Check [file extended attributes][Oneclient xattrs] and inspect `org.onedata.file_blocks`,
`org.onedata.file_blocks_count` and `org.onedata.replication_progress` attributes:

```bash
~$ xattr -l results.txt

org.onedata.file_blocks: [#######################################.         ]
org.onedata.file_blocks_count: 1
org.onedata.replication_progress: 80% 
...
```

::: tip NOTE
Extended attributes present only information about file blocks stored in the provider to which the Oneclient is
connected. To find information about replicas of the file in other providers, use the Web GUI or REST API (see above).
:::

::: tip NOTE
Only data distribution for regular files is available with this method.
:::

## Directory statistics

When collecting directory statistics is [enabled by a space administrator][dir-stats-enable], they are collected for
each directory in a space.

::: tip NOTE
Directory statistics are not counted automatically, instead they are calculated over time, so there may be
discrepancies in actively used spaces
:::

There are different types of size statistics you can access for a directory:

* virtual size — how many bytes it would take to store data of the directory if there was only one
  replica of each file (note that irrelevant to how many hard links a file has there is
  only one representation on a storage backend)
* logical size — total size if the directory when it is downloaded (each file hard link is
  downloaded separately and therefore its sizes are summed)
* physical size — how many bytes are actually stored on a storage backend, taking into
  account all replicas and data redundancy.
* regular files and hard link count — how many regular files and hard links are there in whole subtree of the directory.
* directory count — how directories are there in whole subtree of the directory.

### Web GUI

Open the context menu for the file and choose **Information**:

<!-- fixme ![screen-cotext-menu-information-gui][] -->

and then in **Size stats** tab you will see directory statistics on all providers supporting a space, as well charts
with its changes over time.

<!-- fixme ![screen-size-stats][] -->

### REST API

Directory statistics can be accessed using the REST API. Refer to the linked
API documentation for detailed information and examples.

| Request                  | Link to API |
| ------------------------ | ----------- |
| Get directory statistics | [API][3]    |

::: tip NOTE
Only statistics local to a provider can be accessed via REST, so you won't see physical size on storage
backends of other providers.
:::

<!-- references -->

[toc]: <>

[Data transfer]: ./data-transfers.md

[File modification impact on replica]: #file-modification-impact-on-replica

[qos]: ./rule-based-replication-qos.md

[Auto-cleaning]: ../admin-guide/oneprovider/configuration/auto-cleaning.md

[dir-stats-enable]: ../admin-guide/oneprovider/configuration/space-support.md#space-support-overview

[dir-stats]: #directory-statistics

[Oneclient xattrs]: interfaces/oneclient.md#file-extended-attributes

[1]: https://onedata.org/#/home/api/stable/oneprovider?anchor=operation/get_data_distribution

[2]: https://onedata.org/#/home/api/stable/oneprovider?anchor=operation/get_file_storage_locations

[3]: https://onedata.org/#/home/api/stable/oneprovider?anchor=operation/get_directory_size_stats

[screen-distribution-diagram]: ../../images/user-guide/data-distribution-and-metrics/distribution-diagram.png

[screen-file-distribution]: ../../images/user-guide/data-distribution-and-metrics/example-file-distribution.png

[screen-data-distribution-gui]: ../../images/user-guide/data-distribution-and-metrics/menu-data-distribution.png
