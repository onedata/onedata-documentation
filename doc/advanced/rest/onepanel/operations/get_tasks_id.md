
<a name="get_tasks_id"></a>
#### Get task result
```
GET /tasks/{id}
```


##### Description
Returns result of an asynchronous operation, e.g. database service
configuration.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*|The task ID.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The task result.|[TaskStatus](../definitions/TaskStatus.md#taskstatus)|
|**401**|Unauthorized request.|No Content|
|**403**|Forbidden request.|No Content|
|**404**|The task does not exist.|No Content|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


##### Produces

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/tasks/string"
```


##### Example HTTP response

###### Response 200
```
json :
{
  "status" : "running",
  "steps" : [ "configuring" ]
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



