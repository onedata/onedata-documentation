
<a name="get_group_mapping"></a>
#### Get group mapping
```
GET /admin/{idp}/groups/{groupId}
```


##### Description
Returns group details known by LUMA.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**groupId**  <br>*required*|Id of a group as recognized by a specific identity provider.|string|--|
|**Path**|**idp**  <br>*required*|Id of identity provider that was (or will be) used by subject user to log in into onezone, identical to id specified in auth.config / saml.config.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|Group details returned successfully.|< [GroupDetails](../definitions/GroupDetails.md#groupdetails) > array|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|[Error](../definitions/Error.md#error)|
|**404**|Group credentials not found.|[Error](../definitions/Error.md#error)|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


##### Consumes

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/admin/string/groups/string"
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


###### Response 404
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



