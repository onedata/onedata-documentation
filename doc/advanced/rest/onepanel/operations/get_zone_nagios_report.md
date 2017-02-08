
<a name="get_zone_nagios_report"></a>
#### Get zone nagios report
```
GET /zone/nagios
```


##### Description
Returns the zone nagios report.


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The zone nagios report.|No Content|
|**401**|Unauthorized request.|No Content|
|**403**|Forbidden request.|No Content|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


##### Produces

* `text/xml`


##### Example HTTP request

###### Request path
```
json :
"/zone/nagios"
```


##### Example HTTP response

###### Response 500
```
json :
{
  "error" : "Invalid Request",
  "description" : "User role must be one of 'admin' or 'regular'."
}
```



