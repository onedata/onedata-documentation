
<a name="remove_session"></a>
#### Remove Onepanel user session
```
DELETE /session
```


##### Description
Removes the Onepanel user session.


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|The user session has been successfully removed.|No Content|
|**401**|Unauthorized request.|No Content|
|**403**|Forbidden request.|No Content|
|**404**|User session not found.|No Content|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


##### Example HTTP request

###### Request path
```
json :
"/session"
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



