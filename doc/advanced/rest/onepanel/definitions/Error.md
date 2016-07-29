
<a name="error"></a>
### Error
The generic error model for REST requests.


|Name|Description|Schema|
|---|---|---|
|**description**  <br>*required*|The detailed error description.|string|
|**error**  <br>*required*|The name of an error type.|string|

**Example**
```
{
  "error" : "Authentication Error",
  "description" : "Invalid username or password."
}
```



