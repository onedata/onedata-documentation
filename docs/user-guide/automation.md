# Automation

Automation in Onedata provides a built-in mechanism for defining and 
executing data workflows directly on data accessible through Spaces. 
It supports creating custom data processing pipelines and provides facilities for 
monitoring execution, collecting results, and inspecting execution history.

## Main concepts

## Inventory 

## Workflow

A workflow definition describes what should be done,
they are created using the graphical user interface (GUI) and 
represented as JSON files. Each workflow can have multiple revisions, 
which are different versions of the same workflow managed by its author.

Workflow definitions can be edited via the GUI, either by creating a new 
revision or by modifying an existing one. Directly editing the underlying 
JSON file is possible but strongly discouraged, as it may lead to workflow 
corruption.

Creating new revisions for changes is recommended, as it helps preserve 
backward compatibility and makes workflow evolution easier to manage. 
Changes to a workflow definition do not affect already running or completed 
workflow executions.

## Workflow Execution

A workflow execution is a single instance of running a workflow definition with 
concrete input data and parameters.
Each time a workflow is started, a new workflow execution is created. 
Executions are independent of each other.

Workflow executions can be started via the GUI or the REST API, 
allowing users to select a logging level and, when using the REST API, 
to configure a callback URL for completion notifications.

Workflow during execution goes through following states:
waiting, ongoing, suspended, ended (for more information check ...)

### Store

### Task

### Parallel Box

## Lambda

## 