
<a name="serviceerror"></a>
### ServiceError
The service error model for REST requests.


|Name|Description|Schema|
|---|---|---|
|**description**  <br>*required*|The detailed error description.|string|
|**error**  <br>*required*|The name of an error type.|string|
|**function**  <br>*optional*|The name of a function that returned error.|string|
|**hosts**  <br>*optional*|The collection of hosts with associated error description.|< string, [Error](Error.md#error) > map|
|**module**  <br>*optional*|The name of a module containing function that returned error.|string|



