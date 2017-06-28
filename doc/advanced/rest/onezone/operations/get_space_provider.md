
<a name="get_space_provider"></a>
#### Get space provider details
```
GET /spaces/{id}/providers/{pid}
```


##### Description
Returns details about a specific provider supporting the space.

For users who are members of space it requires `space_view`.
For administrators who do not have to be members of this space,
`oz_spaces_list_providers` privilege is required.

***Example cURL requests***

**Get space provider details**
```bash
curl -u username:password -X GET \
https://$HOST:8443/api/v3/onezone/spaces/IkHBv8CoAFm5FCswhAJynbFU4fj26yiE1lhpK3p-0Y8/providers/H8ez0CwDZ7JMYRWn1ipmBpgJHPXzIXj0-upGkf9tk

{
  "providerId": "H8ez0CwDZ7JMYRWn1ipmBpgJHPXzIXj0-upGkf9tk",
  "name": "example",
  "urls": [
    "195.216.97.151"
  ],
  "redirectionPoint": "https://195.216.97.151",
  "latitude": 50.068968,
  "longitude": 19.909444
}
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**id**  <br>*required*|Space ID.|string|--|
|**Path**|**pid**  <br>*required*|Provider ID.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|Details about a specific provider supporting a space.|[ProviderDetails](../definitions/ProviderDetails.md#providerdetails)|
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
"/spaces/string/providers/string"
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



