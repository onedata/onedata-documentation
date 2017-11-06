
<a name="delete_group_mapping"></a>
#### Delete group mapping
```
DELETE /admin/{idp}/groups/{groupId}
```


##### Description
Allows to remove group mapping from LUMA.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**groupId**  <br>*required*|Id of a group as recognized by a specific identity provider.|string|--|
|**Path**|**idp**  <br>*required*|Id of identity provider that was (or will be) used by subject user to log in into onezone, identical to id specified in auth.config / saml.config.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|Group details removed successfully.|No Content|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|[Error](../definitions/Error.md#error)|
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



