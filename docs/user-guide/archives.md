# Archives

[toc][]

## Overview

<!-- FIXME: nie wiem czy ten wstęp o OAIS jest poprawny i czy jest potrzebny -->

An [Open Archival Information System][] (OAIS) reference model describes a conceptual framework for an archival system dedicated to preserving and maintaining access to digital information over the long term. Onedata implements the core principles of the framework with the **archives** feature. The concept of the archives is highly coupled with the **datasets** feature of Onedata, so it is recommended to read the [datasets documentation][dataset] first.

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
  BagIt,
- creation of **nested archives** — hierarchically-created archives for datasets with
  nested structure,
- **incremental** archives — reusing the unchanged files between snapshots,
- **including DIP** — a Dissemination Information Package,
- possibility to **follow symbolic links** if they are present in the dataset.

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

A list of snapshots created from a single [dataset][] can be browsed using the **archives list** view consisting of:

* **breadcrumbs** — showing the root of the dataset archives list, selected archive, and path of a browsed directory inside the archive,
* **the refresh button** — for optional view refresh, which is not needed in regular usage, because the list is auto-updated,
* **table column headers** — which you can configure just like in the regular [web file browser][], <!-- TODO:  -->
* **archives/files list** — showing the
  * dataset archives when you are in the dataset root,
  * or the [files][] inside the archive if you enter some archive.
<!-- FIXME: wyjaśnić kolumny? -->
From the archives list view, you can open the [context menu][archive actions] for an archive or [browse][files] its contents by double-clicking on it.

### Archive files browser
 
The archive files browser works just as a regular [web file browser][] except it offers read-only access both for data and metadata. You can also manage QoS and transfers of the data between providers.
<!-- FIXME: screen -->
<!-- FIXME: napisać wzmiankę, że może być AIP/DIP? -->
<!-- FIXME: link do qos i transfers -->
<!-- FIXME: ustalić co pisać o przechowywaniu plików archiwów na storydżach, co ze ścieżkami? -->

### Archive actions

An archive item in the browser offers the following context actions:

<!-- FIXME: linki do sekcji o archive details -->
* **Properties** — opening the archive properties tab in the [archive details panel][], which shows the basic info about archive configuration,
* **Edit description** — editing the archive description,
* **Show audit log** — showing the archivisation audit log tab in the [archive details panel][],
* **Copy archive ID** — instantly copying the archive ID into the clipboard,
* **Create incremental archive** — opening the [create archive][] modal with a subject archive selected as a base for the [incremental archive][],
* **Recall to...** — opening the modal for [recalling][] the archive,
* **Download (tar)** — downloading the _tar_ package with the archive contents,
* **Browse DIP** — opening the [DIP][] (Dissemination Information Package) view of the archive files browser (if available),
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

A **regular archive** is a **full copy** of the [dataset][] contents, occupying an additional
storage quota. Storage space can be saved by creating incremental archives, whenever
possible.

An **incremental archive** is created upon the chosen base archive and reuses all files
that haven't been modified between the snapshots, creating hard links to them (which take
no storage space). **Only the modified and new files are copied**.
<!-- FIXME: link do hard links w information panel jak będzie? -->

![screen-archive-incremental][]

### Creating an incremental archive

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
number of hard links typically indicates how many archives share the data.

::: tip NOTE
You can safely delete the **base** archives without loss of data in the later incremental
archives — the data remains until the last hard link of the file is deleted.
:::

## Nested archives

<!-- FIXME: napisać -->

## Symbolic links in archives

<!-- FIXME: napisać -->

## BagIt and DIP

<!-- FIXME: napisać -->

## Recalling archives

<!-- FIXME: napisać -->

## Deleting archives

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

[DIP]: #bagit-and-dip

[log]: #archive-audit-log

[establish a dataset]: ./datasets.md#establishing-datasets

[dataset actions]: ./datasets.md#dataset-actions

[web file browser]: ./web-file-browser.md

[Open Archival Information System]: http://www.oais.info/

[screen-archive-incremental]: ../../images/user-guide/archives/archive-incremental.svg
