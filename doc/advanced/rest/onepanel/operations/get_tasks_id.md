
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
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|[Error](../definitions/Error.md#error)|
|**404**|The task has not been found.|[Error](../definitions/Error.md#error)|
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
  "steps" : [ "configuring" ],
  "hosts" : [ {
    "host1" : {
      "error" : "Operation Error",
      "description" : "Storage name is not available."
    }
  } ]
}
```


###### Response 400
```
json :
{
  "error" : "Authentication Error",
  "description" : "Invalid username or password."
}
```


###### Response 403
```
json :
{
  "error" : "Authentication Error",
  "description" : "Invalid username or password."
}
```


###### Response 404
```
json :
{
  "error" : "Authentication Error",
  "description" : "Invalid username or password."
}
```


###### Response 500
```
json :
{
  "error" : "Authentication Error",
  "description" : "Invalid username or password."
}
```



