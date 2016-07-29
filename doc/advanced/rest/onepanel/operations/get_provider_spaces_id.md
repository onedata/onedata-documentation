
<a name="get_provider_spaces_id"></a>
#### Get space details
```
GET /provider/spaces/{id}
```


##### Description
Returns space details.


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*|The ID of a space which details should be returned.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The space details.|[SpaceDetails](../definitions/SpaceDetails.md#spacedetails)|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|No Content|
|**500**|Internal server error.|No Content|


##### Produces

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/provider/spaces/string"
```


##### Example HTTP response

###### Response 200
```
json :
{
  "spaceId" : "string",
  "name" : "string",
  "supportingProviders" : {
    "string" : 0
  }
}
```


###### Response 400
```
json :
{
  "error" : "Authentication Error",
  "description" : "Invalid username or password."
}
```



