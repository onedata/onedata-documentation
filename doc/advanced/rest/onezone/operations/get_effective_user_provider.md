
<a name="get_effective_user_provider"></a>
#### Get effective provider details
```
GET /user/effective_providers/{pid}
```


##### Description
Returns information about a specific effective provider for the user.

This operation can be invoked on behalf of current user only.

***Example cURL requests***

**Get user effective provider**
```bash
curl -u username:password -X GET \
https://$HOST:8443/api/v3/onezone/user/effective_providers/oOVF-KrO1P6rpA0LFgNVI8NxuhxyQMUnrYzjAnKiyAY

{
  "providerId":"oOVF-KrO1P6rpA0LFgNVI8NxuhxyQMUnrYzjAnKiyAY",
  "urls": [
    "http://beta.onedata.org/provider1",
    "http://beta.onedata.org/provider2"
  ],
  "redirectionPoint": "http://beta.onedata.org/provider2",
  "latitude": 50.0647,
  "longitude": 19.9450
}
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**pid**  <br>*required*|Provider ID.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|Returns the information about a specific effective provider.|[ProviderDetails](../definitions/ProviderDetails.md#providerdetails)|
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
"/user/effective_providers/string"
```


##### Example HTTP response

###### Response 200
```
json :
{
  "name" : "Example provider",
  "providerId" : "H8ez0CwDZ7JMYRWn1ipmBpgJHPXzIXj0123upGkf9tk",
  "urls" : [ "http://beta.onedata.org/provider1", "http://beta.onedata.org/provider2" ],
  "redirectionPoint" : "http://beta.onedata.org/provider2",
  "latitude" : 50.0647,
  "longitude" : 19.945
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



