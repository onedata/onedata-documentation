
<a name="error"></a>
### Error
Generic error model for REST requests.


|Name|Description|Schema|
|---|---|---|
|**error**  <br>*required*|Identifier representing internal error code.|string|
|**errorDescription**  <br>*required*|Detailed error message.|string|

**Example**
```
{
  "error" : "invalid_user",
  "errorDescription" : "Invalid user ID."
}
```



