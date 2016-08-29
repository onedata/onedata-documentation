
<a name="taskstatus"></a>
### TaskStatus
The result of a scheduled operation, e.g. database service configuration.


|Name|Description|Schema|
|---|---|---|
|**description**  <br>*optional*|The detailed error description.|string|
|**error**  <br>*optional*|The name of an error type.|string|
|**function**  <br>*optional*|The name of a function that returned error.|string|
|**hosts**  <br>*optional*|The collection of hosts with associated error description.|< string, [Error](Error.md#error) > map|
|**module**  <br>*optional*|The name of a module containing function that returned error.|string|
|**status**  <br>*required*|The operation status.|enum (ok, error, running)|
|**steps**  <br>*required*|The list of operation steps that have been executed successfully.|< string > array|

**Example**
```
{
  "status" : "running",
  "steps" : [ "configuring" ]
}
```



