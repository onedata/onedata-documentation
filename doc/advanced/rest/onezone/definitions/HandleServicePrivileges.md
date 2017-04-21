
<a name="handleserviceprivileges"></a>
### HandleServicePrivileges
The list of handle service privileges.


|Name|Description|Schema|
|---|---|---|
|**operation**  <br>*optional*|This field determines how the included privileges are handled ('set' - resets to the specified list, 'grant' - adds the specified privileges to existing ones and 'revoke' - removes the listed privileges)  <br>**Default** : `"set"`|enum (set, grant, revoke)|
|**privileges**  <br>*required*||< enum (delete_handle_service, handle_service_list_handles, modify_handle_service, register_handle, view_handle_service) > array|

**Example**
```
{
  "operation" : [ "grant" ],
  "privileges" : [ "view_handle_service", "modify_handle_service", "delete_handle_service", "register_handle", "handle_service_list_handles" ]
}
```



