
<a name="add_group_to_space"></a>
#### Add group to space
```
PUT /spaces/{id}/groups
```


##### Description
Allows to add a group to any space. 

This operation can be invoked by system administrators only
and requires `add_member_to_space` privilege.

***Example cURL requests***

**Add group to space**
```bash
curl -k -u username:password  -H "Content-type: application/json"\
 -X PUT -d '{"groupId" : "T5x_HhFYOnILOCUf9OqgExw00RwaU2MXT5122oWk_sM"}' \
 https://$HOST:8443/api/v3/onezone/spaces/9ueUeoZA6KXxNgzlvqmmrbzqE_BQiaHEEDC21sY1Kuc/groups
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*|Space ID.|string|--|
|**Body**|**groupId**  <br>*required*||[groupId](#add_group_to_space-groupid)|--|

<a name="add_group_to_space-groupid"></a>
**groupId**

|Name|Description|Schema|
|---|---|---|
|**groupId**  <br>*optional*|ID of the group to add to space.|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|The group was added to the space.|No Content|
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
"/spaces/string/groups"
```


###### Request body
```
json :
{
  "groupId" : "string"
}
```


##### Example HTTP response

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



