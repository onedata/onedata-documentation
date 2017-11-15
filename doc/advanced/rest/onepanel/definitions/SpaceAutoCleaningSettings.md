
<a name="spaceautocleaningsettings"></a>
### SpaceAutoCleaningSettings
Settings for auto cleaning algorithms - for what files and when it should be started. If parameter is not set in the request, previous value will be used.


|Name|Description|Schema|
|---|---|---|
|**lowerFileSizeLimit**  <br>*optional*|Only files which size [b] is greater than or equal to given value should be cleaned. Set to null to disable this parameter.|integer|
|**maxFileNotOpenedHours**  <br>*optional*|Files that haven't been opened for longer than or equal to given period [h] will be cleaned. Set to null to disable this parameter.|integer|
|**target**  <br>*optional*|Amount of data [b], at which the auto cleaning process should stop. This parameter is required to enale auto cleaning.|integer|
|**threshold**  <br>*optional*|Amount of data [b], which should trigger the auto cleaning in the space.  Only replicas maintained by this storage provider will be removed. If not  specified, the auto cleaning will not start automatically.|integer|
|**upperFileSizeLimit**  <br>*optional*|Only files which size [b] is less than or equal to given value should be cleaned Set to null to disable this parameter.|integer|

**Example**
```
{
  "lowerFileSizeLimit" : 1000,
  "upperFileSizeLimit" : 1000000,
  "maxFileNotOpenedHours" : 60000,
  "target" : 5000000000,
  "threshold" : 6000000000
}
```



