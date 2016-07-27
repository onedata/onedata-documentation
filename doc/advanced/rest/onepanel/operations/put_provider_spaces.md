
<a name="put_provider_spaces"></a>
#### Create or support space
```
PUT /provider/spaces
```


##### Description
Supports an existing space or creates a new space and automatically supports it.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Body**|**spaceSupportRequest**  <br>*required*||[SpaceSupportRequest](../definitions/SpaceSupportRequest.md#spacesupportrequest)|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|The spaces has been successfully creates/supported.  <br>**Headers** :   <br>`Location` (string) : The path to the created/supported space resource.|No Content|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|No Content|
|**500**|Internal server error.|No Content|


##### Produces

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/provider/spaces"
```


###### Request body
```
json :
{
  "name" : "MySpace1",
  "token" : "ASDJNASD87687ASDMNBMNASD87786asd",
  "size" : 1024000
}
```


##### Example HTTP response

###### Response 400
```
json :
{
  "error" : "Authentication Error",
  "description" : "Invalid username or password."
}
```



