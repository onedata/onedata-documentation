
<a name="panelconfiguration"></a>
### PanelConfiguration
The panel configuration.


|Name|Description|Schema|
|---|---|---|
|**users**  <br>*required*|The collection of user names associated with users properties.|< string, [users](#panelconfiguration-users) > map|

<a name="panelconfiguration-users"></a>
**users**

|Name|Description|Schema|
|---|---|---|
|**password**  <br>*required*|The user password.|string|
|**userRole**  <br>*required*|The user role, one of 'admin' or 'regular'.|enum (admin, regular)|



