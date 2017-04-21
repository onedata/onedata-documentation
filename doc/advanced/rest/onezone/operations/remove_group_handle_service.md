
<a name="remove_group_handle_service"></a>
#### Remove group handle service
```
DELETE /groups/{id}/handle_services/{hsid}
```


##### Description
Removes the group ownership or membership in a specific handle service.

***Example cURL requests***

**Delete user handle service**
```bash
curl -u username:password -X DELETE \
https://$HOST:8443/api/v3/onezone/groups/AJKLASHJKDHKAJSHD/handle_services/oOVF-KrO1P6rpA0LFgNVI8NxuhxyQMUnrYzjAnKiyAY
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**hsid**  <br>*required*|Handle service Id.|string|--|
|**Path**|**id**  <br>*required*|Group ID.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**202**|The handle service will be deleted.|No Content|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**401**|Authentication error.|[Error](../definitions/Error.md#error)|
|**403**|Authorization error.|[Error](../definitions/Error.md#error)|
|**404**|Resource not found.|[Error](../definitions/Error.md#error)|
|**500**|Internal server Error.|[Error](../definitions/Error.md#error)|


##### Produces

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/groups/string/handle_services/string"
```


##### Example HTTP response

###### Response 400
```
json :
{
  "error" : "Provided data could not be understood by the server"
}
```


###### Response 401
```
json :
{
  "error" : "Provided data could not be understood by the server"
}
```


###### Response 403
```
json :
{
  "error" : "Provided data could not be understood by the server"
}
```


###### Response 404
```
json :
{
  "error" : "Provided data could not be understood by the server"
}
```


###### Response 500
```
json :
{
  "error" : "Provided data could not be understood by the server"
}
```



