
<a name="spaceautocleaningreport"></a>
### SpaceAutoCleaningReport
Autocleaning report


|Name|Description|Schema|
|---|---|---|
|**bytesToRelease**  <br>*required*|Number of bytes that should be deleted.|integer|
|**filesNumber**  <br>*required*|Number of deleted files.|integer|
|**releasedBytes**  <br>*required*|Number of bytes deleted during autocleaning procedure.|integer|
|**startedAt**  <br>*required*|Start time of autocleaning procedure in ISO 8601 format|string|
|**stoppedAt**  <br>*required*|Finish time of autocleaning procedure in ISO 8601 format|string|

**Example**
```
{
  "startedAt" : "2017-06-22T13:29:39.654Z",
  "stoppedAt" : "2017-06-22T15:57:41.958Z",
  "releasedBytes" : 60000,
  "bytesToRelease" : 500,
  "filesNumber" : 10
}
```



