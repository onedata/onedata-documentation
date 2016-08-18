
<a name="get_space_groups"></a>
#### Get space groups
```
GET /spaces/{id}/groups
```


##### Description
Returns the list of groups belonging to a specific space.

***Example cURL requests***

**Get space groups**
```bash
curl -k -u username:password -X GET \
https://$HOST:8443/api/v3/onezone/spaces/56ID6lRxcbz4OEbrr7vPI52UA7E6WwkqQ6bJCtW5PLE/groups

{
  "groups": [
    "T5x_HhFYOnILOCUf9OqgExw00RwaU2MXT5122oWk_sM",
    "e3piG9yg9877lagR7aHayk73te9gAMXxQvjBycwvnaow"]
}
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*|Space ID.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The list of all group ID's that belong to a specific space|< string > array|
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
"/spaces/string/groups"
```


##### Example HTTP response

###### Response 200
```
json :
"array"
```


###### Response 400
```
json :
{
  "error" : "invalid_token",
  "error_description" : "Provided token could not be validated."
}
```


###### Response 401
```
json :
{
  "error" : "invalid_token",
  "error_description" : "Provided token could not be validated."
}
```


###### Response 403
```
json :
{
  "error" : "invalid_token",
  "error_description" : "Provided token could not be validated."
}
```


###### Response 404
```
json :
{
  "error" : "invalid_token",
  "error_description" : "Provided token could not be validated."
}
```


###### Response 500
```
json :
{
  "error" : "invalid_token",
  "error_description" : "Provided token could not be validated."
}
```



