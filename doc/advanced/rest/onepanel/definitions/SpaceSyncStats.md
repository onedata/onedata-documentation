
<a name="spacesyncstats"></a>
### SpaceSyncStats
Status and statistics of storage/space synchronization.


|Name|Description|Schema|
|---|---|---|
|**importStatus**  <br>*required*|Describes import algorithm run status.|enum (inProgress, done)|
|**stats**  <br>*optional*|Collection of statistics for requested metrics.|[TimeStatsCollection](TimeStatsCollection.md#timestatscollection)|
|**updateStatus**  <br>*optional*|Describes update algorithm run status.|enum (waiting, inProgress)|

**Example**
```
{
  "importStatus" : "done",
  "updateStatus" : "inProgress",
  "stats" : {
    "queueLength" : {
      "name" : "queueLength",
      "lastValueDate" : "2017-06-22T13:29:39.654Z",
      "period" : "hour",
      "values" : [ 4, 8, 12, 16, 20, 10, 4, 2, 0, 0, 0, 0 ]
    },
    "insertCount" : {
      "name" : "insertCount",
      "lastValueDate" : "2017-06-22T13:29:39.654Z",
      "period" : "hour",
      "values" : [ 4, 8, 12, 16, 20, 10, 4, 2, 0, 0, 0, 0 ]
    }
  }
}
```



