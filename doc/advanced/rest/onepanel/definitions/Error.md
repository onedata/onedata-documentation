
<a name="error"></a>
### Error
Generic error model for REST requests.


|Name|Description|Schema|
|---|---|---|
|**error**  <br>*required*|Identifier representing internal error code.|string|
|**error_description**  <br>*required*|Detailed error message.|string|

**Example**
```
{
  "error" : "invalid_token",
  "error_description" : "Provided token could not be validated."
}
```



