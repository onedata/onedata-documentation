
<a name="get_provider_space_auto_cleaning_status"></a>
#### Get status of space auto cleaning
```
GET /provider/spaces/{id}/auto_cleaning_status
```


##### Description
Returns status of current process of auto cleaning for the space


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*|The ID of a space|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|Information about current auto cleaning process for the space|[SpaceAutoCleaningStatus](../definitions/SpaceAutoCleaningStatus.md#spaceautocleaningstatus)|
|**401**|Unauthorized request.|No Content|
|**403**|Forbidden request.|No Content|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


##### Produces

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/provider/spaces/string/auto_cleaning_status"
```


##### Example HTTP response

###### Response 200
```
json :
{
  "inProgress" : true,
  "spaceOccupancy" : 100200
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



