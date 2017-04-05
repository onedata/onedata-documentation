
<a name="list_user_spaces"></a>
#### List user spaces
```
GET /user/spaces
```


##### Description
Returns the list of users' spaces.

This operation can be invoked on behalf of current user only.

***Example cURL requests***

**Get user spaces**
```bash
curl -u username:password -X GET \
https://$HOST:8443/api/v3/onezone/user/spaces

{
  "spaces": [
    "IkHB2CCoAFm5FCswhAJynbFU4fj26yiE1lhpK3p-0Y8"
  ],
  "default": "undefined"
}
```


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|Returns the list of user spaces, including information which space is default.|[Response 200](#list_user_spaces-response-200)|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**401**|Authentication error.|[Error](../definitions/Error.md#error)|
|**403**|Authorization error.|[Error](../definitions/Error.md#error)|
|**404**|Resource not found.|[Error](../definitions/Error.md#error)|
|**500**|Internal server Error.|[Error](../definitions/Error.md#error)|

<a name="list_user_spaces-response-200"></a>
**Response 200**

|Name|Description|Schema|
|---|---|---|
|**default**  <br>*optional*|The ID of the default user space.|string|
|**spaces**  <br>*optional*|The list of all user spaces ID's.|< string > array|


##### Produces

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/user/spaces"
```


##### Example HTTP response

###### Response 200
```
json :
"object"
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



