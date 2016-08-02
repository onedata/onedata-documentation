
<a name="metrics"></a>
### Metrics
Export of monitoring metrics for specific provider.


|Name|Description|Schema|
|---|---|---|
|**providerId**  <br>*optional*|The ID of the provider.|string|
|**rrd**  <br>*optional*|RRD database export.|[RRD](RRD.md#rrd)|

**Example**
```
{
  "providerId" : "ASDASD-876786-LKJHASD-070-ASDAS",
  "rrd" : {
    "about" : "RRDtool graph JSON output",
    "meta" : {
      "start" : 1465466700,
      "end" : 1465553100,
      "step" : 300,
      "legend" : [ "storage_free" ]
    },
    "data" : [ [ 5.6435528434 ], [ 2.6435528434 ], [ 4.6435528434 ] ]
  }
}
```



