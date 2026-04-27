# Automation

Automation in Onedata provides a built-in mechanism for defining and 
executing data workflows directly on data accessible through Spaces. 
It supports creating custom data processing pipelines and provides facilities for 
monitoring execution, collecting results, and inspecting execution history.

## Main concepts

### Inventory

An inventory is a logical container for storing workflow schemas and lambda schemas. 
Similarly to Spaces, it allows users to collaborate on shared resources and 
manage access rights.

### Workflow

A **workflow** definition describes what should be done.
It is created using the graphical user interface (GUI) and
is represented as JSON files. Each workflow can have multiple revisions, 
which are different versions of the same workflow managed by its author.

Workflow definitions can be edited via the GUI, either by creating a new
revision or by modifying an existing one. Directly editing the underlying
JSON file is possible but strongly discouraged, as it may lead to workflow
corruption.

Creating new revisions for changes is recommended, as it helps to preserve 
backward compatibility and makes workflow evolution easier to manage. 
Changes to a workflow definition do not affect already running or completed 
workflow executions.

### Lambda

A **lambda** represents a single operation that can be used in a workflow, 
such as processing files, running an analysis, or transforming data. It 
serves as a reusable “building block” that performs one specific task. 
When creating a workflow, users select lambdas to define what should happen 
to their data at each step.

When a workflow is executed, lambdas process data in batches rather than one
item at a time. This allows the system to run operations more efficiently and 
handle larger amounts of data faster. Each lambda is also executed in an 
isolated environment, so it does not interfere with other operations and can 
run safely and reproducibly. The system automatically takes care of running the 
lambdas and passing data between workflow steps.

Lambdas are provided to tasks as Docker images. To implement a custom lambda, 
a user writes the required processing logic according to the lambda interface 
and packages it into a Docker image, which can then be used in workflows.

### Schema and execution

In the automation system, resources are described using two complementary concepts:

* **Schema** – a static definition (blueprint) that specifies the structure,
  configuration, and behavior of a resource,
* **Execution** – a runtime instance created from the schema, representing
  a specific run of that resource.

### Workflow execution

A workflow execution is a runtime instance of a workflow schema, created when the 
workflow is started with specific input data and parameters.  
Each execution is independent and represents a single run of the workflow.

Workflow executions can be started via the GUI or the REST API. When starting a workflow, 
users can select a logging level and optionally configure a callback URL for 
completion notifications (REST API only).

To learn more about the workflow execution lifecycle, see: [workflow-lifecycle][]


### Store

A Store is a component used to store data during workflow processing.
It is used to provide input to tasks and to collect the data produced
as their output. Tasks can add new items to a Store, but reading or
processing items does not remove them. A single Store can be used by
multiple tasks, both as an input source and as an output destination.
Each Store is associated with a specific type, depending on the kind of
data it stores.

### Store Types

#### Audit Log
A Store used to collect log entries produced during workflow execution.

When to use it:
* to inspect what happened during task execution,
* to keep execution history.

#### List
A Store that holds an ordered collection of items.

When to use it:
* when tasks produce multiple results,
* when you want to pass a set of items to another task.

#### Range
A Store that represents a sequence of numbers defined by 
three integer values: start, end, and step.

When to use it:
* when you want to process a sequence of values (e.g. indexes).

#### Single Value
A Store that holds a single value that can be overwritten.

When to use it:
* when you need to track a single value that may change during 
workflow processing (e.g. a status),
* when only the latest value matters.

#### Time Series
A Store designed to hold values associated with time.

When to use it:
* for metrics and measurements,
* for tracking performance or resource usage.

#### Tree Forest
A Store designed to hold hierarchical data (like files or datasets).

When to use it:
* when you need to process whole directory tree (yield every nested item in directory).


### Lane

A Lane represents a single, distinct processing stage within a workflow.
Lanes are executed sequentially, which allows them to be repeated.
A Lane consists of one or more Parallel Boxes, each containing Tasks.
Tasks within a Parallel Box are executed concurrently, while Parallel Boxes
themselves are executed sequentially.
Each Lane must have a source Store, whose items are processed by the Tasks
in Parallel Boxes.


![screen-lane-composition][]

To better understand the lane execution mechanism, it is useful to
distinguish between **lane execution** and **lane execution run**.
A **lane execution** represents the long-lived orchestration context
for a lane within a workflow, managing retries and execution history,
while a **lane execution run** is a single, concrete attempt to process a
specific set of data within that context.
To learn more about **lane execution** vs **lane execution run**, see: ...

For efficient processing, items are processed in batches. Users can
configure the desired **max. batch size** in the lane settings.
This parameter is especially important for retry behavior: if processing of
any item within a batch fails, the entire batch is processed again.

For a **lane execution run** to succeed, all processed items must complete
successfully. If processing of any item fails, the current
**lane execution run** is considered failed.
To avoid failing the entire workflow due to individual item errors,
users can configure the desired **max. retries** value.
When enabled, a failed **lane execution run** is retried
until it either succeeds or the retry limit is reached.
In addition, users can define an **instant failure exception threshold**,
expressed as a percentage of failed items. If the proportion of
failed items exceeds the **instant failure exception threshold**
during lane processing, the execution fails immediately and no further
retries are performed.

![screen-lane-creation][]


### Task

A Task represents a single processing step within a workflow. It acts as an
embedding for a lambda, allowing a generic lambda to be used in the context
of a specific workflow. It transforms desired input items into arguments for
the lambda and dispatches the output to the designated Stores. A task derives
the types and names of its arguments from the embedded lambda. The same
applies to the task’s results.

#### Task arguments

A task can build its argument value from:
* **Iterated item** – an item from the lane’s source Store, processed through the lane pipeline.
* **Store content** – the contents of a selected Store.
* **Constant value** – a constant value defined in the task configuration.

![screen-task-arguments][]

#### Task results mappings

A task can dispatch its results to multiple Stores, provided that the result type
matches the Store type. If the result type is **Object** or **File**, or an
array of either, the task can additionally dispatch the results to the
**Current task system audit log** or the **Workflow system audit log**.
When the task result is an array, the dispatch function can be one of:
* **Append** – appends the entire result array as a single entry to the Store.
* **Extend** – appends each item from the result array as a separate entry to the Store.

![screen-task-results][]

#### Time series store

A special store used to collect time series measurements together with 
dashboards built from that data.

#### Resources

Users can choose to use the default resource settings
defined by the lambda or override them.

## Creating a lambda example

To create a lambda, users implement the desired logic, build and expose it as 
a Docker image, and then add the lambda in the GUI, configuring it according 
to the implemented interface and behavior.

Follow the detailed [lambda creation guide][lambda-creation-guide] to learn 
how to implement and build a lambda.  
You can also explore a step-by-step example with 
inline explanations: [demo lambda][demo-lambda-handler].

Adding the lambda requires providing the following configuration in the GUI:

![screen-lambda-gui][]

![screen-lambda-gui-resources][]

1. **Name** – enter a name for the lambda.
2. **State** – select the lambda’s lifecycle state:
   - **Draft** – newly implemented and not yet fully tested,
   - **Stable** – ready for general use; unexpected errors should not occur,
   - **Deprecated** – outdated and should no longer be used.
3. **Summary** – provide a short description of what the lambda does.
4. **Engine** – select the lambda runtime; currently, only OpenFaaS is supported 
(functions-as-a-service used to execute lambdas).
5. **Docker image** - provide the Docker image of the lambda. The image must be 
published and accessible so it can be pulled by the automation system.
6. **Read-only** – indicate whether the lambda is allowed to modify data in a Space.
7. **Mount Space** – choose whether the lambda should use the Oneclient interface. 
A lambda can operate on files either through REST APIs or via Oneclient. When 
using Oneclient, the system exposes files as if they were part of a local filesystem.
To learn more about the Oneclient interface, see the 
[Oneclient documentation][oneclient-documentation]. Note that options 8 and 9 
become available only when **Mount Space** is enabled.
8. **Mount Point** – specify the directory path where Oneclient will be mounted. 
This path must match the expectations of the lambda implementation.
9. **Oneclient options** – configure additional Oneclient flags used during mounting.
10. **Preferred batch size** – define how many items the lambda should process 
in a single batch.
11. **Configuration parameters** – define configuration parameters that the lambda 
logic can access. Unlike arguments, their values must be provided directly in the task 
configuration and cannot be supplied from a Store.
12. **Arguments** – define the input arguments that the lambda logic receives 
when the task runs.
13. **Results** – define the results produced by the lambda.
14. **Resources** - specify requested values or limits for CPU cores, memory, 
and ephemeral storage.


<!-- references -->

[screen-lane-creation]: ../../images/user-guide/automation/lane_creation.png

[screen-lane-composition]: ../../images/user-guide/automation/lane_composition.png

[screen-task-arguments]: ../../images/user-guide/automation/task_arguments.png

[screen-task-results]: ../../images/user-guide/automation/task_results.png

[screen-lambda-gui]: ../../images/user-guide/automation/lambda_creation_gui.png

[screen-lambda-gui-resources]: ../../images/user-guide/automation/lambda_creation_gui_resources.png

[oneclient-documentation]: ../user-guide/interfaces/oneclient.md

[demo-lambda-handler]: https://github.com/onedata/automation-examples/blob/develop/lambdas/demo/docker/handler.py

[lambda-creation-guide]: ../user-guide/creating-lambda-guide.md