# Quality of Service

## 🚧 Under construction! 🚧

This section is still a work-in-progress and may have errors or missing information.  

[toc][1]

Quality of Service (QoS) is used to manage file [replica distribution][] and redundancy
between [providers][] supporting a [space][].

This guide is dedicated to non-admin users who would like to utilize QoS to manage
the distribution of their data. Consider reading the [counterpart documentation for admins][admin-qos]
for information on the proper configuration of the Oneprovider service regarding QoS.

## Basics

QoS mechanisms are based on the continuous processing of [QoS requirements][].
A requirement is essentially a rule defining the desired data redundancy (replica count)
and how to determine the placement of replicas ([QoS expression][]).

Each file or directory can have any number of requirements — in the case of directories, the requirement
is applied to all its files and subdirectories, recursively.

If required, data transfers are automatically triggered to satisfy the QoS requirements — remote
changes made to file content are automatically reconciled. File replicas corresponding to
QoS requirements are protected from eviction.

Removing a QoS requirement does not automatically remove the replicas that were created during its
lifetime, but they are no longer protected.

## QoS expression

QoS expressions are a declarative way of specifying desired storage parameters in a unified format.
They are used to determine the replica placement — the target storage backends where the replicas
of the data will be stored. The expressions refer to storage backend parameters that are assigned
by Oneprovider admins.

An expression is a set of one or more operands, each referring to one storage backend's parameter.
An operand is in form `key {comparator} value`, where `{comparator}` is one of `<, >, <=, >=, =`,
e.g. `key = value`. One exception from this is the single-worded, built-in operand `anyStorage`.
If any comparator other than `=` is used, only numeric values are allowed.

Operands are processed left-to-right and can be combined:

* `&` — expression matches if both operands match,
* `|` — expression matches if any of the two operands matches,
* `\ ` — expression matches if the left-hand side operand matches and the right-hand side operand does not.

Example QoS expressions:

* `geo=PL` — storage backends in Poland,
* `timeout < 8` — storage backends with timeout parameter set to less than 8,
* `timeout = 8` — storage backends with timeout parameter set to exactly 8,
* `geo=PL & type=disk` — storage backends of disk type in Poland,
* `geo=PL | type=disk` — storage backends in Poland or storage backends of disk type anywhere,
* `anyStorage \ type=disk` — storage backends that are not of the disk type.

Use parentheses to group operands that should be evaluated together, e.g.:

* `geo=FR | (geo=PL & type=disk)` — storage backends in France or storage backends of disk type in Poland,
* `(geo=PL \ type=disk) | (geo=FR & type=disk)` — storage backends in Poland that are not of disk type or
  storage backends in France that are of disk type.

## QoS requirement

A QoS requirement consists of a [QoS expression][] and the target replica count.
Storage backends matching the expression are selected for data replication in a continuous re-evaluation
process until the target replica count is satisfied. If there are more matching backends than
the target replica count, a random subset is selected.

The replicas originating from the evaluation of QoS requirements are automatically managed —
protected from eviction and reconciled upon changes to the file content.

Fulfillment of a QoS requirement is indicated by its **status**:

* `fulfilled` — the target replica count has been created on the matching storage backends
  and their contents are up-to-date (remote changes have been reconciled).
* `pending` — the requirement is not yet fulfilled — data replication is still ongoing.
* `impossible` — there are not enough storage backends matching the expression to meet the target
  replica count, hence the requirement cannot be satisfied — unless the list of supporting storage backends
  or their parameters change.

## Web GUI guide

To manage QoS requirements, choose the **Quality of Service** action from the file/directory's
context menu in the [file browser][].

![screen-qos-in-context-menu][]

The requirements can be put down using a visual block-based expression editor. These
requirements are evaluated against the assigned to different supporting
[storage backends][] to determine where the replicas should be stored.

![screen-feature-qos-visual][]

Below the requirement, there is information about which storage backends match the requirement
and an action that copies the expression in textual form, to be reused when
creating a new requirement or using the [REST API][using-rest-api].

![screen-feature-qos-visual-match][]

Expressions can be entered in the textual form. They are converted to block form
upon confirmation and then can be further edited.

![screen-feature-qos-text][]

If the selected files have any QoS requirements defined, they are displayed on
the list along with their status of fulfillment, matching storage backends and other
information. It is possible to remove selected QoS requirements unless they
are inherited from any parent directory.

![screen-feature-qos-requirements][]

After expanding the row for a requirement, you can examine its status, transfer statistics,
and audit log.

![screen-qos-fulfilled][]

In the charts, you can see the total number of files and the number of bytes that were
transferred in order to fulfill the requirement.

::: warning NOTE
The QoS charts and audit logs are presented as seen from the point of view of the
[currently selected provider][7].
:::

#### INBOUND chart

* `Files` represent the number of regular files that were processed to fulfill the QoS requirement.
  If a single file is transferred multiple times (e.g. when the file content changes multiple times on
  a remote provider), each of these transfers contributes towards this counter.
  Empty files also increase the counter.
* `Bytes` represent the number of bytes that have been written to the local storage backends to fulfill the QoS requirement.

#### OUTBOUND chart

* `Bytes` represent the number of bytes that have been transferred **from** remote storage backends.
  The sum of these values is equal to the `Bytes` value shown in the `INBOUND` chart.

## Using REST API

You can interact with the QoS using the [REST API][].
Below are some links to the REST API documentation of commonly used operations:

<!-- @TODO VFS-6428 Add examples of retrieving storage QoS parameters -->

| Operation                   | Link to the API docs           |
| --------------------------- | ------------------------------ |
| Add new QoS requirement     | [API][add-qos-requirement]     |
| Get QoS requirement details | [API][get-qos-requirement]     |
| Remove QoS requirement      | [API][remove-qos-requirement]  |
| Get QoS summary for a file  | [API][get-qos-summary]         |
| Evaluate QoS expression     | [API][evaluate-qos-expression] |
| Get QoS audit log           | [API][get-qos-audit-log]       |

<!-- references -->

[1]: <>

[replica distribution]: ./data-distribution.md

[providers]: ./providers.md

[space]: ./spaces.md

[admin-qos]: ../admin-guide/oneprovider/configuration/qos.md

[QoS requirements]: #qos-requirement

[QoS expression]: #qos-expression

[using-rest-api]: #using-rest-api

[REST API]: ./rest-api.md

[add-qos-requirement]: https://onedata.org/#/home/api/stable/oneprovider?anchor=operation/add_qos_requirement

[get-qos-requirement]: https://onedata.org/#/home/api/stable/oneprovider?anchor=operation/get_qos_requirement

[remove-qos-requirement]: https://onedata.org/#/home/api/stable/oneprovider?anchor=operation/remove_qos_requirement

[get-qos-audit-log]: https://onedata.org/#/home/api/stable/oneprovider?anchor=operation/get_qos_requirement_audit_log

[get-qos-summary]: https://onedata.org/#/home/api/stable/oneprovider?anchor=operation/get_file_qos_summary

[evaluate-qos-expression]: https://onedata.org/#/home/api/stable/oneprovider?anchor=operation/evaluate_qos_expression

[file browser]: web-file-browser.md#qos

[storage backends]: ../admin-guide/oneprovider/configuration/storages.md

[7]: web-file-browser.md#switching-between-providers

[screen-qos-in-context-menu]: ../../images/user-guide/qos/context_menu.png

[screen-feature-qos-visual]: ../../images/user-guide/qos/feature-qos-visual.png

[screen-feature-qos-visual-match]: ../../images/user-guide/qos/feature-qos-visual-match.png

[screen-feature-qos-text]: ../../images/user-guide/qos/feature-qos-text.png

[screen-feature-qos-requirements]: ../../images/user-guide/qos/feature-qos-requirements.png

[screen-qos-fulfilled]: ../../images/user-guide/qos/modal_fulfilled.png
