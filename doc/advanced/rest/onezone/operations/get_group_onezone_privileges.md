
<a name="get_group_onezone_privileges"></a>
#### Get group's Onezone privileges
```
GET /privileges/group/{id}
```


##### Description
Returns the list of group privileges for Onezone.

This operation requires `view_privileges` privilege.

***Example cURL requests***

**Get groups privileges to Onezone service**
```bash
curl -k -u admin:password -X GET \
https://$HOST:8443/api/v3/onezone/privileges/groups/T5x_HhFYOnILOCUf9OqgExw00RwaU2MXT5122oWk_sM

{
  "privileges": []
}
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*|Group ID.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The list of group privileges in Onezone.|[OnezonePrivileges](../definitions/OnezonePrivileges.md#onezoneprivileges)|
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
"/privileges/group/string"
```


##### Example HTTP response

###### Response 200
```
json :
{
  "privileges" : [ "view_privileges", "set_privileges", "list_spaces", "list_providers", "list_providers_of_space" ]
}
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



