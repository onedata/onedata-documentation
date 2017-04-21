
<a name="modify_space"></a>
#### Modify space details
```
PATCH /spaces/{id}
```


##### Description
Updates the details about a space.

If called by user who is not member of the space, requires `space_change_data`
privilege.

***Example cURL requests***

**Change space name**
```bash
curl -u username:password -H "Content-type: application/json" \
-X PATCH -d '{"name": "new_space12"}' \
https://$HOST:8443/api/v3/onezone/spaces/56ID6lRxcbz4OEbrr7vPI52UA7E6WwkqQ6bJCtW5PLE
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*|Space ID.|string|--|
|**Body**|**data**  <br>*required*|Space parameters|[data](#modify_space-data)|--|

<a name="modify_space-data"></a>
**data**

|Name|Description|Schema|
|---|---|---|
|**name**  <br>*optional*|The name of the new space.|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|Space has been updated successfully.|No Content|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**401**|Authentication error.|[Error](../definitions/Error.md#error)|
|**403**|Authorization error.|[Error](../definitions/Error.md#error)|
|**404**|Resource not found.|[Error](../definitions/Error.md#error)|
|**500**|Internal server Error.|[Error](../definitions/Error.md#error)|


##### Consumes

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/spaces/string"
```


###### Request body
```
json :
{
  "name" : "string"
}
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



