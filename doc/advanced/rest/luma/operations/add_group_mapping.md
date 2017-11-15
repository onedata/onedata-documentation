
<a name="add_group_mapping"></a>
#### Set group mapping
```
PUT /admin/{idp}/groups/{groupId}
```


##### Description
Allows to add group mapping to LUMA.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**groupId**  <br>*required*|Id of a group as recognized by a specific identity provider.|string|--|
|**Path**|**idp**  <br>*required*|Id of identity provider that was (or will be) used by subject user to log in into onezone, identical to id specified in auth.config / saml.config.|string|--|
|**Body**|**groupDetails**  <br>*required*|Add group details for mapping.|< [GroupDetails](../definitions/GroupDetails.md#groupdetails) > array|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|Group mapping added successfully.|No Content|
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


###### Request body
```
json :
[ {
  "storageId" : "Assdwe897Dsdjhx9",
  "storageName" : "NFS",
  "gid" : 1001,
  "aclName" : "users"
} ]
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



