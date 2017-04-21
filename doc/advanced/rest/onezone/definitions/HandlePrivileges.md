
<a name="handleprivileges"></a>
### HandlePrivileges
The list of handle privileges.


|Name|Description|Schema|
|---|---|---|
|**operation**  <br>*optional*|This field determines how the included privileges are handled ('set' - resets to the specified list, 'grant' - adds the specified privileges to existing ones and 'revoke' - removes the listed privileges)  <br>**Default** : `"set"`|enum (set, grant, revoke)|
|**privileges**  <br>*required*||< enum (delete_handle, modify_handle, view_handle) > array|

**Example**
```
{
  "operation" : [ "grant" ],
  "privileges" : [ "delete_handle", "modify_handle", "view_handle" ]
}
```



