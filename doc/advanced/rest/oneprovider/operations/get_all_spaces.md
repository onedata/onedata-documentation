
<a name="get_all_spaces"></a>
#### Get all spaces
```
GET /spaces
```


##### Description
Returns the list of all user spaces.

***Example cURL requests***

**List all user spaces**
```bash
curl --tlsv1.2 -X GET -H "X-Auth-Token: $TOKEN" "https://$HOST:8443/spaces"

[
  {
    "spaceId": "51306215-674a-47b7-afd1-54fa45bcaff7",
    "name": "Space1"
  },
  {
    "spaceId": "0a568302-0f5e-454d-a6bc-7da7e1bfb985",
    "name": "Space2"
  }
]
```


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|The list of all user spaces - containining their names and ID's.|< [Response 200](#get_all_spaces-response-200) > array|
|**400**|Invalid request.|[Error](../definitions/Error.md#error)|
|**403**|Forbidden request.|[Error](../definitions/Error.md#error)|
|**404**|Oneprovider REST API not available.|[Error](../definitions/Error.md#error)|
|**500**|Internal server error.|[Error](../definitions/Error.md#error)|

<a name="get_all_spaces-response-200"></a>
**Response 200**

|Name|Description|Schema|
|---|---|---|
|**name**  <br>*optional*|Space name.|string|
|**spaceId**  <br>*optional*|Space ID.|string|


##### Produces

* `application/json`


##### Example HTTP request

###### Request path
```
json :
"/spaces"
```


##### Example HTTP response

###### Response 200
```
json :
"array"
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



