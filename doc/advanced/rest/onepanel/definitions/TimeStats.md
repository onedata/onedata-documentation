
<a name="timestats"></a>
### TimeStats
Statistics for single metric over specified time.


|Name|Description|Schema|
|---|---|---|
|**lastValueDate**  <br>*required*|Date of last measurement value in this object in ISO 8601 format|string|
|**name**  <br>*required*|Name of metric for which this object holds statistics.|enum (queueLength, insertCount, updateCount, deleteCount)|
|**period**  <br>*optional*|Predefined time period for which the statistics were fetched|enum (minute, hour, day)|
|**values**  <br>*required*|List of sample values for given metric. The used period is divided into array-length number of parts. E.g. if the used period is an hour, and if there are 12 values in this array, every value is a value for 1/12 of day, which gives value for every hour of the day. If the value is null, there is no sample for given time part.|< number > array|

**Example**
```
{
  "name" : "queueLength",
  "lastValueDate" : "2017-06-22T13:29:39.654Z",
  "period" : "minute",
  "values" : [ 4, 8, 12, 16, 20, 10, 4, 2, 0, 0, 0, 0 ]
}
```



