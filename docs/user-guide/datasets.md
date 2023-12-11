# Datasets

[toc][]
<!-- FIXME: zrobić ticket i podlinkować do napisania doksów nowej wersji widoku -->

## Overview

Datasets are essentially files or directories that have been marked by space users as
representing data collections relevant to them. They can be used to organize data in
a space in a systematic way.

Datasets offer additional features, compared to regular files and directories:
- optional data and metadata write [protection][],
- [dataset structure][hierarchy] tracking using the [dataset browser][Datasets, Archives tab],
- ability to [create persistent snapshots][create archive] of the physical dataset contents —
  [archives][].

Datasets can be nested, allowing users to compose arbitrary [hierarchical][hierarchy] structures.

![dataset-hierarchy][]

The diagram above shows the filesystem tree, where some of the directories are marked as datasets (_Experiment A_ and _Results_). Regular files also can be marked as datasets (_Statistics.csv_). The file or directory is marked as a dataset by [establishing][establishing datasets] the datasets on it.

## Establishing datasets
<!-- FIXME: w archives mam wypunktowanie -->
To establish a dataset, navigate to the [file browser][], open the context for a file or directory, and choose **Datasets**.

<!-- FIXME: screeny powinny być z odpowiedniej wielkości ekranu i zooma - teraz są robocze -->

![screen-file-menu-datasets][]

You will see a right-side dataset panel for the selected file or directory.

![screen-panel-establish-dataset][]

In this example, the selected directory has no dataset established. Click on the **Establish dataset** button in the center of the panel to create a dataset.

<!-- FIXME: ten screen można ograniczyć do "This directory is a dataset..." -->
The panel should now present a summary of the dataset established on the selected directory.
<!-- FIXME: screen powinien zawierać dolny przycisk -->
![screen-datasets-panel][]

## File browser datasets panel

The datasets panel for a file or directory presents information about the dataset established on the file or directory and its optional dataset ancestors. The view consists of:
<!-- FIXME: screen z podziałem na 1,2,3,4? -->

* **Settings** tab — containing [dataset actions][], dataset [hierarchy][] table with write [protection][] configuration,
* **Archives** tab — containing dataset snapshots ([archives][]) browser,
* **write protection badges** in the header — showing the effective write [protection][] of the selected file or directory,
* **Show in dataset browser** button in the footer — navigating to space's [Datasets, Archives tab][], focusing on the selected dataset.

### Dataset actions
<!-- FIXME: tutaj dałbym większy screen z zaznaczeniem tej opcji -->
You can perform various actions on the established dataset:

![screen-dataset-actions][]
<!-- FIXME: linki dać na samych akcjach -->
* **Copy ID** — copy the dataset ID into the clipboard,
* **Create archive** — [create snapshot][create archive] of the dataset (an [archive][archives]),
* **Detach** — set dataset to [detached][detaching datasets] state,
* **Remove** — [remove][removing datasets] the dataset feature from the file or directory.

If the dataset is already in the [detached][detaching datasets] state, the **Detach** action becomes a **Re-attach** action which will change the dataset's state to **attached**.

### Dataset hierarchy table

<!-- FIXME: ładny screen, na którym jest pokazana większa hierarchia i zmienione ustawienia protekcji; można pociąć ten screen -->

The dataset hierarchy table shows a list of the ancestor directories having datasets established (and not [detached][detaching datasets]). The first row of the table shows a summary of the ancestor datasets — you can click on it to show or hide the list. If there are any ancestors, the **Data/Metadata write protection** columns for the first row, show effective [protection][] status inherited from the ancestors.

Rows for the ancestors contain links to the directories with datasets established and allow configuring the protection of each. The last row of the table shows information about the dataset established on the current file or directory and allows configuring the direct protection of the datasets.

Note, that the file or directory **effective** protection is presented using the badges at the right side of the panel header — it is a derivate from both the ancestor protection and direct protection.

### Archives tab

<!-- FIXME: screen taba i widoku -->
<!-- FIXME: link do dokumentacji -->

The archives tab label displays the current number of snapshots created from the selected dataset. Inside the tab, you will find an [archives list][] for the dataset — explained in detail in the archives tab documentation.

## Datasets hierarchy

<!-- FIXME: datasety tworzą hierarchię - wystarczy wejść do środka i na pliku lub katalogu otworzyć panel datasetów i dać establish; wtedy w tabeli mamy dodatkowe rzeczy w hierarchii -->

<!-- FIXME: link do nested archives -->

Datasets can be established on files or directories lying inside other datasets. This way,
a **hierarchy** of datasets can be built and then embraced to create **nested archives**.

<!-- FIXME: diagram, na którym pokazujemy z lewej strony drzewo datasetów a po prawej kawałek screena z widoku hierarchii; na górze mogą być nagłówki "tabeli" - filesystem tree | dataset tree -->

You can simply establish a dataset on a file or directory inside the other dataset using the datasets panel in the web file browser. Before establishment, the panel will show the existing hierarchy of the ancestor datasets. The **Establish** button is placed above the ancestor table.

<!-- FIXME: screen pokazujący panel przed establishnięciem -->


## Data and metadata write protection

The lifecycle of a dataset can look like the following:
- acquisition — creating and collecting,
- consolidation and aggregation,
- processing/analysis,
- annotation,
- publishing/sharing,
- archiving.

Quite often, there is a need to apply certain procedures at different stages of data
curation. For example, at the annotation stage, the dataset managers may wish to freeze
its contents from further modifications. Similarly, at the publishing stage, the authors
may wish to disable further changes to the annotated metadata — especially if the dataset
has been assigned a persistent identifier and referenced in scientific works.

To prevent changes in the dataset, users can set temporary **protection** flags, which
cause the files and directories in the dataset to be protected from, accordingly:
<!-- FIXME: napisać szczegółowo? -->
- **Data protection** — modifying their content or being deleted,
- **Metadata protection** — modifying their metadata, such as custom JSON/RDF/xattr
  metadata, permissions, or ACLs.

The protection flags are inherited by children datasets — datasets lower in the [hierarchy][]
tree have protection at least as strong as their ancestors.

You can modify protection flags in the [dataset hierarchy table][] of the file or directory datasets panel. When the file or directory has the protection enabled, the **Datasets** badge for the file has additional icons representing the applied protection.

<!-- FIXME: screen z badge'a -->

<!-- FIXME: jak będzie dokumentacja nowego widoku datasets, archives to napisać, że tam można też otwierać panel zmian protekcji -->

## Creating snapshots — archives

A snapshot of a dataset created at a certain point in time is called an [archive][archives].

Archives are immutable and stored within a space, lying in a special directory detached
from the regular file tree. They can be accessed using the specialized browser of
datasets and archives.

You can create archives using the **Create archive** [action][dataset actions] or in the archives tab of the [file browser datasets panel][].

<!-- FIXME: link do opisu archives view -->

<!-- FIXME: wrzucić 2 małe screeny z datasets panel action i archives tab -->

## Space "Datasets, Archives" tab

🚧 Under construction 🚧

## Detaching datasets

Datasets that are no longer needed (from the space data PoV) can be **detached**. A
detached dataset is decoupled from its root file/directory and serves only archival
purposes. **All the archives created from the dataset are retained.** The dataset does not
correspond to any physical content in the space file tree, but it shows up in the dataset
browser.

The dataset is also automatically detached when the corresponding file or directory is
deleted.

If the original file/directory is not deleted, the dataset can be later **re-attached**.
This can be done using the **Re-attach** action in the [dataset actions][].

<!-- FIXME: screen akcji re-attachowania -->

<!-- FIXME: napisać o re-attachowaniu z poziomu Datasets, Archives -->

## Removing datasets

Removing a dataset is essentially disabling the dataset-related features for a file or
directory, leaving the data untouched. The dataset also disappears from the [dataset
tree][hierarchy].

While detaching a dataset is not a harmful operation from the archive's perspective,
deleting the entire dataset is, so **the dataset cannot be removed until it has any
archives**.

<!-- FIXME: screen z "remove not available" -->

<!-- FIXME: dopisać: Deleting archives of the dataset is described here. -->

You can remove a dataset without an archive, using the **Remove** action in the [dataset
actions][].

<!-- FIXME: screen z akcją remove -->

<!-- FIXME: dodatkowa sekcja: uprawnienia -->

<!-- references -->

[toc]: <>

[establishing datasets]: #establishing-datasets

[protection]: #data-and-metadata-write-protection

[hierarchy]: #datasets-hierarchy

[dataset actions]: #dataset-actions

[detaching datasets]: #detaching-datasets

[removing datasets]: #removing-datasets

[Datasets, Archives tab]: #space-datasets-archives-tab

[create archive]: #creating-snapshots--archives

[dataset hierarchy table]: #dataset-hierarchy-table

[file browser datasets panel]: #file-browser-datasets-panel

[file browser]: web-file-browser.md

[archives]: archives.md

[archives list]: archives.md#browsing-archives

[dataset-hierarchy]: ../../images/user-guide/datasets/dataset-hierarchy.svg

[screen-panel-establish-dataset]: ../../images/user-guide/datasets/panel-establish-dataset.png

[screen-file-menu-datasets]: ../../images/user-guide/datasets/file-menu-datasets.png

[screen-datasets-panel]: ../../images/user-guide/datasets/datasets-panel.png

[screen-dataset-actions]: ../../images/user-guide/datasets/dataset-actions.png
