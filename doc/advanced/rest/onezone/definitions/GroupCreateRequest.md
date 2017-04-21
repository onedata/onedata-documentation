
<a name="groupcreaterequest"></a>
### GroupCreateRequest
Group create request.


|Name|Description|Schema|
|---|---|---|
|**name**  <br>*required*|The name of the space.|string|
|**type**  <br>*optional*|The type of the group. If not specified, `role` is assumed.|enum (organization, unit, team, role)|

**Example**
```
{
  "name" : "Test group",
  "type" : "role"
}
```



