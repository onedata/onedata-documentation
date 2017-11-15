
<a name="spaceautocleaningstatus"></a>
### SpaceAutoCleaningStatus
Status of current auto cleaning process for given space


|Name|Description|Schema|
|---|---|---|
|**inProgress**  <br>*required*|Flag which indicates whether auto cleaning process is currently in progress|boolean|
|**spaceOccupancy**  <br>*required*|Amount of storage [b] used by data from given space on that storage.|integer|

**Example**
```
{
  "inProgress" : true,
  "spaceOccupancy" : 100200
}
```



