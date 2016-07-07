
<a name="create_space"></a>
#### Create new space
```
POST /spaces
```


##### Description
When called by a regular user, creates a new space and creates the current user its owner.

When called by a provider, creates a new spaces and automatically adds support for, based on the token provided in the request body.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Body**|**name**  <br>*optional*|Space name.|[name](#create_space-name)|--|

<a name="create_space-name"></a>
**name**

|Name|Description|Schema|
|---|---|---|
|**name**  <br>*optional*|The name of the space|string|
|**token**  <br>*optional*|Space creation token (only for providers).|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**201**|ID of the created space in the form /spaces/{id} is  returned in the response `location` header.|No Content|
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
"/spaces"
```


###### Request body
```
json :
{
  "name" : "string",
  "token" : "string"
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



