
<a name="usermodifyrequest"></a>
### UserModifyRequest
The user configuration details that can be modified.


|Name|Description|Schema|
|---|---|---|
|**currentPassword**  <br>*required*|The current user password that should be changed or password of an administrator that is issuing this request on behalf of a user.|string|
|**newPassword**  <br>*required*|The new user password.|string|

**Example**
```
{
  "currentPassword" : "P@@$$W0RD1",
  "newPassword" : "P@@$$W0RD2"
}
```



