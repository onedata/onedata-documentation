
<a name="get_effective_provider_user"></a>
#### Get effective user of provider
```
GET /providers/{pid}/effective_users/{uid}
```


##### Description
Returns the details of an effective user of a specific provider.

This operation requires `list_users_of_provider` privilege.

***Example cURL requests***

**Get effective user of a provider**
```bash
curl -u username:password -X GET  \
https://$HOST:8443/api/v3/onezone/providers/ASDJKHASDASD5465asdvASDasd/effective_users/KJHAGSDJKHGASJKHDGAKJHSDGKHJASD

{
  "userId": "KJHAGSDJKHGASJKHDGAKJHSDGKHJASD",
  "login":"username",
  "name":"admin"
}
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**pid**  <br>*required*|Provider ID.|string|--|
|**Path**|**uid**  <br>*required*|User ID.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The effective user details.|[User](../definitions/User.md#user)|
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
"/providers/string/effective_users/string"
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



