
<a name="get_provider_space_auto_cleaning_reports"></a>
#### Get reports of space auto cleaning
```
GET /provider/spaces/{id}/auto_cleaning_reports
```


##### Description
Returns collection of reports of auto cleaning for the space


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*|The ID of a space|string|--|
|**Query**|**started_after**  <br>*required*|Fetch only reports that started after this date (ISO-8601)|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|Collection of space auto cleaning reports|[SpaceAutoCleaningReportCollection](../definitions/SpaceAutoCleaningReportCollection.md#spaceautocleaningreportcollection)|
|**401**|Unauthorized request.|No Content|
|**403**|Forbidden request.|No Content|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


##### Produces

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/provider/spaces/string/auto_cleaning_reports"
```


###### Request query
```
json :
{
  "started_after" : "string"
}
```


##### Example HTTP response

###### Response 200
```
json :
{
  "reportEntries" : [ {
    "startedAt" : "2017-06-22T13:29:39.654Z",
    "stoppedAt" : "2017-06-22T15:57:41.958Z",
    "releasedBytes" : 60000,
    "bytesToRelease" : 500,
    "filesNumber" : 10
  } ]
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



