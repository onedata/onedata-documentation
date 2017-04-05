
<a name="list_space_users"></a>
#### List space users
```
GET /spaces/{id}/users
```


##### Description
Returns the list of users belonging to a specific space.

This operation requires `space_view_data` privilege.

***Example cURL requests***

**Get space provider details**
```bash
curl -u username:password -X GET \
https://$HOST:8443/api/v3/onezone/spaces/9ueUeoZA6KXxNgzlvqmmrbzqE_BQiaHEEDC21sY1Kuc/users

{
  "users": [
    "lb0NvUXIVguzjQ3dBOXAyd1c61fWKB5dKJDQ6YvB7a0"
  ]
}
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*|Space ID.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The list of all user ID's that belong to a specific space|[Users](../definitions/Users.md#users)|
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
"/spaces/string/users"
```


##### Example HTTP response

###### Response 200
```
json :
{
  "users" : [ "Bmav38YI0Z2-dw-fvrZ3XP-J0HjCN0taT3_WungK", "ASmlkZW50aWZpZXIgOEhmSEFSSGdrbHFCa1pWSTR" ]
}
```


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



