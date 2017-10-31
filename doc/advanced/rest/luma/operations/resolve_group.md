
<a name="resolve_group"></a>
#### Resolve group identity
```
POST /resolve_group
```


##### Description
Returns group identity based on storage specific group id.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Body**|**groupDetails**  <br>*required*|Group mapping request.|[GroupDetails](../definitions/GroupDetails.md#groupdetails)|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|Group identity returned successfully.|[GroupIdentity](../definitions/GroupIdentity.md#groupidentity)|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|[Error](../definitions/Error.md#error)|
|**404**|User credentials not found.|[Error](../definitions/Error.md#error)|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


##### Consumes

* `application/json`


##### Produces

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/resolve_group"
```


###### Request body
```
json :
{
  "id" : "Assdwe897Dsdjhx9",
  "gid" : "1001",
  "name" : "users"
}
```


##### Example HTTP response

###### Response 200
```
json :
{
  "idp" : "github",
  "groupId" : "5484af38-8b5d-464f-bdd1-da9ef801090f"
}
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



