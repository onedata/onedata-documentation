# Archives

[toc][]

## Overview

<!-- FIXME: nie wiem czy ten wstęp o OAIS jest poprawny i czy jest potrzebny -->

An [Open Archival Information System][] (OAIS) reference model describes a conceptual
framework for an archival system dedicated to preserving and maintaining access to digital
information over the long term. Onedata implements the core principles of the framework
with the **archives** feature. The concept of the archives is highly coupled with the
**datasets** feature of Onedata, so it is recommended to read the [datasets
documentation][dataset] first.

### Submission Information Package (SIP)

The Submission Information Package (SIP) of the OAIS model is an Information Package that
is delivered to the system for ingest. It contains the data to be stored and all the
necessary related metadata. The SIP is ingested into the system and serves as a basis for
the creation of an Archival Information Package (AIP) and a Dissemination Information
Package (DIP).

The SIP can be **pushed** into the Onedata archiving system through:

* Web GUI — by uploading the data,
* REST API,
* CDMI,
* S3 (rclone, aws-cli, s3cmd, MinIO...),
* Oneclient and OnedataFS.

SIP **pull** in the Onedata archiving system can be realized through:

* Oneprovider — data import,
* Automation engine:
  * BagIt (fetch),
  * Fetch.txt,
  * other custom scripts.

### Archives in Onedata

An **archive** is a snapshot of a [dataset][] created at a certain point in time.

Archives are immutable and stored within a space, lying in a special directory detached
from the regular file tree. They can be accessed using the specialized browser of
datasets and archives.

The archive creation process comes with several options:
<!-- FIXME: linki do sekcji -->
- different **layouts** — the structure of the files in the created archive; support for
  [BagIt][],
- creation of [nested archives][] — hierarchically-created archives for datasets with
  nested structure,
- [incremental archives][] — reusing the unchanged files between snapshots,
- **including DIP** — adding a Dissemination Information Package view for the archive,
- possibility to [follow symbolic links][] if they are present in the dataset.

## Creating archives

<!-- FIXME: przepisać tutorial? -->

To create archives of a file or directory, you should [establish a dataset][] on them first.

1. Open the datasets panel for a selected file or directory and click on the **Create archive** action of the [dataset actions][] context menu.
<!-- FIXME: dawać tutaj screena? -->

2. In the **Create archive** modal, write a description of the archive and use the
   default archiving settings.
<!-- FIXME: screen modala Create archive - w slajdach -->

3. Click on the **Create** button.

4. Upon successful creation, you should see the [archives list][] including the newly
   created archive.
<!-- FIXME: screen -->

<!-- FIXME: być może lepszą nazwą będzie "Archive list" (sprawdzić chat gpt) -->


<!-- FIXME: eksperymentalny nagłówek - wcześniej było "archives list"? może managing archives? -->
## Browsing archives

<!-- FIXME: napisać -->

A list of snapshots created from a single [dataset][] can be browsed using the **archives
list** view consisting of:

* **breadcrumbs** — showing the root of the dataset archives list, selected archive, and
  path of a browsed directory inside the archive,
* **the refresh button** — for optional view refresh, which is not needed in regular
  usage, because the list is auto-updated,
* **table column headers** — which you can configure just like in the regular [web file
  browser][], <!-- TODO:  -->
* **archives/files list** — showing the
  * dataset archives when you are in the dataset root,
  * or the [files][] inside the archive if you enter some archive.
<!-- FIXME: wyjaśnić kolumny? -->
From the archives list view, you can open the [context menu][archive actions] for an
archive or [browse][files] its contents by double-clicking on it.

### Archive files browser
 
The archive files browser works just as a regular [web file browser][] except it offers
read-only access both for data and metadata. You can also manage QoS and transfers of the
data between providers.
<!-- FIXME: screen -->
<!-- FIXME: napisać wzmiankę, że może być AIP/DIP? -->
<!-- FIXME: link do qos i transfers -->
<!-- FIXME: ustalić co pisać o przechowywaniu plików archiwów na storydżach, co ze ścieżkami? -->
<!-- FIXME: napisać m.in. o operacji sherowania, size stats -->

### Archive actions

An archive item in the browser offers the following context actions:

<!-- FIXME: linki do sekcji o archive details -->
* **Properties** — opening the archive properties tab in the [archive details panel][],
  which shows the basic info about archive configuration,
* **Edit description** — editing the archive description,
* **Show audit log** — showing the archivisation audit log tab in the [archive details
  panel][],
* **Copy archive ID** — instantly copying the archive ID into the clipboard,
* **Create incremental archive** — opening the [create archive][] modal with a subject
  archive selected as a base for the [incremental archive][],
* **Recall to...** — opening the modal for [recalling][] the archive,
* **Download (tar)** — downloading the _tar_ package with the archive contents,
* **Browse DIP** — opening the DIP (Dissemination Information Package) view of the archive
  files browser (if available),
* **Delete archive** — opening the modal for [deleting][] the archive.

### Archive details panel

The archive details panel, accessible from the [archive context menu][archive actions], consists of two tabs:

* **Properties** — showing the basic information about the archive, including the editable archive description and initial configuration set when the archive was [created][create archive],
* **Audit log** — allowing you to browse the [log][] from the archive creation.

<!-- FIXME: można przenieść tą sekcję do poziomu II, żeby była lepiej eksponowana (ktoś kto czyta TOC od razu zobaczy, że jest audit log) -->
### Archive audit log

The archive audit log consists of entries for every file or directory that was archived.
<!-- FIXME: screen z listy -->
The file or directory could be archived successfully or not, and in both cases the log entry shows granulated details about the process, such as archivisation times, file location, and its ID. In case of the archivisation failure, you can also check the error reason.
<!-- FIXME: screen z pojedynczego wpisu sukcesu i faila (obok siebie?) -->
In rare cases, the file data also be archived, but the data has been not successfully validated against its source — in this situation, there is both successful data archivisation and verification error entry in the log for the file.

## Incremental archives

A default, **regular archive** is a **full copy** of the [dataset][] contents, occupying
an additional storage quota. Storage space can be saved by creating incremental archives,
whenever possible.

An **incremental archive** is created upon the chosen base archive and reuses all files
that haven't been modified between the snapshots, creating hard links to them (which take
no storage space). **Only the modified and new files are copied**.
<!-- FIXME: link do hard links w information panel jak będzie? -->

![screen-archive-incremental][]

The above diagram shows two modes of creating subsequent archives for the dataset:

* the **Experiment A** dataset's most recent archive is created using the **incremental**
  option, which shares the unmodified files with the former archive using hard links,
* while the **Results** dataset's archives are created separately — each archive has a
  separate copy of the, even unmodified, data.

::: tip NOTE
You can [delete][deleting] the **base** archive without loss of data in the incremental
archives — the data remains until the last reference of the shared file data is deleted.
:::

### Creating incremental archives

1. Open the **Archives** tab of the **Datasets** panel for a file or directory that
   contains an [archives list][] view.

2. Open the context menu for an archive that should serve as a base for a new incremental
   archive, and choose **Create incremental archive**. Files that haven't been modified in
   the dataset, compared to the selected archive, will be hardlinked instead of being
   copied.
<!-- FIXME: screen -->

3. The **Incremental** toggle should be enabled and locked in the **Create archive**
   modal. The **Base archive** should indicate the chosen one.

4. Click on the **Create** button.

5. In a few moments, the new archive should pop up on the list. Note the **Base archive**
   indication.

Upon the creation, you can browse the contents of the archive and notice that the files
that haven't been changed, compared to the base archive, have a **hard links** badge — the
number of hard links typically indicates how many archives share the data. You can
check hard link locations by clicking on the **hard links** badge  — it should
present paths to files in the other archives.

<!-- FIXME: screen z hardlinkami -->

## Nested archives

[Nesting datasets][dataset hierarchy] allow composing structures of desired granularity.
An embedded dataset can be a logical whole that's useful individually, and at the same
time be a part of a bigger data collection, vital for its completeness.

A default, **monolithic archive** is a snapshot of the whole dataset regardless it has
child datasets or not. The filesystem of the archive simply contains a copied dataset
filesystem tree.

As the dataset nested structures are also important when archives are created, on the
ancestor dataset level, users may choose to **create nested archives** in the process.
This way, a set of linked archives will be created.

![screen-archive-nested][]

The above diagram shows the **nested** archives concept placed in the [dataset hierarchy][]
tree. The **Experiment A** dataset, which has the **Results** embedded dataset, creates an
archive with the **nested** option enabled. This option causes an automatic creation of
archives for all the embedded datasets inside the **Experiment A** datasets tree — in this
case, the **Results** dataset.

The **Results** directory, which occurs in the **Experiment A** archive filesystem tree, is
**symbolically linked** to the archive filesystem created from the embedded **Results**
dataset. This way, while you browse down the contents of the **Results** directory inside
the archive created from **Experiment A**, you technically browse the contents of an
automatically created archive from the **Results** dataset. You can also browse the
archive created from the **Results** dataset directly, starting from the **Results**
directory.

::: tip NOTE
As the child of the nested archive is referenced by the symbolic link in the parent
archive, [deleting][] the child archive is **not allowed**, because it would cause an
inconsistency in the parent archive.
:::

### Creating nested archives

You need to have a [dataset hierarchy][] — essentially a dataset established inside the
filesystem tree of the other dataset.

1. Open the **Archives** tab of the **Datasets** panel for a file or directory that has a
   dataset established and has a child dataset.

2. Open the **Create archive** modal as described in the [creating archives][create
   archive] section.

3. Enable the **Create nested archives** toggle.

4. Click on the **Create button**.

Upon successful creation, you should see the newly created archive on the list. Browse its
contents — note, that the nested dataset directories are symbolic links. These links point
to directories copied into the archives that were created from those nested datasets.

Close the **Datasets** panel, and navigate to the nested datasets in the web file browser,
opening their **Datasets** panel. These nested datasets have a new archive automatically
created at the time, the nested archive was created for the parent dataset. Note, that the
description of the child archive is the same as that of the parent archive. Browse the
archive to find out, that its root is the snapshot of the child dataset root.

## Symbolic links in archives

**Following the symbolic links** during an archive creation, which is done by default,
allows the files or directories to be included from outside the source dataset. Valid
links are resolved and their target files/directories are copied to the archive in
their place. Invalid symbolic links (not resolvable to a valid path in the space) are
ignored and not included in the archive.

If you disable the **symbolic links following** option upon archive creation, symbolic
links are copied to the resulting archive, and their target paths are not modified. Note
that these symbolic links may target **modifiable** files in the space.

::: tip NOTE
Symbolic links pointing to files inside the dataset are always preserved, regardless of
this setting. Their target paths are reconstructed to point to the corresponding files in
the resulting archive.
:::

## BagIt archives and DIP

[BagIt][] is a set of hierarchical file system conventions for organizing and transferring
digital content.

A **"bag"** consists of the **"payload"** (actual content) with **"tags"** serving as
metadata files documenting storage and transfer details. A mandatory tag file includes a
manifest listing every file and its corresponding checksums.

The term "BagIt" is inspired by the "enclose and deposit" method, also known as **"bag it
and tag it"**.

An archive created in BagIt format contains extra **tag** files in the filesystem tree
compared to the source dataset (**payload**). By default, you access the Archival
Information Package of the archive, which presents the extra BagIt structure, but thanks
to **including the DIP**, you can have also a view of only the payload of the filesystem,
which mirrors the dataset filesystem snapshot.

### Creating BagIt archives with DIP

<!-- FIXME: screeny -->

1. Start archive creation using the [create archive][] modal.

2. In the modal:
   * set **Layout** to **BagIt**,
   * enable the **Include DIP** toggle.

3. Click on the **Create** button.

Upon successful creation, you should see the newly created archive on the list. Browse its
contents — note, that the **AIP/DIP switch** in the **Files** column is active and set to AIP.

You can see the extra files created in compliance with the BagIt format:

* `bagit.txt`,
* `data` directory,
* `manifest-*.txt`,
* `metadata.json`,
* `tagmanifest-*.txt`.

The structure of the BagIt archive is described in [The BagIt File Packaging Format RFC Structure section][].

The `data` directory contains the payload — a snapshot of the dataset filesystem.

You can use the **AIP/DIP** switch in the **Files** column to switch to the **DIP** view. Now, the file browser shows the exact filesystem structure of the payload without BagIt extra files.

::: tip NOTE
AIP and DIP archives are technically two separate archives, but the hard links are used to
share the **payload**, so no additional storage quota is used with the **include DIP**
option. This is the reason, why you see the **hard links** tag on the files of payload.
:::

## Archive recall

While archives serve as immutable snapshots, the dataset may evolve in time as the data in
the space changes. Sometimes it is desirable to bring back a certain snapshot into the
space filesystem to work on it.

To do that, users may **recall** the archive. The process copies the data at the chosen
path in the space, creating a new file/directory that is **not logically linked** to the
original dataset.

### Recalling archives

1. Go to the **Archives** tab in the **Datasets** panel of the selected file or directory.

2. Open the context menu for an archive you wish to **recall** and choose **Recall to...**

3. In the **Recall archive** panel that has appeared, navigate to the parent directory
   where you want to recall the archive.
<!-- FIXME: screenshot -->
4. Set the **Target directory name** at the bottom (if the archive is file-based, then it
   would be a **Target file name**). See the result target path at the bottom — the
   archive will be recalled to that location.

5. Click on the **Recall** button at the bottom-right corner of the panel.

Close the remaining **Datasets** panel and navigate to the recall target directory. Depending on the current recall status you can see the following badge on the file/directory row:
* if the recall process is still in progress — a green **Recalling** badge showing the recall progress,
* if the recall has been completed successfully — a blue **Recalled** badge,
* if the recall has been completed with some errors — a red **Recall failed** badge.
<!-- FIXME: screenshot trzykolumnowy/potrójny - recall in progress, recalled, recall failed -->

Regardless the recall is in progress or is completed, you can click on the badge to open the **Archive recall information** panel, where you can see various information about the working or completed recall process, such as source archive and dataset, start and finish times, and amount of recalled data.
<!-- FIXME: screenshot dwukolumnowy - recall in progress i recalled panel -->

If the recall failed, the **Archive recall information** panel contains information about files that have failed to be recalled. In the **Error log** tab of the panel, you can browse information about the particular file recall error: time of occurrence, link to the file in the source archive, and the error reason. 
<!-- FIXME: screen z panelu z błędami-->

## Deleting archives

<!-- FIXME: nagłówki tutaj i w archives są takie, że są rzeczownikowe, a wewnątrz są "akcje" - zobaczyć jak jest gdzieś indziej i ujednolicić -->

<!-- FIXME: napisać -->

🚧 Under construction! 🚧

<!-- references -->

[toc]: <>

[archives list]: #browsing-archives

[dataset]: ./datasets.md

[create archive]: #creating-archives

[archive actions]: #archive-actions

[files]: #archive-files-browser

[archive details panel]: #archive-details-panel

[incremental archive]: #incremental-archives

[recalling]: #recalling-archives

[deleting]: #deleting-archives

[log]: #archive-audit-log

[follow symbolic links]: #symbolic-links-in-archives

[nested archives]: #nested-archives

[incremental archives]: #incremental-archives

[establish a dataset]: ./datasets.md#establishing-datasets

[dataset actions]: ./datasets.md#dataset-actions

[dataset hierarchy]: ./datasets.md#datasets-hierarchy

[web file browser]: ./web-file-browser.md

[BagIt]: https://datatracker.ietf.org/doc/html/rfc8493

[The BagIt File Packaging Format RFC Structure section]: https://datatracker.ietf.org/doc/html/rfc8493#section-2

[Open Archival Information System]: http://www.oais.info/

[screen-archive-incremental]: ../../images/user-guide/archives/archive-incremental.svg

[screen-archive-nested]: ../../images/user-guide/archives/archive-nested.svg
