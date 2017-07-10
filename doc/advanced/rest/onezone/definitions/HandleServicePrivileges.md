
<a name="handleserviceprivileges"></a>
### HandleServicePrivileges
The list of handle service privileges.


|Name|Description|Schema|
|---|---|---|
|**operation**  <br>*optional*|This field determines how the included privileges are handled ('set' - resets to the specified list, 'grant' - adds the specified privileges to existing ones and 'revoke' - removes the listed privileges)  <br>**Default** : `"set"`|enum (set, grant, revoke)|
|**privileges**  <br>*required*||< enum (handle_service_delete, handle_service_list_handles, handle_service_register_handle, handle_service_update, handle_service_view) > array|

**Example**
```
{
  "operation" : [ "grant" ],
  "privileges" : [ "handle_service_delete", "handle_service_list_handles", "handle_service_register_handle", "handle_service_update", "handle_service_view" ]
}
```



