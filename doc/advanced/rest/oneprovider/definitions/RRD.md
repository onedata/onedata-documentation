
<a name="rrd"></a>
### RRD
RRD database export.


|Name|Description|Schema|
|---|---|---|
|**about**  <br>*optional*|Name of the RRD database|string|
|**data**  <br>*optional*||< < number > array > array|
|**meta**  <br>*optional*||[meta](#rrd-meta)|

<a name="rrd-meta"></a>
**meta**

|Name|Description|Schema|
|---|---|---|
|**end**  <br>*optional*|End timestamp of the metrics.|number|
|**legend**  <br>*optional*|Names of the columns in the exported array|< string > array|
|**start**  <br>*optional*|Start timestamp of the metrics.|number|
|**step**  <br>*optional*|Step of the metrics.|number|

**Example**
```
{
  "about" : "RRDtool graph JSON output",
  "meta" : {
    "start" : 1465466700,
    "end" : 1465553100,
    "step" : 300,
    "legend" : [ "storage_quota", "storage_used", "storage_free" ]
  },
  "data" : [ [ 5.6435528434, 2.6435528434, 4.6435528434 ], [ 5.6435528434, 2.6435528434, 4.6435528434 ], [ 5.6435528434, 2.6435528434, 4.6435528434 ] ]
}
```



