# Creating a workflow example

Suppose the following scenario. You want to calculate checksums for selected files in your Space and store them as file metadata.

If you were to do this manually, you would need to download each file, compute its checksum locally, and then attach the result as metadata to the file. This approach quickly becomes impractical for large number of files.

Using Onedata Automation, the same task can be performed more efficiently, in a scalable way, and directly on data stored in Spaces — without downloading files to your local machine.

In this workflow:

* the input will be a list of files,
* if a directory is provided, the workflow will automatically traverse all its children,
* for every regular file, the workflow will compute two checksums: MD5 and SHA-256,
* the computed values will be saved as metadata on the file,
* for directories, no checksum will be computed and no metadata will be set.

# 1. You need to have access to inventory 

You can use one of you already have access to or to create a new one. (...)

# 2. Create Lambda 

Navigate to the **Lambdas** tab in your Inventory.

![screen-lambdas-tab][]

Click the **Add new lambda** button.

![screen-add-new-lambda-button][]

Provide the required lambda configuration:

* **Name**: `calculate-checksum-mounted`  
  A descriptive name indicating that this lambda calculates checksums and uses Oneclient mounting.

* **State**: `Draft`  
  This is a new lambda that has not yet been fully tested.

* **Engine**: `OpenFaaS`  
  This defines the execution environment for the lambda. Currently, OpenFaaS is the only supported engine.

* **Docker Image**: `onedata/lambda-calculate-checksum-mounted:v3`  
  Provide your own Docker image containing the lambda implementation, or use one of the public Onedata lambda images.

* **Read-only**: `No`  
  This lambda modifies files by adding metadata, so it requires write access.

* **Mount Space**: `Yes`  
  This enables access to files through Oneclient, allowing the lambda to operate on files as if they were in a local filesystem.

* **Mount Point**: `/mnt/onedata`  
  This path must match the mount point used in the lambda implementation.

* **Oneclient options**: *not set*  
  No additional Oneclient configuration is required.

* **Preferred batch size**: `10`  
  This defines how many files the lambda processes in a single batch. The default value works well for most cases.

![screen-calc-checksum-lambda][]

### Configuration parameters

Define configuration parameters used by the lambda logic:

* **algorithm**  
  Specifies the checksum algorithm (hash function) used to calculate the checksum.  
  Type: `string` with predefined allowed values.

* **metadataKey**  
  Defines the metadata key under which the checksum will be stored in the file.  
  The lambda will write xattr metadata in the form:  
  `metadataKey : calculatedChecksum`  
  Type: `string` without restricted values.  
  Default value: empty string (`""`).

Both parameters are required.

![screen-configuration-parameters][]

### Arguments

Define the input arguments that the lambda receives:

* **file**  
  The file for which the checksum will be calculated.  
  Type: `File`.

![screen-lambda-arguments][]

Set **File type** to `Any`.

Make sure to include all file attributes required by the lambda using the `carried file attributes`.  
In this example, carry the following attribute:

* `fileId` — required to access the file.

> **Note:** Accessing files using `fileId` is more efficient than using file paths, 
> because of Onedata system specification.

![screen-file-argument-configuration][]

### Results

Define the results returned by the lambda:

* **result**  
  A JSON object containing information about the processed file, such as file ID and calculated checksum.  
  Type: `Object`.

![screen-lambda-results][]

### Resources

Define resources used by the lambda:

* **CPU cores**
  Requested: `0.1`
  Limit: `Unlimited`
* **Memory**:
  Requested: `100 MiB`
  Limit: `Unlimited`
* **Ephemeral storage**:
  Requested: `100 MiB`
  Limit: `Unlimited`

![screen-lambda-resources][]

Finish lambda creation by clicking **Create** button at the bottom of the page.

### Lambda implementation

See a detailed example of a lambda implementation with step-by-step explanations:  
[demo-lambda][demo-lambda-handler].

See the Onedata implementation of the `calculate-checksum-mounted` lambda used in this workflow:  
[calculate-checksum-mounted][calculate-checksum-mounted-lambda-handler].

# 3. Create Workflow

In this example, the workflow has one main processing logic:
read files → compute checksums → save results.

To build it, you will define:

* two Stores,
* one Lane,
* one Parallel Box,
* two Tasks using a checksum lambda.

## Stores

Define a Store that will hold the input items.
Note: the Store ID is generated automatically by the system — you do not specify it.

* Name - input-files. A descriptive name indicating that this Store contains files to process.
* Type - Tree forest. This type allows the workflow to traverse all files inside directories, or process a single file if a regular file is provided.
* Data type - File. We want to process files, not datasets. You could restrict this further to directories only, but in this example allowing regular files works fine.
* Default value - not set. It is impractical to set a default file.
* Needs user input - yes. The user must provide the files or directories when starting the workflow.

![screen-input-files-store][]

Define store holding results.

* Name - results.
* Type - List. This type stores an ordered list of items — suitable for collecting 
one result per file.
* Data type - Object. Each entry will be a JSON object containing fileId, 
calculated checksum, checksum algorithm used.
* Default value - not set. No results exist before workflow execution.
* Needs user input - no. The workflow will produce these values.

![screen-results-store][]

## Lane

* Name - calculate-checksums
* Max. retries - 1. Repeat lane execution max once if failed.
* Instant failure exception threshold - 0,1. Raise instant failure if ration of exceptions exceed all already processed items. 
* Source store - input-files. Items from that store will be propagated to tasks.
* Max. batch size - 4. Max number of items in the batch.

![screen-lane][]

## Parallel box

Add parallel box by simply clicking on plus button in the lane.

![screen-add-parallel-box][]

## Task

Create a task responsible for calculating the checksum using the **md5** algorithm.

Add a new task by clicking the plus button inside the Parallel Box.

![screen-add-task][]

Select the lambda created in step 2: `calculate-checksum-mounted`.

![screen-task-choose-lambda][]

Provide the required task configuration.

### Used Lambda & Task Details


* **Name** – automatically derived from the selected lambda.
* **Revision** – select the lambda revision to use.


* **ID** – automatically generated unique identifier for the task.
* **Name**: `md5`  
  Set a clear and descriptive name indicating that this task calculates the md5 checksum.

![screen-task-details][]

### Configuration parameters

* **algorithm**  
  Value builder: `Custom value`  
  Value: `md5`  
  This selects the md5 algorithm from the predefined checksum algorithms.

* **metadataKey**  
  Value builder: `Custom value`  
  Value: `md5_checksum`  
  This defines the metadata key under which the calculated checksum will be stored in the file.

![screen-task-configuration-parameters][]


### Arguments

Define how the lambda receives its input:

- **file**  
  Value builder: `Iterated item`  

This means the task will process each file provided by the Lane source Store.

![screen-task-arguments][]


### Results

Define where the lambda results will be stored:

- **result**  
  - Target Store: `results`  
  - Dispatch function: `Append`  

This configuration stores the result of each processed file as a separate entry in the `results` Store.

![screen-task-results][]


### Resources

Do not override the resource settings defined in the lambda.
The default resource configuration is sufficient for this task.

![screen-task-resources][]

Finish task creation by clicking **Create** button.

---

## Create second task for SHA-256

Create another task in the same Parallel Box to calculate the **sha-256** checksum.
Click the plus button below the created `md5` task.

![screen-task-in-parallel-box][]

Configure this task in the same way as the `md5` task, with the following changes:

- **Name**: `sha256`
- **algorithm**: `sha256`
- **metadataKey**: `sha256_checksum`

This allows both checksum algorithms to run in parallel for each file.

---

## Final workflow structure

After completing the configuration, the workflow should look like this:

![screen-ready-workflow][]

# Workflow execution

Navigate to the **Automation, Workflows** tab in the selected Space.

Click the **Run workflow** button in the upper-right corner.

![screen-automation-tab][]

Select the previously created `calculate-checksums-mounted` workflow.

![screen-choose-workflow][]

Provide the initial workflow configuration:

* **input-files** – select the files to process,
* **Logging level** – set to `info` to collect standard execution logs.

Add files by clicking **Add files...** in the lower-left corner.  
You can select files using the file browser or provide their file IDs manually.

Once the input files are selected, click **Run workflow**.

![screen-run-workflow][]


## Inspect workflow execution

After the workflow finishes, you can review the execution details:

- check the contents of Stores,
- inspect individual task executions,
- review the workflow audit log.

![screen-finished-workflow][]


## Verify checksum metadata

Finally, open one of the processed files and check its metadata.

You should see new metadata entries containing the calculated checksums, such as:

- `md5_checksum`,
- `sha256_checksum`.

![screen-file-checksum-metadata][]


<!-- references -->

<!-- lambda -->
[screen-lambdas-tab]: ../../images/user-guide/workflow/lambdas_tab_inventory.png

[screen-add-new-lambda-button]: ../../images/user-guide/workflow/add_new_lambda_button.png

[screen-calc-checksum-lambda]: ../../images/user-guide/workflow/calc_checksums_lambda_conf.png

[screen-configuration-parameters]: ../../images/user-guide/workflow/lambda_configuration_parameters.png

[screen-lambda-arguments]: ../../images/user-guide/workflow/lambda_arguments.png

[screen-file-argument-configuration]: ../../images/user-guide/workflow/file_argument_configuration.png

[screen-lambda-results]: ../../images/user-guide/workflow/lambda_results.png

[screen-lambda-resources]: ../../images/user-guide/workflow/lambda_resources.png


<!-- workflow -->
[screen-lane-creation]: ../../images/user-guide/workflow/inventory.png

[screen-lane-creation]: ../../images/user-guide/workflow/create_new_inventory.png

[screen-input-files-store]: ../../images/user-guide/workflow/input_files_store.png

[screen-results-store]: ../../images/user-guide/workflow/results_store.png

[screen-lane]: ../../images/user-guide/workflow/lane_calc_checksum.png

[screen-add-parallel-box]: ../../images/user-guide/workflow/add_parallel_box.png

[screen-add-task]: ../../images/user-guide/workflow/add_task.png

[screen-task-choose-lambda]: ../../images/user-guide/workflow/task_choose_lambda.png

[screen-task-details]: ../../images/user-guide/workflow/create_task_details.png

[screen-task-configuration-parameters]: ../../images/user-guide/workflow/task_configuration_parameters.png

[screen-task-arguments]: ../../images/user-guide/workflow/task_arguments.png

[screen-task-results]: ../../images/user-guide/workflow/task_results.png

[screen-task-resources]: ../../images/user-guide/workflow/task_resources.png

[screen-task-in-parallel-box]: ../../images/user-guide/workflow/task_in_parallel_box.png

[screen-ready-workflow]: ../../images/user-guide/workflow/workflow_in_gui_editor.png


<!-- workflow execution-->

[screen-automation-tab]: ../../images/user-guide/workflow/automation_workflows_tab.png

[screen-choose-workflow]: ../../images/user-guide/workflow/choose_workflow.png

[screen-run-workflow]: ../../images/user-guide/workflow/run_workflow_view.png

[screen-finished-workflow]: ../../images/user-guide/workflow/finished_workflow_view.png

[screen-file-checksum-metadata]: ../../images/user-guide/workflow/file_checksum_metadata.png

<!-- links -->
[demo-lambda-handler]: https://github.com/onedata/automation-examples/blob/develop/lambdas/demo/docker/handler.py

[calculate-checksum-mounted-lambda-handler]: https://github.com/onedata/automation-examples/blob/develop/lambdas/calculate-checksum-mounted/docker/handler.py