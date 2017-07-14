
<a name="get_provider_space_sync_stats"></a>
#### Get statistics of storage synchronization
```
GET /provider/spaces/{id}/sync
```


##### Description
Returns requested statistics of storage synchronization for given space on this provider.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*|The ID of a space for which sync stats should be returned.|string|--|
|**Query**|**metrics**  <br>*optional*|Specify which statistic metrics should be returned - strings delimited with comma|string|--|
|**Query**|**period**  <br>*optional*|Predefined time period for which the statistics should be fetched|enum (minute, hour, day)|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|Space synchronization status and statistics.|[SpaceSyncStats](../definitions/SpaceSyncStats.md#spacesyncstats)|
|**401**|Unauthorized request.|No Content|
|**403**|Forbidden request.|No Content|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


##### Produces

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/provider/spaces/string/sync"
```


###### Request query
```
json :
{
  "metrics" : "string",
  "period" : "string"
}
```


##### Example HTTP response

###### Response 200
```
json :
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


###### Response 500
```
json :
{
  "error" : "Invalid Request",
  "description" : "User role must be one of 'admin' or 'regular'."
}
```



