
<a name="zoneconfiguration"></a>
### ZoneConfiguration
The zone deployment configuration.


|Name|Description|Schema|
|---|---|---|
|**cluster**  <br>*required*||[ZoneClusterConfiguration](ZoneClusterConfiguration.md#zoneclusterconfiguration)|
|**onezone**  <br>*optional*|The zone custom configuration.|[onezone](#zoneconfiguration-onezone)|

<a name="zoneconfiguration-onezone"></a>
**onezone**

|Name|Description|Schema|
|---|---|---|
|**domainName**  <br>*optional*|The name of a HTTP domain.|string|
|**name**  <br>*optional*|The name of a zone.|string|



