
<a name="get_effective_group_provider"></a>
#### Get effective group's provider details
```
GET /groups/{id}/effective_providers/{pid}
```


##### Description
Returns information about a specific effective provider supporting groups spaces.

This operation requires `group_view` privilege.

***Example cURL requests***

**Get group's effective provider details**
```bash
curl -u username:password -X GET \
https://$HOST/api/v3/onezone/groups/HwUpk8jrwxKOe45uzLFX2GVC8lKEasj4q253sptVqF8/effective_providers/HUUPOMNGzikwiLXHaFYcE8-qxDtKmt1Gb3v5OnF9UNE

{
  "name": "provider1",
  "providerId": "HUUPOMNGzikwiLXHaFYcE8-qxDtKmt1Gb3v5OnF9UNE",
  "domain": "provider1.beta.onedata.org",
  "latitude": 50.0647,
  "longitude": 19.9450
}
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*|Group ID.|string|--|
|**Path**|**pid**  <br>*required*|Effective provider ID.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|Information about a specific provider supporting groups spaces.|[ProviderDetails](../definitions/ProviderDetails.md#providerdetails)|
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
"/groups/string/effective_providers/string"
```


##### Example HTTP response

###### Response 200
```
json :
{
  "name" : "Example provider",
  "providerId" : "H8ez0CwDZ7JMYRWn1ipmBpgJHPXzIXj0123upGkf9tk",
  "domain" : "provider1.beta.onedata.org",
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



