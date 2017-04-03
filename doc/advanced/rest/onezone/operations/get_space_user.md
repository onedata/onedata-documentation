
<a name="get_space_user"></a>
#### Get space user details
```
GET /spaces/{id}/users/{uid}
```


##### Description
Returns the public information about a specific user in a space.

This operation requires `space_view_data` privilege.


***Example cURL requests***

**Get space user data**
```bash
curl -u username:password -X GET \
https://$HOST:8443/api/v3/onezone/spaces/9ueUeoZA6KXxNgzlvqmmrbzqE_BQiaHEEDC21sY1Kuc/users/lb0NvUXIVguzjQ3dBOXAyd1c61fWKB5dKJDQ6YvB7a0
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*|Space ID.|string|--|
|**Path**|**uid**  <br>*required*|User ID.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|Information about a space user.|[User](../definitions/User.md#user)|
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
"/spaces/string/users/string"
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



