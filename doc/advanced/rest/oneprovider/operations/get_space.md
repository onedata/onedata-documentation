
<a name="get_space"></a>
#### Get basic space information
```
GET /spaces/{sid}
```


##### Description
Returns the basic information about space with given ID.

***Example cURL requests***

**Get information about a specific space**
```bash
curl --tlsv1.2 -X GET -H "X-Auth-Token: $TOKEN" \
"https://$HOST:8443/spaces/8f4b1e94-fdf8-4754-9962-edb01b2ee0f7"

{
    "name": "My Space 1",
    "providers": [
        {
            "providerId": "51306215-674a-47b7-afd1-54fa45bcaff7",
            "providerName": "MyPrivateCloud"
        },
        {
            "providerId": "0a568302-0f5e-454d-a6bc-7da7e1bfb985",
            "providerName": "PublicCloud1"
        }
    ],
    "spaceId": "8f4b1e94-fdf8-4754-9962-edb01b2ee0f7"
}
```


##### Parameters

|Type|Name|Description|Schema|Default|
|---|---|---|---|---|
|**Path**|**sid**  <br>*required*|Space ID.|string|--|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The space information.|[Space](../definitions/Space.md#space)|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|[Error](../definitions/Error.md#error)|
|**404**|Oneprovider REST API not available.|[Error](../definitions/Error.md#error)|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|


##### Produces

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/spaces/string"
```


##### Example HTTP response

###### Response 200
```
json :
{
  "spaceId" : "cda5d1bd-ca13-40ef-95e6-51fc1cc3b322",
  "name" : "My Space 1",
  "providers" : [ {
    "providerId" : "c40a3a39-0bbc-41cd-878f-5591f8c55014",
    "providerName" : "MyPrivateCloud"
  }, {
    "providerId" : "27d58af6-82ef-4bdd-a596-c4ff080fbde6",
    "providerName" : "PublicCloud1"
  } ]
}
```


###### Response 400
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



