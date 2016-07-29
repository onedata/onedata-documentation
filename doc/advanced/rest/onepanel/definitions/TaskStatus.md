
<a name="taskstatus"></a>
### TaskStatus
The result of a scheduled operation, e.g. database service configuration.


|Name|Description|Schema|
|---|---|---|
|**hosts**  <br>*optional*|The collection of hosts with associated error description. This property is set only when an error occurred during operation execution, i.e. the value of property 'status' is set to 'error'.|< string, [Error](Error.md#error) > map|
|**status**  <br>*required*|The operation status.|enum (ok, error, running)|
|**steps**  <br>*required*|The list of operation steps that have been executed so far.|< string > array|

**Example**
```
{
  "status" : "running",
  "steps" : [ "configuring" ],
  "hosts" : [ {
    "host1" : {
      "error" : "Operation Error",
      "description" : "Storage name is not available."
    }
  } ]
}
```



