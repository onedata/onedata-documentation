# Creating a Workflow in the GUI: File Checksum Example

Consider the following scenario: You want to calculate checksums for selected
files in your Space and store them as file metadata.

If you were to do this manually, you would need to download each file,
compute its checksum locally, and then attach the result as metadata to the file.
This approach quickly becomes impractical when dealing with a large number
of files.

However, by using Onedata Automation, the same task can be performed more efficiently,
in a scalable way, and directly on data stored in Spaces — without
downloading files to your local machine.

In this workflow:

* the input will be a list of files,
* if a directory is provided, the workflow will automatically traverse all its children,
* for every regular file, the workflow will compute two checksums: MD5 and SHA-256,
* the computed values will be saved as metadata on the file,
* for directories, no checksum will be computed and no metadata will be set.

## Prerequisites

### Inventory access

You can use an [inventory][] you already have access to or create a new one.

If you are a new user and do not have access to any inventory, you can
obtain access by:

* creating a new inventory,
* joining an existing inventory using an invitation token,
* joining a group inventory using an invitation token.

![screen-no-inventories][]

If you don’t have an existing inventory, create one by
clicking **Create an automation inventory**. Enter a name for the inventory
and click **Create**.

![screen-new-inventory][]

### Checksum lambda

Before creating the workflow, follow [Creating a Lambda in the GUI][creating-lambda-gui]
to add `calculate-checksum-mounted` to your inventory.

## Creating a Workflow

In this example, the workflow has one main processing logic:
read files → compute checksums → save results.

To build it, you will define:

* two [Stores][store],
* one [Lane][],
* one [Parallel Box][parallel-box],
* two [Tasks][] using a checksum lambda.

### Create a new workflow

In the same inventory where you created the lambda, open the **Workflows** tab and
click **Add new workflow**.

![screen-add-new-workflow][]

Enter the workflow name `calculate-checksums-mounted` and click **Create**.

![screen-create-new-workflow][]

### Defining Stores

To create a store, click the **Add store** button in the bottom-left corner.

![screen-add-store][]

Then provide the required store details and click **Create**.

Define a Store that will hold the input items.

::: tip NOTE
The Store ID is generated automatically by the system — you do not specify it.
:::

* **Name**: `input-files`. A descriptive name indicating that this Store contains files to process.
* **Type**: `Tree forest`. This type allows the workflow to traverse all files inside directories, or process a single file if a regular file is provided.
* **Data type**: `File`. We want to process files, not datasets. You could restrict this further to directories only, but in this example allowing regular files works fine.
* **Default value**: `not set`. The user should provide the input files rather than use defaults.
* **Needs user input**: `yes`. The user must provide the files or directories when starting the workflow.

![screen-input-files-store][]

Define store holding results.

* **Name**: `results`.
* **Type**: `List`. This type stores an ordered list of items — suitable for collecting
  one result per file and checksum algorithm.
* **Data type**: `Object`. Each entry will be a JSON object containing fileId,
  calculated checksum, checksum algorithm used.
* **Default value**: `not set`. No results exist before workflow execution.
* **Needs user input**: `no`. The workflow will produce these values.

![screen-results-store][]

### Defining a Lane

Add a new lane by clicking on the plus button in the display.

* **Name**: `calculate-checksums`.
* **Max. retries**: `1`. Repeat lane execution max once if failed.
* **Instant failure exception threshold**: `0,1`. Raise instant failure if ration of exceptions exceed all already processed items.
* **Source store**: `input-files`. Items from that store will be propagated to tasks.
* **Max. batch size**: `4`. Max number of items in the batch.

![screen-lane][]

### Defining a Parallel box

Add parallel box by clicking on plus button in the lane.

![screen-add-parallel-box][]

### Defining a Task

Create a task responsible for calculating the checksum using the **md5** algorithm.

Add a new task by clicking the plus button inside the Parallel Box.

![screen-add-task][]

Select the lambda created in the GUI guide: `calculate-checksum-mounted`.

![screen-task-choose-lambda][]

Provide the required task configuration.

#### Used Lambda & Task Details

* **Name** – automatically derived from the selected lambda.
* **Revision** – select the lambda revision to use.
* **ID** – automatically generated unique identifier for the task.
* **Name**: `md5`
  Set a clear and descriptive name indicating that this task calculates the md5 checksum.

![screen-task-details][]

#### Configuration parameters

* **algorithm**
  * Value builder: `Custom value`,
  * Value: `md5`.

This selects the md5 algorithm from the predefined checksum algorithms.

* **metadataKey**
  * Value builder: `Custom value`,
  * Value: `md5_checksum`.

This defines the metadata key under which the calculated checksum will be stored in the file.

![screen-task-configuration-parameters][]

#### Arguments

Define how the lambda receives its input:

* **file**
  Value builder: `Iterated item`.

This means the task will process each file provided by the Lane source Store.

![screen-task-arguments][]

#### Results

Add a mapping for results by clicking the **Add mapping** button.

Define where the lambda results will be stored:

* **result**
  * Target Store: `results`,
  * Dispatch function: `Append`.

This configuration stores the result of each processed file as a separate entry in the `results` Store.

Leave the `stats` result without a Store mapping; this example only stores checksum reports.

![screen-task-results][]

#### Resources

Do not override the resource settings defined in the lambda.
The default resource configuration is sufficient for this task.

![screen-task-resources][]

Finish task creation by clicking **Create** button.

***

### Create second task for SHA-256

Create another task in the same Parallel Box to calculate the **sha-256** checksum.
Click the plus button below the created `md5` task.

![screen-task-in-parallel-box][]

Configure this task in the same way as the `md5` task, with the following changes:

* **Name**: `sha256`
* **algorithm**: `sha256`
* **metadataKey**: `sha256_checksum`

This allows both checksum algorithms to run in parallel for each file.

***

### Final workflow structure

Save your changes by clicking **Save** in the upper-right corner.

![screen-save-workflow][]

After completing the configuration, the workflow should look like this:

![screen-ready-workflow][]

***

## Workflow execution

Navigate to the **Automation Workflows** tab in the selected Space.

Click the **Run workflow** button in the upper-right corner.

![screen-automation-tab][]

Select the previously created `calculate-checksums-mounted` workflow.

![screen-choose-workflow][]

Provide the initial workflow configuration:

* **input-files**: select the files to process,
* **Logging level**: set to `info` to collect standard execution logs.

To add files, click on **Add files...** located in the lower-left corner.
You can either use the file browser to select files or enter file IDs manually.

Once the input files are selected, click **Run workflow**.

![screen-run-workflow][]

### Inspect workflow execution

After the workflow finishes, you can review the execution details:

* check the contents of Stores,
* inspect individual task executions,
* review the workflow Audit log.

![screen-finished-workflow][]

### Verify checksum metadata

Finally, open one of the processed files and check its metadata.

You should see new metadata entries containing the calculated checksums, such as:

* `md5_checksum`,
* `sha256_checksum`.

![screen-file-checksum-metadata][]

<!-- references -->

[inventory]: ./automation.md#inventory

[store]: ./automation.md#store

[lane]: ./automation.md#lane

[tasks]: ./automation.md#task

[parallel-box]: ./automation.md#parallel-box

[creating-lambda-gui]: ./creating-lambda-guide-gui.md

<!-- workflow -->

[screen-input-files-store]: ../../images/user-guide/creating-workflow-guide/input_files_store.png

[screen-results-store]: ../../images/user-guide/creating-workflow-guide/results_store.png

[screen-lane]: ../../images/user-guide/creating-workflow-guide/lane_calc_checksum.png

[screen-add-parallel-box]: ../../images/user-guide/creating-workflow-guide/add_parallel_box.png

[screen-add-task]: ../../images/user-guide/creating-workflow-guide/add_task.png

[screen-task-choose-lambda]: ../../images/user-guide/creating-workflow-guide/task_choose_lambda.png

[screen-task-details]: ../../images/user-guide/creating-workflow-guide/create_task_details.png

[screen-task-configuration-parameters]: ../../images/user-guide/creating-workflow-guide/task_configuration_parameters.png

[screen-task-arguments]: ../../images/user-guide/creating-workflow-guide/task_arguments.png

[screen-task-results]: ../../images/user-guide/creating-workflow-guide/task_results.png

[screen-task-resources]: ../../images/user-guide/creating-workflow-guide/task_resources.png

[screen-task-in-parallel-box]: ../../images/user-guide/creating-workflow-guide/task_in_parallel_box.png

[screen-ready-workflow]: ../../images/user-guide/creating-workflow-guide/workflow_in_gui_editor.png

[screen-save-workflow]: ../../images/user-guide/creating-workflow-guide/workflow_save.png

[screen-no-inventories]: ../../images/user-guide/creating-workflow-guide/no_inventories.png

[screen-add-store]: ../../images/user-guide/creating-workflow-guide/add_store.png

[screen-add-new-workflow]: ../../images/user-guide/creating-workflow-guide/add_new_workflow.png

[screen-create-new-workflow]: ../../images/user-guide/creating-workflow-guide/create_new_workflow.png

[screen-new-inventory]: ../../images/user-guide/creating-workflow-guide/new_inventory.png

<!-- workflow execution-->

[screen-automation-tab]: ../../images/user-guide/creating-workflow-guide/automation_workflows_tab.png

[screen-choose-workflow]: ../../images/user-guide/creating-workflow-guide/choose_workflow.png

[screen-run-workflow]: ../../images/user-guide/creating-workflow-guide/run_workflow_view.png

[screen-finished-workflow]: ../../images/user-guide/creating-workflow-guide/finished_workflow_view.png

[screen-file-checksum-metadata]: ../../images/user-guide/creating-workflow-guide/file_checksum_metadata.png
