
<a name="delete_provider"></a>
#### Unregister provider
```
DELETE /provider
```


##### Description
Unregisters provider from the zone.


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|Provider has been successfully unregistered.|No Content|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|No Content|
|**500**|Internal server error.|No Content|


##### Example HTTP request

###### Request path
```
json :
"/provider"
```


##### Example HTTP response

###### Response 400
```
json :
{
  "error" : "Authentication Error",
  "description" : "Invalid username or password."
}
```



