# Creating a Lambda in the GUI: File Checksum Example

This guide shows how to register a lambda that calculates a file checksum and optionally
saves it as file metadata. You will define its configuration parameters, input, and result
using an existing Docker image.

You need access to an [automation inventory][inventory]. If you do not have one, follow
the [inventory access instructions][inventory-access] first.

## 1. Add a lambda

Open the **Lambdas** tab in your inventory and click **Add new lambda**.

![Lambdas tab in an inventory][screen-lambdas-tab]

Provide the basic configuration:

* **Name**: `calculate-checksum-mounted`.
* **Docker image**: `onedata/lambda-calculate-checksum-mounted:v3`.
* **Read-only**: `No`, so the lambda can write checksum metadata.
* **Mount space**: enabled, so the lambda can access files through Oneclient.
* **Mount point**: keep the default `/mnt/onedata`.

![Checksum lambda configuration][screen-calc-checksum-lambda]

The Docker image contains the code that processes files. The following settings define
the interface through which workflow tasks configure and call that code.

## 2. Define configuration parameters

Use **Add parameter** to define two required parameters:

* **algorithm**: type `String`, with allowed values `md5` and `sha256`.
  This selects the checksum algorithm.
* **metadataKey**: type `String`, with unrestricted values and an empty string (`""`) as
  the default. This is the extended attribute name under which the checksum is saved.
  An empty value means the checksum is only returned, without writing metadata.

![Lambda configuration parameters][screen-configuration-parameters]

These values are set when configuring a workflow task that uses the lambda.

## 3. Define the file argument

Click **Add argument** and create an argument named `file` with type **File**.

![Lambda file argument][screen-lambda-arguments]

In the additional settings for the **File** type, select:

* **File type**: `Any`;
* **Carried file attributes**: `fileId`.

![File argument settings][screen-file-argument-configuration]

The carried attributes specify which file information is passed to the handler. This
lambda needs `fileId` to access the file through Oneclient. It accepts directories too,
but returns `null` as their checksum without writing metadata.

## 4. Define the results

Click **Add result** and create a result named `result` with type **Object**.

![Lambda result settings][screen-lambda-results]

The handler returns an object containing the file ID, selected algorithm, and checksum.
The workflow task decides where to store this result.

The image also streams processing statistics through a second result named `stats`,
as defined in the [v3 lambda schema][checksum-schema]. Click **Add result** again and
configure:

* **Name**: `stats`.
* **Data type**: `Time series measurement`.
* **Via file**: enabled.

For the measurement specifications, allow these exact names:

* `filesProcessed`: no unit.
* `bytesProcessed`: unit `Bytes`.

Declare this result even if the workflow does not store the statistics.

## 5. Save the lambda

Leave the default resource settings and click **Create** at the bottom of the page.

![Lambda resource settings][screen-lambda-resources]

The lambda is now available for use in workflow tasks in this inventory.

## Next steps

Continue with [Creating a Workflow][creating-workflow] to calculate MD5 and SHA-256
checksums using this lambda. To see how the handler works, read the
[checksum lambda implementation][checksum-handler].

<!-- references -->

[inventory]: ./automation.md#inventory

[inventory-access]: ./creating-workflow-guide.md#inventory-access

[creating-workflow]: ./creating-workflow-guide.md#creating-a-workflow

[checksum-handler]: https://github.com/onedata/automation-examples/blob/466a696b020db3d5bbbf3f37ae0f63af215a6690/lambdas/calculate-checksum-mounted/docker/handler.py

[checksum-schema]: https://github.com/onedata/automation-examples/blob/466a696b020db3d5bbbf3f37ae0f63af215a6690/lambdas/calculate-checksum-mounted/calculate-checksum-mounted.json

[screen-lambdas-tab]: ../../images/user-guide/creating-workflow-guide/lambdas_tab_inventory.png

[screen-calc-checksum-lambda]: ../../images/user-guide/creating-workflow-guide/calc_checksums_lambda_conf.png

[screen-configuration-parameters]: ../../images/user-guide/creating-workflow-guide/lambda_configuration_parameters.png

[screen-lambda-arguments]: ../../images/user-guide/creating-workflow-guide/lambda_arguments.png

[screen-file-argument-configuration]: ../../images/user-guide/creating-workflow-guide/file_argument_configuration.png

[screen-lambda-results]: ../../images/user-guide/creating-workflow-guide/lambda_results.png

[screen-lambda-resources]: ../../images/user-guide/creating-workflow-guide/lambda_resources.png
