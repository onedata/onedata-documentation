
<a name="get_provider_nagios_report"></a>
#### Get provider nagios report
```
GET /provider/nagios
```


##### Description
Returns the provider nagios report.


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The provider nagios report.|No Content|
|**401**|Unauthorized request.|No Content|
|**403**|Forbidden request.|No Content|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


##### Produces

* `text/xml`


##### Example HTTP request

###### Request path
```
json :
"/provider/nagios"
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



