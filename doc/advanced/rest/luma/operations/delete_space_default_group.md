
<a name="delete_space_default_group"></a>
#### Delete default space group
```
DELETE /admin/spaces/{sid}/default_group
```


##### Description
Allows to remove default group gid for a space.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**sid**  <br>*required*|Id of the space for which the default group gid should be removed.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|Default group removed successfully.|No Content|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|[Error](../definitions/Error.md#error)|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


##### Consumes

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/admin/spaces/string/default_group"
```


##### Example HTTP response

###### Response 400
```
json :
{
  "error" : "invalid_user",
  "errorDescription" : "Invalid user ID."
}
```


###### Response 403
```
json :
{
  "error" : "invalid_user",
  "errorDescription" : "Invalid user ID."
}
```


###### Response 500
```
json :
{
  "error" : "invalid_user",
  "errorDescription" : "Invalid user ID."
}
```



