
<a name="spaceautocleaning"></a>
### SpaceAutoCleaning
Space auto cleaning settings


|Name|Description|Schema|
|---|---|---|
|**enabled**  <br>*optional*|If true, auto cleaning feature for the space is enabled|boolean|
|**settings**  <br>*optional*|Settings when and what files auto cleaning should clean|[SpaceAutoCleaningSettings](SpaceAutoCleaningSettings.md#spaceautocleaningsettings)|

**Example**
```
{
  "enabled" : true,
  "settings" : {
    "lowerFileSizeLimit" : 1000,
    "upperFileSizeLimit" : 1000000,
    "maxFileNotOpenedHours" : 60000,
    "target" : 5000000000,
    "threshold" : 6000000000
  }
}
```



