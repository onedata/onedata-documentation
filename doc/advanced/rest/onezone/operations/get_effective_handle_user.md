
<a name="get_effective_handle_user"></a>
#### Get effective handle user
```
GET /handles/{hndl}/effective_users/{uid}
```


##### Description
Returns effective handle user details.

This operation requires `modify_handle_service` privilege.

***Example cURL requests***

**Add handle user**
```bash
curl -u username:password -X GET \
https://$HOST:8443/api/v3/handles/SADHLKJhlkASHDLAKSHDLKJHJjLH/effective_users/DLAKSHDLKJHJjLHADHLKJh
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**hndl**  <br>*required*|The ID of the handle.|string|--|
|**Path**|**uid**  <br>*required*|The ID of the user to add to handle.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|User details returned succesfully.|[User](../definitions/User.md#user)|
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
"/handles/string/effective_users/string"
```


##### Example HTTP response

###### Response 200
```
json :
{
  "userId" : "ALKJSDH77i79ASDKJA-ASDBAS9-87",
  "name" : "Rudolf Lingens",
  "connectedAccounts" : [ {
    "accountId" : "ASD879ASD-7SADASFSsa0831",
    "providerId" : "7YASBFLJ-123ASD870-ASDASD"
  }, {
    "accountId" : "QWESsD-7SADASFSsa0831",
    "providerId" : "7QWEJ-123ASD870-ASDASD"
  } ],
  "alias" : "John Doe",
  "emailList" : [ "rudolf.linges@example.com", "john.doe@example.com" ]
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


